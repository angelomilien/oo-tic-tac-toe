
class TicTacToe
    
    attr_reader :board

    def initialize
        @board = Array.new(9, " ") 
    end

    WIN_COMBINATIONS = [
        [0,1,2], # top_row 
        [3,4,5], # middle_row 
        [6,7,8], # bottom_row 
        [0,3,6], # left_column 
        [1,4,7], # center_column 
        [2,5,8], # right_column 
        [0,4,8], # left_diagonal 
        [6,4,2] # right_diagonal 
        ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    
    def input_to_index(board_position)
        board_position.to_i - 1
    end

    def move(board_index, player_token)
        @board[board_index] = player_token
    end

    def position_taken?(index_to_check)
        @board[index_to_check] == " " ? false : true 
    end

    def valid_move?(position_number)
       position_number >= 0 && position_number <= 8 && board[position_number] == " " ? true : false
    end

    def turn_count
      @board.count{|ele| ele == "X" || ele == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        index = input_to_index(gets.chomp)
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end                                           
    end
                                
    def won?   
        WIN_COMBINATIONS.detect do |win| 
            if @board[win[0]] == "X" && @board[win[1]] == "X" && @board[win[2]] == "X"
                win
            elsif @board[win[0]] == "O" && @board[win[1]] == "O" && @board[win[2]] == "O"
                win
            else
                false
            end 
        end
    end 

    def full?
            @board.none?{|p| p == " " || p == ""}
    end

    def draw?
        !(won?) && (full?)
    end 

    def over?
        won? || full? || draw?
    end

    def winner 
            if won?
                @board[won?[2]]
            else
              nil
          end
    end

    def play 
        while over? == false
            turn
          end
          if won?
            puts "Congratulations #{winner}!"
          elsif draw?
            puts "Cat's Game!"
          end
    end      
end
