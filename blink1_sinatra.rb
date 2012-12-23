require 'rubygems'
require 'sinatra'
require "sinatra/reloader"
require 'color/css'

get '/' do
  "Hello. Try /fade/red or /fade/ff0000"
end

get '/fade/?:colour?' do
  handle_fade(params[:colour])
end

get '/jump/?:colour?' do
  handle_jump(params[:colour])
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

def handle_fade(name)
  colour = get_colour(name)
  `blink1-tool --rgb #{colour.red},#{colour.green},#{colour.blue} -m 2000`
  return show_form('/fade', colour,name)
end

def handle_jump(name)
  colour = get_colour(name)
  `blink1-tool --rgb #{colour.red},#{colour.green},#{colour.blue} -m 0`
  return show_form('/jump', colour, name)
end

