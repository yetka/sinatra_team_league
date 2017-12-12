ENV['RACK_ENV'] = 'test'

require("rspec")
require("pg")
require("sinatra/activerecord")
require("team")
require("player")

RSpec.configure do |config|
  config.after(:each) do
    Player.all().each() do |player|
      player.destroy()
    end
    Team.all().each() do |team|
      team.destroy()
    end
  end
end
