require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/team")
require("./lib/player")
require("pg")

get("/") do
  erb(:index)
end

get('/manager') do
  @teams = Team.all()
  erb(:manager)
end

get('/coordinators') do
  @teams = Team.all()
  erb(:coordinators)
end

post('/teams') do
  name = params.fetch("name")
  coordinator = params.fetch("coordinator")
  team = Team.new({:name => name, :coordinator => coordinator, :id => nil})
  team.save()
  @teams = Team.all()
  erb(:manager)
end

get('/teams/:id/edit') do
  @team = Team.find(params.fetch("id").to_i())
  erb(:team_edit)
end

patch("/teams/:id") do
  name = params.fetch("name")
  @team = Team.find(params.fetch("id").to_i())
  @team.update({:name => name})
  @teams = Team.all()
  erb(:manager)
end

patch("/coordinator_update/:id") do
  coordinator = params.fetch("coordinator")
  @team = Team.find(params.fetch("id").to_i())
  @team.update({:coordinator => coordinator})
  @teams = Team.all()
  erb(:manager)
end

delete("/teams/:id") do
  @team = Team.find(params.fetch("id").to_i())
  @team.delete()
  @teams = Team.all()
  erb(:manager)
end

get('/coordinator/:id') do
  @teams = Team.all()
  @team = Team.find(params.fetch("id").to_i())
  @players = Player.all()
  erb(:coordinator)
end

post('/players/:id') do
  name = params.fetch("name")
  @team = Team.find(params.fetch("id").to_i())
  team_id = @team.id
  player = Player.new({:name => name, :team_id => team_id})
  player.save()
  @players = Player.all()
  erb(:coordinator)
end
