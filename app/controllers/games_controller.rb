require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    charset = %w{ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
    @letters = (0..10).map { charset.to_a[rand(charset.size)] }.join
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_check = URI.open(url).read
    word = JSON.parse(word_check)

    if word["found"]
      included = []
      @letters.downcase.split.each do |letter|
        if @letters.include?(letter)
          @letters.slice!(@letters.index(letter))
        else
          return false
        end
      end

      if included.count(true) != @word.size
        @result = "Not included in #{@letters}"
      else
        @result = "Congratulations! #{@word.upcase} is a valid English word!"
      end
    else
      @result = "Sorry but #{@word.upcase} not a real word"
    end
  end
end
