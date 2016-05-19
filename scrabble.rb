require 'pry'

class Scrabble
attr_reader :m, :i, :t, :s, :m2, :i2, :t2, :s2, :gameover, :word

def initialize
	@m = 0 #Player 1 max
	@i = 0 #Player 1 input
	@t = 0 #Player 1 total
	@s = 0 #Player 1 Score
	@m2 = 0 #Player 2 max
	@i2 = 0 #Player 2 input
	@t2 = 0 #Player 2 total
	@s2 = 0 #Player 2 Score
end

def passcheck (i, i2)
    if i.downcase == "passyes" && i2.downcase == "passyes"
	  #print results
	  print "Ending game because both players passed."
	return true
    elsif i.downcase == "passyes"
	  @s = 0
	  puts "Player 1 passed."
    elsif i2.downcase == "passyes"
	  @s2 = 0
	  puts "Player 2 passed."
    end
end

def quitcheck(i, i2)
	if i.downcase == "quityes"
		return true
	end
    if i2.downcase == "quityes"
	  return true
    end
end

def negativecheck_p1(i)
	if i.to_i<0
		@s = 0
		puts "Player 1 entered a negative number. No points given."
    end
end

def negativecheck_p2(i2)
    if i2.to_i<0
      @s2 = 0
      puts "Player 2 entered a negative number. No points given."
    end
end

def wordscore_p1(word)
    word = word.split("")
    letterkey = { "a" => 1, "e" => 1, "i" => 1, "o" => 1, "u" => 1, "l" => 1, "n" => 1, "r" => 1, "s" => 1, "t" => 1,
                  "d" => 2, "g" => 2,
                  "b" => 3, "c" => 3, "m" => 3, "p" => 3,
                  "f" => 4, "h" => 4, "v" => 4, "w" => 4, "y" => 4,
                  "k" => 5,
                  "j" => 8, "x" => 8,
                  "q" => 10,"z" =>10 }
	 word.each() do |letter|
		 @s = letterkey[letter]
		 @t = @t+@s
	end	
end

def wordscore_p2(word)
    word = word.split("")
    letterkey = { "a" => 1, "e" => 1, "i" => 1, "o" => 1, "u" => 1, "l" => 1, "n" => 1, "r" => 1, "s" => 1, "t" => 1,
                  "d" => 2, "g" => 2,
                  "b" => 3, "c" => 3, "m" => 3, "p" => 3,
                  "f" => 4, "h" => 4, "v" => 4, "w" => 4, "y" => 4,
                  "k" => 5,
                  "j" => 8, "x" => 8,
                  "q" => 10,"z" =>10 }
	 word.each() do |letter|
		 @s2 = letterkey[letter]
		 @t2 = @t2+@s2
	end	
end	

def scoresheet
	  puts
	  #print results
	  print "Player 1 Total: ", @t
	  puts
	  print  "Player 1 Max: ", @m
	  puts
	  print "Player 2 Total: ", @t2
	  puts
	  print "Player 2 Max: ", @m2
	  puts

	  #creating the final scoresheet
	  fname = "scoresheet.txt"
	  file = File.open(fname, "w")
	  file.print "Player 1 Total: ", @t
	  file.puts
	  file.print  "Player 1 Max: ", @m
	  file.puts
	  file.print "Player 2 Total: ", @t2
	  file.puts
	  file.print  "Player 2 Max: ", @m2
	  file.puts
	  file.close
end

def scoreupdate(s, s2)
    @t += s
    @t2 += s2
    #check if input is the new max score this round
    if s > @m
	  @m = s
	end
	if s2 > @m2
	 @m2 = s2
	end
end

end

scrabble = Scrabble.new()
gameover = false
until gameover == true
	print "Type score for Player 1: "
	i = gets.chomp
	print "Type score for Player 2: "
	i2 = gets.chomp
	gameover = scrabble.quitcheck(i,i2)
	gameover = scrabble.passcheck(i,i2)
	break if gameover
	if /^[a-zA-Z]*$/.match(i)
		scrabble.wordscore_p1(i)
	else
		scrabble.negativecheck_p1(i)
	end
	

	if /^[a-zA-Z]*$/.match(i2)
		scrabble.wordscore_p2(i2)
	else
		scrabble.negativecheck_p2(i2)
	end
	scrabble.scoreupdate(scrabble.s, scrabble.s2)
	scrabble.scoresheet
end
scrabble.scoresheet