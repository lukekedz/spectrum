  class SiteController < ApplicationController
  before_action :ip_authorized?, only: [:last_upload, :stats_upload]
  skip_before_filter :verify_authenticity_token, only: :stats_upload

  def root
  end

  def single_page_app

  end

  def goals
    @min = Statistic.minimum(:g) - 25
    @max = Statistic.maximum(:g) + 25
  end

  def assists
    @min = Statistic.minimum(:a) - 25
    @max = Statistic.maximum(:a) + 25
  end

  def pim
    @min = Statistic.minimum(:pim) - 25
    @max = Statistic.maximum(:pim) + 25
  end

  def def
    @min = Statistic.minimum(:def) - 25
    @max = Statistic.maximum(:def) + 25
  end

  def granimation
    # @min = Statistic.minimum(:pim) - 25
    # @max = Statistic.maximum(:pim) + 25

    @jdub = Statistic.where(team_id: 1).map { |st| [st.created_at.to_s[5..9], st.pim] }
    @elko = Statistic.where(team_id: 2).map { |st| [st.created_at.to_s[5..9], st.pim] }
    @gsal = Statistic.where(team_id: 3).map { |st| [st.created_at.to_s[5..9], st.pim] }
    @pbts = Statistic.where(team_id: 4).map { |st| [st.created_at.to_s[5..9], st.pim] }
  end

  def ga_goals
    # if running seeds
    # @jdub31 = Statistic.where(team_id: 1).first(31).map { |st| [st.created_at.to_s[5..9], st.g] }
    # @gsal31 = Statistic.where(team_id: 3).first(31).map { |st| [st.created_at.to_s[5..9], st.g] }
    # @jdub   = Statistic.where(team_id: 1).map { |st| [st.created_at.to_s[5..9], st.g] }
    # @gsal   = Statistic.where(team_id: 3).map { |st| [st.created_at.to_s[5..9], st.g] }

    @jdub = []
    @gsal = []

    jdub_goals = 0
    gsal_goals = 0
    created_at = Time.new(2017, 10, 31)

    160.times do |i|
      rando = [0,0,0,0,0,1,1,1,1,2,2,2,3,3,4]

      jdub_goals += rando.sample
      @jdub.push([created_at.to_s[5..9], jdub_goals])

      gsal_goals += rando.sample
      @gsal.push([created_at.to_s[5..9], gsal_goals])

      created_at += (60 * 60 * 24)
    end
  end

  def stats_upload
    # Statistic.transaction do
    #   params['_json'][0].each do |row|
    #     team = Team.where(name: row['team'])
    #     record = Statistic.new(
    #       team_id: team[0].id,
    #       rk:    row['rk'],
    #       g:     row['g'],
    #       a:     row['a'],
    #       pim:   row['pim'],
    #       ppp:   row['ppp'],
    #       fow:   row['fow'],
    #       sog:   row['sog'],
    #       hit:   row['hit'],
    #       def:   row['def'],
    #       w:     row['w'],
    #       sv:    row['sv'],
    #       so:    row['so'],
    #       gaa:   row['gaa'],
    #       prcnt: row['prcnt'],
    #       )
    #   end

      # if record.save
        render :nothing => true, :status => 200
    #   else
    #     raise ActiveRecord::Rollback
    #     render :nothing => true, :status => 404
    #   end
    # end
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
    unless ENV['RASPI'] == request.remote_ip #&& ENV['SECRET'] == params[:secret]
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
