class Board
    BOARD_CLEANER = 100
    BOARD_MAX_INDEX = 9
    BOARD_MAX_SQ = (BOARD_MAX_INDEX + 1) ** 2
    EMPTY_POS = ' '
    @@counter = 0
    @@recent_play = 0
    @@recent_letter = ' '
    
    def initialize(current_player)
        @current_player = current_player
        @board = Array.new(BOARD_MAX_INDEX + 1) {
            Array.new(BOARD_MAX_INDEX + 1) {EMPTY_POS}
        }
    end
    
    def display
        num_count = BOARD_CLEANER
        for row in 0..BOARD_MAX_INDEX
            print "|"
            for col in 0..BOARD_MAX_INDEX
                s = @board[row][col]
                if s == EMPTY_POS
                    print num_count
                else
                    print " " + s + " "
                end
                print "|"
                num_count += 1
            end
            puts
            for i in 0..BOARD_MAX_INDEX
                print "----"
                i += 1
            end
            puts
        end
    end
    
    def board_full
        if @@counter == BOARD_MAX_SQ
            return true
        else 
            return false
        end
    end
    
    def ask_player_for_move(current_player)            
        while 1 < 2
            if current_player != "BOT"
                puts "Player " + current_player + ": What square would you like to play?"
                @@recent_play = gets.to_i - BOARD_CLEANER
                puts "Player " + current_player + ": What would you like to play?"
                @@recent_letter = gets.chomp
            else 
                @@recent_play, @@recent_letter = computer_move
            end
            
            if validate_position(@@recent_play, @@recent_letter)
                column = @@recent_play % (BOARD_MAX_INDEX + 1)
                row = @@recent_play / (BOARD_MAX_INDEX + 1)
                @board[row][column] = @@recent_letter
                @@counter += 1
                return check_win(@@recent_play, @@recent_letter)
            end
        end
    end
    
    def validate_position(play, letter)
        if play >= (BOARD_MAX_INDEX + 1) ** 2 or play < 0
            puts "Position invalid, please try again"
            return false
        end
        column = play % (BOARD_MAX_INDEX + 1)
        row = play / (BOARD_MAX_INDEX + 1)
        if row <= BOARD_MAX_INDEX and column <= BOARD_MAX_INDEX
            if @board[row][column] == EMPTY_POS
                if letter == 'S' or letter == 'O'
                    return true
                else 
                    puts "Need and S or and O"
                end
            else 
                puts "Position taken, please try again"
            end
        else
            puts "Position invalid, please try again"
        end
        return false
    end
    
    def get_next_turn
        @current_player == 'R' ? @current_player = 'B' : @current_player = 'R'
        return @current_player
    end

    def check_square(play)
        if play < 0
            return " "
        end
        column = play % (BOARD_MAX_INDEX + 1)
        row = play / (BOARD_MAX_INDEX + 1)
        if row <= BOARD_MAX_INDEX and column <= BOARD_MAX_INDEX
            return @board[row][column]
        else 
            return " "
        end
    end
    
    def check_win(play, letter)
        temp_play = play
        win = 0
        if letter == 'O'
            #Check horizontal and one vertical
            #  x
            #xxx
            #x 
            if check_square(temp_play + 1) == 'S'               
                if check_square(temp_play - 1) == 'S'
                    win += 1
                end
            end
            if check_square(temp_play - BOARD_MAX_INDEX) == 'S'
                if check_square(temp_play + BOARD_MAX_INDEX) == 'S'
                    win += 1
                end
            end
            
            #Check vertical and the other vertical
            #xx
            # x
            # xx
            if check_square(temp_play + BOARD_MAX_INDEX + 1) == 'S'
                if check_square(temp_play - BOARD_MAX_INDEX - 1) == 'S'
                    win += 1
                end
            end
            if check_square(temp_play + BOARD_MAX_INDEX + 2) == 'S'
                if check_square(temp_play - BOARD_MAX_INDEX - 2) == 'S'
                    win += 1
                end
            end
            
        elsif letter == 'S'
            #Check horizontal
            if check_square(temp_play + 1) == 'O'
                if check_square(temp_play + 2) == 'S'
                    win += 1
                end
            end  
            if check_square(temp_play - 1) == 'O'
                if check_square(temp_play - 2) == 'S'
                    win += 1
                end
            end
            
            #Check vertical
            if check_square(temp_play + BOARD_MAX_INDEX + 1) == 'O'
                if check_square(temp_play + 2 * BOARD_MAX_INDEX + 2) == 'S'
                    win += 1
                end
            end            
            if check_square(temp_play - BOARD_MAX_INDEX - 1) == 'O'
                if check_square(temp_play - 2 * BOARD_MAX_INDEX - 2) == 'S'
                    win += 1
                end
            end
            
            #Check diagonal
            if check_square(temp_play - BOARD_MAX_INDEX) == 'O'
                if check_square(temp_play - 2 * BOARD_MAX_INDEX) == 'S'
                    win += 1
                end
            end
            if check_square(temp_play + BOARD_MAX_INDEX) == 'O'
                if check_square(temp_play + 2 * BOARD_MAX_INDEX) == 'S'
                    win += 1
                end
            end
            
            if check_square(temp_play - BOARD_MAX_INDEX - 2) == 'O'
                if check_square(temp_play - 2 * (BOARD_MAX_INDEX + 2)) == 'S'
                    win += 1
                end
            end
            if check_square(temp_play + BOARD_MAX_INDEX + 2) == 'O'
                if check_square(temp_play + 2 * (BOARD_MAX_INDEX + 2)) == 'S'
                    win += 1
                end
            end
        end
        return win
    end
    
    def computer_move
        max_score = 0
        preferred_move = -1
        letter = ' '
        for i in 0..BOARD_MAX_SQ
            play = i
            if check_square(i) != ' ' 
                next
            end
            if self.check_win(i, 'S') > max_score
                max_score = self.check_win(i, 'S')
                preferred_move = i
                letter = 'S'
            end
            if self.check_win(i, 'O') > max_score
                max_score = self.check_win(i, 'O')
                preferred_move = i
                letter = 'O'
            end
        end
        if max_score == 0
            while 1 < 2
                preffered_move = rand(BOARD_MAX_SQ)
                column = play % (BOARD_MAX_INDEX + 1)
                row = play / (BOARD_MAX_INDEX + 1)
                if rand(3) >= 1
                    letter = 'S'
                else
                    letter = 'O'
                end
                if validate_position(preffered_move, letter)
                    return preffered_move, letter
                end
            end     
        else
            return preferred_move, letter
        end
    end
    
end
