require_relative 'board.rb'

puts "Starting SOS"

players = ['R', 'B']
r_score = 0;
b_score = 0;

current_player = players[rand(2)]
b = Board.new(current_player)
b.display()
puts

while not b.board_full()
    b.ask_player_for_move(current_player)
    current_player = b.get_next_turn()
    if current_player == 'B'
        r_score += b.check_win()
    else 
        b_score += b.check_win()
    end
    b.display()
    puts "R SCORE: " + r_score.to_s + " B SCORE: " + b_score.to_s
end

if r_score > b_score
    puts "R WINS"
else 
    puts "B WINS"
end
