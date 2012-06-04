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

get '/jump/:name' do
  handle_jump(name, orb)
end

get '/jump' do
  handle_jump(params[:colour], orb)
end

def get_colour(name)
  colour = (Color::CSS[name])
  if (colour)
    colour = colour.to_rgb
  else
    colour = Color::RGB.from_html(name)
  end
  return colour
end

def show_form(method, colour, name) 
  return "<html><body style='background-color:#{"#%02x%02x%02x" % [colour.red, colour.green, colour.blue]}'><form name='input' action='#{method}' method='get'><input type='text' name='colour'></form><p/>#{name} (red: #{colour.red} green: #{colour.green} blue: #{colour.blue})</body></html>"
end

def handle_fade(name, orb)
  colour = get_colour(name)
  orb.fade_to(colour.red, colour.green, colour.blue)
  return show_form('/fade', colour,name)
end

def handle_jump(name, orb)
  colour = get_colour(name)
  orb.jump_to(colour.red, colour.green, colour.blue)
  return show_form('/jump', colour, name)
end

