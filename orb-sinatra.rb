require 'rubygems'
require 'sinatra'
require "sinatra/reloader"
require 'color/css'
require './Orb.rb'
orb = Orb.new
orb.stop # stop the BlinkM cycling through colours.

get '/' do
  "Hello. Try /fade/red or /fade/ff0000"
end

get '/fade/:name' do
  name = params[:name]
  color = (Color::CSS[name])
  if (color)
    color = color.to_rgb
  else
    color = Color::RGB.from_html(name)
  end
  orb.fade_to(color.red, color.green, color.blue)
  "#{name} (red: #{color.red} green: #{color.green} blue: #{color.blue})"
end

get '/jump/:name' do
  name = params[:name]
  color = (Color::CSS[name])
  if (color)
    color = color.to_rgb
  else
    color = Color::RGB.from_html(name)
  end
  orb.jump_to(color.red, color.green, color.blue)
  "#{name} (red: #{color.red} green: #{color.green} blue: #{color.blue})"
end

