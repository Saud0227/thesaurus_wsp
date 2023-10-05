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

    rows = CSV.read("public/data/#{word_type.capitalize}.csv").drop(1)

    @title = word_type.capitalize
    @word_type = word_type
    @all_rows = rows

    # puts rows
    erb :show_words
  end

  get '/words/:type/:index' do |word_type, index|
    data = CSV.read("public/data/#{word_type.capitalize}.csv").drop(1)[index.to_i]
    @title = data[0].capitalize + " Definition"
    @word_type = word_type
    @word_data = data

    erb :show_word
  end
end