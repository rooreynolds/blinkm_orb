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

get '/fade/:colour' do
  handle_fade(params[:colour], orb)
end

get '/fade' do
  handle_fade(params[:colour], orb)
end

def handle_fade(name, orb)
  color = (Color::CSS[name])
  if (color)
    color = color.to_rgb
  else
    color = Color::RGB.from_html(name)
  end
  orb.fade_to(color.red, color.green, color.blue)
  "<html><body style='background-color:#{"#%02x%02x%02x" % [color.red, color.green, color.blue]}'><form name='input' action='/fade' method='get'><input type='text' name='colour'></form><p/>#{name} (red: #{color.red} green: #{color.green} blue: #{color.blue})</body></html>"
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

