require 'sinatra/base'
require 'active_record'
require 'mysql2'
require 'json'
require 'yaml'

class MyApp < Sinatra::Base
  connection_setting = YAML.load(ERB.new(File.read('database.yml')).result)
  ActiveRecord::Base.establish_connection connection_setting['development']

  class User < ActiveRecord::Base
  end

  get '/ranking' do
    User.order(score: :desc).limit(50).to_json
  end

  run! if app_file == $0
end
