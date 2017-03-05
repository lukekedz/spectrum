require 'nokogiri'
require 'httparty'
require 'pg'

puts "anyong!!!"

response = HTTParty.post('http://localhost:3000/site/stats_upload',
                         :headers => { 'Content-Type' => 'application/json' }
                        )
puts response.inspect