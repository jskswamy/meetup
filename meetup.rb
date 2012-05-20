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

post '/topics' do
  @topics = RMeetup::Client.fetch(:topics, {:search => params[:search_term], :order => 'name'})
  with_base_layout :topics
end

get '/events/:topic_url_key' do
  @events = RMeetup::Client.fetch(:events, {:topic => params[:topic_url_key], :order => 'group'})
  without_layout :events
end

private

def with_base_layout template, options = {}
  erb template, options.merge(:layout => :'layout/base')
end

def without_layout template
  erb template
end