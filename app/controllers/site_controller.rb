class SiteController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def welcome
    page = HTTParty.get('http://games.espn.com/fhl/standings?leagueId=8266&seasonId=2017')

    categories = Nokogiri::HTML(page).css('#statsTable tr:nth-child(3) a')
    @categories = []
    categories.each do |row|
      @categories.push(row.text)
    end

    lk = Nokogiri::HTML(page).css('#statsTable tr:nth-child(4) td')
    @lk = []
    lk.each_with_index do |row, index|
      puts index.to_s + " " + row.to_s
      if index != 2 && index != 12 && index != 18 && index != 19 && index != 20
        @lk.push(row.text)
      end
    end

    mk = Nokogiri::HTML(page).css('#statsTable tr:nth-child(5) td')
    @mk = []
    mk.each_with_index do |row, index|
      puts index.to_s + " " + row.to_s
      if index != 2 && index != 12 && index != 18 && index != 19 && index != 20
        @mk.push(row.text)
      end
    end
    
  end

end
