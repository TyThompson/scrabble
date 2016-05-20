require 'pry'


class Scrabble
  attr_reader :m, :i, :t, :s, :m2, :i2, :t2, :s2, :gameover, :word



  def passcheck?(i,i2)
    if i.downcase == "passyes" && i2.downcase == "passyes"
      print "Ending game because both players passed."
      return true
    end
  end

  def quitcheck?(i,i2)
    if i.downcase == "quityes" || i2.downcase == "quityes"
      print "Ending game because a player quit."
      return true
    end
  end

  def noscorecheck?(word)
    word == "quityes" || word == "passyes" || word.to_i<0
  end

  def wordvalidate?(word)
    dict = File.read("scrabbledict.txt").downcase
    # word = "word"
    dict.include?(word.downcase)
  end


  def wordscore(word)
    word = word.split("")
    score = 0
    letterkey = { "a" => 1, "e" => 1, "i" => 1, "o" => 1, "u" => 1, "l" => 1, "n" => 1, "r" => 1, "s" => 1, "t" => 1,
                  "d" => 2, "g" => 2,
                  "b" => 3, "c" => 3, "m" => 3, "p" => 3,
                  "f" => 4, "h" => 4, "v" => 4, "w" => 4, "y" => 4,
                  "k" => 5,
                  "j" => 8, "x" => 8,
                  "q" => 10,"z" =>10 }
    word.each do |letter|
      if letterkey.include?(letter)
        score += letterkey[letter]
      end
    end
    score
  end

  # def player_wants_to_quit?
  #   puts "Do you want to keep playing (y/n)?"
  #   input = gets.chomp
  #   input == "n"
  # end

  scrabble = Scrabble.new()
  m = 0 #Player 1 max
  i = 0 #Player 1 input
  t = 0 #Player 1 total
  s = 0 #Player 1 Score
  m2 = 0 #Player 2 max
  i2 = 0 #Player 2 input
  t2 = 0 #Player 2 total
  s2 = 0 #Player 2 Score

  loop do
    print "Type score for Player 1: "
    i = gets.chomp
    print "Type score for Player 2: "
    i2 = gets.chomp
    break if scrabble.quitcheck?(i,i2)
    break if scrabble.passcheck?(i,i2)
    if scrabble.noscorecheck?(i)
      s = 0
      print "Player 1 is awarded no points this round."
    elsif /^[a-zA-Z]*$/.match(i) && scrabble.wordvalidate?(i)
      s = scrabble.wordscore(i)
    else
      s = i.to_i
    end
    #calculating p1 score
    t += s
    if s > m
      m = s
    end

    if scrabble.noscorecheck?(i2)
      s2 = 0
      print "Player 2 is awarded no points this round."
    elsif /^[a-zA-Z]*$/.match(i2) && scrabble.wordvalidate?(i2)
      s2 = scrabble.wordscore(i2)
    else
      s2 = i2.to_i
    end
    #calculating p2 score
    t2 += s2
    if s2 > m2
      m2 = s2
    end
    puts
    #print results
    print "Player 1 Total: ", t
    puts
    print  "Player 1 Max: ", m
    puts
    print "Player 2 Total: ", t2
    puts
    print "Player 2 Max: ", m2
    puts

    # break if scrabble.player_wants_to_quit?
  end
  puts
  #print results
  print "Player 1 Total: ", t
  puts
  print  "Player 1 Max: ", m
  puts
  print "Player 2 Total: ", t2
  puts
  print "Player 2 Max: ", m2
  puts

  #creating the final scoresheet
  fname = "scoresheet.txt"
  file = File.open(fname, "w")
  file.print "Player 1 Total: ", t
  file.puts
  file.print  "Player 1 Max: ", m
  file.puts
  file.print "Player 2 Total: ", t2
  file.puts
  file.print  "Player 2 Max: ", m2
  file.puts
  file.close
end
