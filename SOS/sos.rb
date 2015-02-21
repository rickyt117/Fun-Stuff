require_relative 'board.rb'

players = ['R', 'B']
r_score = 0;
b_score = 0;

puts "Starting SOS"

puts "PVP or PVE?"

game = gets.chomp

current_player = 'B'
b = Board.new('B')
b.display()
puts

while not b.board_full()
    if current_player == 'B'
        b_score += b.ask_player_for_move(current_player)
    end
    
    if current_player == 'R'
        if game == "PVP"
            r_score += b.ask_player_for_move(current_player)
        elsif game == "PVE" 
            r_score += b.ask_player_for_move("BOT")
        end
    end
    current_player = b.get_next_turn()
    b.display()
    puts "R SCORE: " + r_score.to_s + " B SCORE: " + b_score.to_s
end

if r_score > b_score
    puts "R WINS"
elsif b_score > r_score
    puts "B WINS"
else
    puts "TIE"
end
