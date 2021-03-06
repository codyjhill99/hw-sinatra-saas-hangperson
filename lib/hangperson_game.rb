class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses 
  attr_accessor :wrong_guesses
  # Get a word from remote "random word" service
  # def initialize()
  # end
  
 
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

   def guess(letter) 
    if (letter.nil? || letter.empty? || letter =~ /[^a-zA-Z]+/)
      raise (ArgumentError)
    end
    letter.downcase!
    if(!guesses.include? letter) && (!wrong_guesses.include? letter)
     if (word.include? letter) 
       @guesses += letter
     else
       @wrong_guesses += letter
     end
       
    else
      return false
    end
  end
end
