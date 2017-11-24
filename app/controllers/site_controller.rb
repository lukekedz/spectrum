class SiteController < ApplicationController
  before_action :ip_authorized?, only: [:last_upload, :stats_upload]
  skip_before_filter :verify_authenticity_token, only: :stats_upload

  def root
  end

  def static_chartkick
    @teams = Team.all
  end

  def static_chartkick_modal
    # ajax call; data is appended to div, which is opened by js/Materialize on success

    categories = {
      'g':     'Goals', 
      'a':     'Assists',
      'pim':   'Penalty Minutes',
      'ppp':   'Power Play Points',
      'fow':   'Faceoffs Won',
      'sog':   'Shots on Goal',
      'hit':   'Hits',
      'def':   'Defensemen Points',
      'w':     'Wins',
      'sv':    'Saves',
      'so':    'Shutouts',
      'gaa':   'Goals Against Average', 
      'prcnt': 'Save Percentage'
    }
    
    @chart_object = []
    @category     = categories[params[:category].to_sym]

    teams = Team.where(id: params[:teams])
    teams.each do |team| 
      category_stats = Statistic.where(team_id: team.id).map{ |stat| [stat.created_at.to_s[5..9], stat[params[:category].to_sym]] }

      @chart_object.push([team.name, category_stats])
    end

    render :layout => false
  end

  def stats_upload
    # TODO: catch error if a team name changes
    Statistic.transaction do
      params['_json'][0].each_with_index do |row, index|
        if index != 0
          team = Team.where(name: row['team'])
          record = Statistic.new(
            team_id: team[0].id,
            rk:    row['rk'],
            g:     row['g'],
            a:     row['a'],
            pim:   row['pim'],
            ppp:   row['ppp'],
            fow:   row['fow'],
            sog:   row['sog'],
            hit:   row['hit'],
            def:   row['def'],
            w:     row['w'],
            sv:    row['sv'],
            so:    row['so'],
            gaa:   row['gaa'],
            prcnt: row['prcnt'],
          )

          if !record.save
            raise ActiveRecord::Rollback
            render :nothing => true, :status => 404
          end
        end
      end
    end

    render :nothing => true, :status => 200
  end

  def last_twelve
    @stats = Statistic.last(12)
    respond_to do |format|
      format.html { render :json => @stats, :layout => false }
    end
  end

  def last_upload
    page = HTTParty.get('http://games.espn.com/fhl/standings?leagueId=8266&seasonId=2018')

    categories  = Nokogiri::HTML(page).css('#statsTable tr:nth-child(3) a')
    @categories = []
    categories.each { |category| @categories.push category.text }

    @records = Statistic.last(12)
    @count = Statistic.count
    @date = Statistic.last.created_at
  end

private

  def ip_authorized?
    unless ENV['RASPI'] == request.remote_ip && ENV['SECRET'] == params['_json'][0][0]
      puts '******************************'
      puts request
      puts request.inspect
      puts request.remote_ip.inspect
      puts
      puts '******************************'

      respond_to do |format|
        format.html { render :file => '#{Rails.root}/public/404', :layout => false, :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end
  end
end
