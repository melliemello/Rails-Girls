require 'sinatra'
require "sinatra/reloader" if development?
require 'yaml'
require './models/database'
require './models/model'
require './models/idea'


# get '/' do 
#   @ideas = Idea.db.all
#   erb :index, :layout=>:head
# end


get '/' do 
    @ideas = Idea.all
    erb :index, :layout=>:head
end

get '/new' do
  erb :new, :layout => :head
end

post '/new' do
  attributes = Hash[params.map{|key,value| [key.to_sym, value]}]
  Idea.new(attributes).save
  "The idea was saved"
  redirect to ("/")
end

get '/full/:id' do
  id = params[:id].to_i
  @idea = Idea.find(id)
  erb :full, :layout => :head
end

get '/edit' do
  @id = params[:id].to_i
  @idea = Idea.find(@id)
  erb :edit, :layout => :head
end

post '/edit' do
  id = params[:id].to_i
  attributes = Hash[params.map{|key,value| [key.to_sym, value]}]
  idea = Idea.new(attributes, id)
  idea.save
  "The idea was edited"
end

post '/delete' do
  @params = params.map {|_, id| id}
  Idea.delete_many(params)
  erb :delete, :layout => :head
end

get '/delete' do
  id = params[:id].to_i
  Idea.find(id).delete
  redirect to ("/")
end




# 

#Check & go

# values = {:short_description=>"00000000000000000", :some_val =>"some other value", :id => nil}
# idea = Idea.new(values)
# # p idea.attributes
# p idea.id = 3
# idea.save 3

# p idea.attributes

# Idea.create(values)
# p Idea.all

# all_entries = {6=>{:title=>"Title", :short_description=>"f", :idea_body=>""}, 7=>{:title=>"Title", :short_description=>"f", :idea_body=>""}, 8=>{:title=>"Title", :short_description=>"f", :idea_body=>""}}

# attributes = [:title]
# # a.each{|k,v| v.each {|key,value| p key}}
# b = a.map{|k,v| v.select{|key, attr| attributes.include?(key)}}
# b = a.map{|k,v| { k => v.select{|key, attr| attributes.include?(key)}}}
# c= a.reduce({}){|hash, (id,entry)| hash.merge(id => entry.select{|key, value| attributes.include?(key)})}

# p c

