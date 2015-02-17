class Board
    BOARD_CLEANER = 100
    BOARD_MAX_INDEX = 9
    EMPTY_POS = ' '
    @@counter = 0
    @@recent_letter = ' '
    @@recent_play = 0
    
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
        if @@counter == (BOARD_MAX_INDEX + 1) ** 2
            return true
        else 
            return false
        end
    end
    
    def ask_player_for_move(current_player)
        played = false
        while not played
            puts "Player " + current_player + ": What square would you like to play?"
            @@recent_play = gets.to_i - BOARD_CLEANER
            puts "Player " + current_player + ": What would you like to play?"
            @@recent_letter = gets.chomp
            column = @@recent_play % (BOARD_MAX_INDEX + 1)
            row = @@recent_play / (BOARD_MAX_INDEX + 1)
            if validate_position(@@recent_play, row, column, @@recent_letter)
                @board[row][column] = @@recent_letter
                played = true
                @@counter += 1
            end
        end
    end
    
    def validate_position(play, row, column, letter)
        if play >= (BOARD_MAX_INDEX + 1) ** 2 or play < 0
            puts "Position invalid, please try again"
            return false
        end
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
    
    def check_win
        temp_recent = @@recent_play
        win = 0
        if @@recent_letter == 'O'
            #Check horizontal and one vertical
            #  x
            #xxx
            #x 
            if check_square(temp_recent + 1) == 'S'               
                if check_square(temp_recent - 1) == 'S'
                    win += 1
                end
            end
            if check_square(temp_recent - BOARD_MAX_INDEX + 2) == 'S'
                if check_square(temp_recent + BOARD_MAX_INDEX) == 'S'
                    win += 1
                end
            end
            
            #Check vertical and the other vertical
            #xx
            # x
            # xx
            if check_square(temp_recent + BOARD_MAX_INDEX + 1) == 'S'
                if check_square(temp_recent - BOARD_MAX_INDEX - 1) == 'S'
                    win += 1
                end
            end
            if check_square(temp_recent + BOARD_MAX_INDEX + 2) == 'S'
                if check_square(temp_recent - BOARD_MAX_INDEX - 2) == 'S'
                    win += 1
                end
            end
            
        elsif @@recent_letter == 'S'
            #Check horizontal
            if check_square(temp_recent + 1) == 'O'
                if check_square(temp_recent + 2) == 'S'
                    win += 1
                end
            end  
            if check_square(temp_recent - 1) == 'O'
                if check_square(temp_recent - 2) == 'S'
                    win += 1
                end
            end
            
            #Check vertical
            if check_square(temp_recent + BOARD_MAX_INDEX + 1) == 'O'
                if check_square(temp_recent + 2 * BOARD_MAX_INDEX + 2) == 'S'
                    win += 1
                end
            end            
            if check_square(temp_recent - BOARD_MAX_INDEX - 1) == 'O'
                if check_square(temp_recent - 2 * BOARD_MAX_INDEX - 2) == 'S'
                    win += 1
                end
            end
            
            #Check diagonal
            if check_square(temp_recent - BOARD_MAX_INDEX) == 'O'
                if check_square(temp_recent - 2 * BOARD_MAX_INDEX) == 'S'
                    win += 1
                end
            end
            if check_square(temp_recent + BOARD_MAX_INDEX) == 'O'
                if check_square(temp_recent + 2 * BOARD_MAX_INDEX) == 'S'
                    win += 1
                end
            end
            
            if check_square(temp_recent - BOARD_MAX_INDEX - 2) == 'O'
                if check_square(temp_recent - 2 * (BOARD_MAX_INDEX + 2)) == 'S'
                    win += 1
                end
            end
            if check_square(temp_recent + BOARD_MAX_INDEX + 2) == 'O'
                if check_square(temp_recent + 2 * (BOARD_MAX_INDEX + 2)) == 'S'
                    win += 1
                end
            end
        end
        return win
    end
end
