# frozen_string_literal: true

class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end