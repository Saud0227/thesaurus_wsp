# frozen_string_literal: true
require 'csv'

class App < Sinatra::Base

  @@allowed_word_types = ['nouns', 'verbs', 'adverbs', 'adjectives']

  get '/' do
    @title = "Hello World"
    erb :index
  end

  get '/words' do
    @title = "Words"
    erb :words
  end

  get '/words/:type' do |word_type|
    unless @@allowed_word_types.include?(word_type)
      redirect '/words'
    end

    rows = CSV.read("/public/data/#{word_type.capitalize}.csv")

    @title = word_type.capitalize
    @word_type = word_type
    @words = rows

    puts rows
    erb :show_words
  end
end