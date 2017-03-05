  class SiteController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def scrape
    page = HTTParty.get('http://games.espn.com/fhl/standings?leagueId=8266&seasonId=2017')

    categories  = Nokogiri::HTML(page).css('#statsTable tr:nth-child(3) a')
    @categories = []
    categories.each { |category| @categories.push category.text }

    @stats = []
    skip   = [2, 12, 18, 19, 20]

    i = 4
    while i <= 13
      nth_row = i.to_s
      row = Nokogiri::HTML(page).css('#statsTable tr:nth-child(' + nth_row + ') td')

      team_data = []
      row.each_with_index do |data, index|
        if !skip.include? index then team_data.push data.text end
      end

      @stats.push team_data
      i += 1
    end
  end

  def stats_upload
    json_req = nil

    # TO DO: must be a more elegant way to do this
    request.headers.each do |h|
      if h[0] == "CONTENT_TYPE" && h[1] == "application/json"
        json_req = true
      end
    end

    if json_req == true
      render :nothing => true, :status => 200
    else
      # TO DO: return error (inc logging)
    end
  end

end
