module UserCh
  def inpu(board,player,player_s)
    user_in = case player
    when '1' then  board[0][0] = player_s
    when '2' then  board[0][1] = player_s
    when '3' then  board[0][2] = player_s
    when '4' then  board[1][0] = player_s
    when '5' then  board[1][1] = player_s
    when '6' then  board[1][2] = player_s
    when '7' then  board[2][0] = player_s
    when '8' then  board[2][1] = player_s
    when '9' then  board[2][2] = player_s
    else "'YOU SHALL NOT PASS!' -Gandalf"
    end
  end
  module_function :inpu
end

class TicTack
  include UserCh

    @@winner = ''
    @@turn_count = 0
    @@player1_i = []
    @@player2_i = []

    def initialize
        puts "Enter Player 1 Name"
        @player1 = gets.chomp
        puts "Enter Player 2 Name"
        @player2 = gets.chomp
        puts "Enter Player 1 Symbol"
        @player1_s = gets.chomp
        puts "Enter Player 2 Symbol"
        @player2_s = gets.chomp
        puts "Here is your Battlefield!"
        @board = Array.new(3) {Array.new(3,"_")}
    end

    def display_board
        puts "#{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}" 
        puts "#{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}" 
        puts "#{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}" 
    end

    def player1_chance
        puts "Player #{@player1} Enter Your Choice"
        @player1_c = gets.chomp                                     #gets

        if @@player1_i.include?(@player1_c) || @@player2_i.include?(@player1_c)
          puts "Worng choice Enter again"
          return player1_chance
        end

        @@player1_i.push(@player1_c)
        # puts @@player1_i
        UserCh.inpu(@board,@player1_c,@player1_s)

        @@turn_count += 1
        
        display_board
    end

    def player2_chance
        puts "Player #{@player2} Enter Your Choice"
        @player2_c = gets.chomp                                     #gets

        if @@player1_i.include?(@player2_c) || @@player2_i.include?(@player2_c)
          puts "Worng choice Enter again"
          return player2_chance
        end
        
        @@player2_i.push(@player2_c)
        # puts @@player2_i
        UserCh.inpu(@board,@player2_c,@player2_s)
        
        @@turn_count += 1

        display_board
    end

    def row_w
  @board.each do |i|
    if i.all? { |j| j == @player1_s }
      @@winner = @player1
      return

    elsif i.all? { |j| j == @player2_s }
      @@winner = @player2
      return
    end
  end
end

    def col_w
      flat = @board.flatten

      flat.each_with_index do |val,i|
        if val == @player1_s && flat[i] == flat[i+3] && flat[i+3] == flat[i+6]
          @@winner = @player1
          @@turn_count = 10
          
        elsif val == @player2_s && flat[i] == flat[i+3] && flat[i+3] == flat[i+6]
          @@winner = @player2 
          @@turn_count = 10
         
        else
          nil  
        end 
      end
    end

    def diag_w
      center_va = @board[1][1]

      if center_va == @player1_s 
        if (@board[0][0] && @board[2][2] == center_va) || (@board[0][2] && @board[2][0] == center_va)
          @@winner = @player1
          @@turn_count = 10
          
        else
          nil
        end
      elsif center_va == @player2_s
        if (@board[0][0] && @board[2][2] == center_va) || (@board[0][2] && @board[2][0] == center_va)
          @@winner = @player2
          @@turn_count = 10

        else
          nil
        end
      end
    end

    def declare_wi(name)
      if name == @player1
        puts "Congo #{@player1} you won"
        
      elsif name == @player2
        puts "Congo #{@player2} you won"
      
      end
    end

   def play_game
  display_board

  until @@turn_count >= 12
    if @@turn_count % 2 == 0
      player1_chance
      row_w

    elsif @@turn_count %2 != 0
      player2_chance
      row_w
    end

    if @@winner != ""
      declare_wi(@@winner)
      break
    end

    if @@turn_count == 9
      declare_wi('none')
      break
    end

    col_w
    diag_w
  end
     if @@winner == '' && @@turn_count == 12
    puts "It's a tie!"
  end
end
end

one = TicTack.new
one.play_game