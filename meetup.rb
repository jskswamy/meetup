require 'rubygems'
require 'sinatra'
require 'sinatra/content_for'
require 'yaml'
require 'rMeetup'

APP_CONFIG = YAML::load(File.read(File.expand_path('config/app.yml','.')))

RMeetup::Client.api_key = APP_CONFIG["meetup_api_key"]

get '/' do
  with_base_layout :index
end

get '/topics/:search_term' do
  content_type :json
  topics = RMeetup::Client.fetch(:topics, {:search => params[:search_term]})
  result = topics.map { |topic| {:id => topic.id, :name => topic.name, :urlkey => topic.urlkey, :description => topic.description} }
  result.to_json
end

private

def with_base_layout template, options = {}
  erb template, options.merge(:layout => :'layout/base')
end