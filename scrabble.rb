#1 player, type in a # and gives running total and max
#max is over lifetime of entries
#lvl 2, 2 player
#lvl 3, save to a File


m = 0 #Player 1 max
i = 0 #Player 1 input
t = 0 #Player 1 total
s = 0 #Player 1 Score
m2 = 0 #Player 2 max
i2 = 0 #Player 2 input
t2 = 0 #Player 2 total
s2 = 0 #Player 2 Score

until i == "quit" || i2 == "quit"
  print "Type score for Player 1: "
  i = gets.chomp
  if i.downcase == "quit"
	break
  else
	print "Type score for Player 2: "
	i2 = gets.chomp
    if i2.downcase == "quit"
	  break
    else

      s = i.to_i
      s2 = i2.to_i
      if s<0
        s = 0
        puts "Player 1 entered a negative number. No points given."
    end
    if s2<0
      s2 = 0
      puts "Player 2 entered a negative number. No points given."
    end

    if i.downcase == "pass" && i2.downcase == "pass"
	  #print results
	  print "Ending game because both players passed."
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
	  break
    elsif i.downcase == "pass"
	  s = 0
	  puts "Player 1 passed."
    elsif i2.downcase == "pass"
	  s2 = 0
	  puts "Player 2 passed."
    end

    t += s
    t2 += s2
    #check if input is the new max score this round
    if s > m
	  m = s
	end
	if s2 > m2
	  m2 = s2
	end

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
  end
end