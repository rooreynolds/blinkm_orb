require 'rubygems'
require 'sinatra'
require "sinatra/reloader"
require 'color/css'
require './Orb.rb'
orb = Orb.new
orb.stop # stop the BlinkM cycling through colours.

get '/' do
  "Try /fade/red"
end

get '/fade/:name' do
  name = params[:name]
  color = (Color::CSS[name]).to_rgb
  orb.fade_to(color.red, color.green, color.blue)
  "#{name} (red: #{color.red} green: #{color.green} blue: #{color.blue})"
end

get '/jump/:name' do
  name = params[:name]
  color = (Color::CSS[name]).to_rgb
  orb.jump_to(color.red, color.green, color.blue)
  "#{name} (red: #{color.red} green: #{color.green} blue: #{color.blue})"
end

