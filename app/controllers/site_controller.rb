  class SiteController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def root
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

  def scrape
    # page = HTTParty.get('http://games.espn.com/fhl/standings?leagueId=8266&seasonId=2017')

    # categories  = Nokogiri::HTML(page).css('#statsTable tr:nth-child(3) a')
    # @categories = []
    # categories.each { |category| @categories.push category.text }

    # @team  = Team.find(1)
    # @stats = Statistic.where(team_id: 1)

    # @stats = Statistic.all
    # @stats = [[0,0],[100,150],[225,325],[336,563],[455,880],[609,420],[722,211]]

    @stats = []

    # http://chartkick.com/
    # http://stackoverflow.com/questions/27590771/rails-chartkick-want-only-integer-values-on-axes-use-discrete-or-something-els
    Statistic.where(team_id: 1).each do |row|
      # @category = []
      # @category.push [row.created_at.to_s[5..9], row.g]
      @stats.push [row.created_at.to_s[5..9], row.g]
    end

    # @stats.push @category

    # Statistic.where(team_id: 1).each do |row|
    #   @category = []
    #   @category.push [row.created_at.to_s[5..9], row.a]
    # end

    # @stats.push @category

    # iterate for set min/max from data
    @sk_min = 100
    @sk_max = 5000

    @g_min = 0
    @g_max = 125
  end

  def stats_upload
    # json_req = nil

    # TO DO: must be a more elegant way to do this
    # request.headers.each do |h|
    #   if h[0] == "CONTENT_TYPE" && h[1] == "application/json"
    #     json_req = true
    #   end
    # end

    # puts params.inspect
    # puts params["_json"][0]["team"].inspect

    # team = Team.where(name: params["_json"][0]["team"])
    # puts team.inspect
    puts

    params["_json"][0].each do |row|
      # puts "ROW: " + row.inspect
      # puts "INC TEAM: " + row["team"].inspect

      team = Team.where(name: row["team"])
      # puts "TEAM ID: " + team[0].id.inspect
      # puts

    # if json_req == true
      record = Statistic.create(
        team_id: team[0].id,
        rk:    row["rk"],
        g:     row["g"],
        a:     row["a"],
        pm:    row["pm"],
        pim:   row["pim"],
        ppp:   row["ppp"],
        fow:   row["fow"],
        sog:   row["sog"],
        hit:   row["hit"],
        def:   row["def"],
        w:     row["w"],
        sv:    row["sv"],
        so:    row["so"],
        gaa:   row["gaa"],
        prcnt: row["prcnt"],
        )
    end

      # if record.save
        render :nothing => true, :status => 200
      # else
        # render :nothing => true, :status => 400
      # end
    # else
      # TO DO: return error (inc logging)
    # end
  end

  def last_upload
    page = HTTParty.get('http://games.espn.com/fhl/standings?leagueId=8266&seasonId=2017')

    categories  = Nokogiri::HTML(page).css('#statsTable tr:nth-child(3) a')
    @categories = []
    categories.each { |category| @categories.push category.text }

    @records = Statistic.last(10)
    @count = Statistic.count
    @date = Statistic.last.created_at
  end

end
