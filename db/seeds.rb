puts
puts "Seeding... "
puts

Team.create(abbr: "JDUB", name: "Joker's Wild")
Team.create(abbr: "KEDZ", name: "Elko Bugles")
Team.create(abbr: "GS",   name: "General Salami")
Team.create(abbr: "PBT",  name: "Philadelphia BallTappers")
Team.create(abbr: "COD",  name: "Cod Brind'amour")
Team.create(abbr: "SKUL", name: "Cass O'Wary's")
Team.create(abbr: "FOI",  name: "Foxes On Ice")
Team.create(abbr: "FLUX", name: "STATE  OF FLUX")
Team.create(abbr: "CUP",  name: "That's Why We Fucking Play")
Team.create(abbr: "SDET", name: "SD Belle")

# ga_goals route
# goals      = 0
# created_at = Time.new(2017, 10, 31)
# (6 * 30).times do |i|
# 	rando = [0,0,0,0,0,1,1,1,1,2,2,2,3,3,4].sample
# 	goals += rando

# 	Statistic.create(
# 		team_id:    1,
# 		g:          goals,
# 		created_at: created_at
# 	)

# 	created_at += (60 * 60 * 24)
# end

# goals      = 0
# created_at = Time.new(2017, 10, 31)
# (6 * 30).times do |i|
# 	rando = [0,0,0,0,0,1,1,1,1,2,2,2,3,3,4].sample
# 	goals += rando

# 	Statistic.create(
# 		team_id:    3,
# 		g:          goals,
# 		created_at: created_at
# 	)

# 	created_at += (60 * 60 * 24)
# end