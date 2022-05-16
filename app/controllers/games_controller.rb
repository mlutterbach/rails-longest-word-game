require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    charset = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
    @letters = (0..10).map { charset.to_a[rand(charset.size)] }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
