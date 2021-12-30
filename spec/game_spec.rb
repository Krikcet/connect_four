
require_relative '../lib/game'

describe Game do
  subject(:game_test) { described_class.new }
  describe '#verify_input' do
    context 'when input is between 1 and 7' do
      it 'returns input' do
        valid_input = 7
        expect(game_test.verify_input(valid_input)).to eq(valid_input)
      end

      context 'when input is more than 7' do
        it 'returns nil' do
          invalid_input = 8
          expect(game_test.verify_input(invalid_input)).to be_nil
        end
      end

      context 'when the chosen column is full' do
        before do
          valid_input = 6
          6.times { game_test.board.update_board(valid_input, 'X') }
        end
        it 'returns nil' do
          valid_input = 6
          expect(game_test.verify_input(valid_input)).to be_nil
        end
      end
    end
  end

  describe '#choose_column' do
    context 'when input is valid' do
      before do
        valid_input = '5'
        allow(game_test).to receive(:gets).and_return(valid_input)
      end
      it 'returns input as integer' do
        expect(game_test.choose_column).to eq(5)
      end

      it 'does not return error message' do
        error_message = 'Please choose a different column.'
        expect(game_test).not_to receive(:puts).with(error_message)
        game_test.choose_column
      end
    end
    
    context 'when first chosen column is full and second chosen column is not' do
      before do
        valid_input = '5'
        allow(game_test).to receive(:gets).and_return(valid_input)
        6.times { game_test.board.update_board(valid_input.to_i, 'X') }
      end

      it 'puts error message once' do
        valid_input = '5'
        error_message = 'Please choose a different column.'
        allow(game_test).to receive(:verify_input).and_return(nil, valid_input.to_i)
        expect(game_test).to receive(:puts).with(error_message).once
        game_test.choose_column
      end
    end
  end

  describe '#row_victory?' do
    context 'when there are no marked spaces' do
      it 'returns false' do
        player_symbol = 'X'
        expect(game_test.row_victory?(player_symbol)).to be false
      end
    end

    context 'when there are 4 marked spaces in a row that do not match' do
      before do
        player_one = 'X'
        player_two = 'O'
        game_test.board.update_board(1, player_one)
        game_test.board.update_board(2, player_one)
        game_test.board.update_board(3, player_one)
        game_test.board.update_board(4, player_two)
      end
      it 'returns false' do
        player_one = 'X'
        expect(game_test.row_victory?(player_one)).to be false
      end
    end

    context 'when there are 4 marked spaces in a row that match' do
      before do
        player_one = 'X'
        game_test.board.update_board(1, player_one)
        game_test.board.update_board(2, player_one)
        game_test.board.update_board(3, player_one)
        game_test.board.update_board(4, player_one)
      end
      it 'returns true for winning player' do
        winner = 'X'
        expect(game_test.row_victory?(winner)).to be true
      end

      it 'returns false for losing player' do
        loser = 'O'
        expect(game_test.row_victory?(loser)).to be false
      end
    end
  end

  describe '#column_victory?' do
    context 'when there are no marked spaces' do
      it 'returns false' do
        player_symbol = 'X'
        expect(game_test.column_victory?(player_symbol)).to be false
      end
    end

    context 'when there are 4 marked spaces in a column that do not match' do
      before do
        player_one = 'X'
        player_two = 'O'
        3.times { game_test.board.update_board(1, player_one) }
        game_test.board.update_board(1, player_two)
      end
      it 'returns false' do
        player_one = 'X'
        expect(game_test.column_victory?(player_one)).to be false
      end
    end

    context 'when there are 4 marked spaces in a column that match' do
      before do
        player_one = 'X'
        4.times { game_test.board.update_board(1, player_one) }
      end
      it 'returns true for winning player' do
        winner = 'X'
        expect(game_test.column_victory?(winner)).to be true
      end

      it 'returns false for losing player' do
        loser = 'O'
        expect(game_test.column_victory?(loser)).to be false
      end
    end
  end

  describe '#descending_victory?' do
    context 'when there are no marked spaces' do
      it 'returns false' do
        player_symbol = 'X'
        expect(game_test.descending_victory?(player_symbol)).to be false
      end
    end

    context 'when there are 4 descending diagonal spaces that do not match' do
      before do
        player_one = 'X'
        player_two = 'O'
        3.times { game_test.board.update_board(1, player_two) }
        2.times { game_test.board.update_board(2, player_two) }
        game_test.board.update_board(3, player_two)
        game_test.board.update_board(1, player_one)
        game_test.board.update_board(2, player_two)
        game_test.board.update_board(3, player_one)
        game_test.board.update_board(4, player_one)
      end
      it 'returns false' do
        player_one = 'X'
        expect(game_test.descending_victory?(player_one)).to be false
      end
    end

    context 'when there are 4 descending diagonal spaces that match' do
      before do
        winner = 'X'
        loser = 'O'
        3.times { game_test.board.update_board(1, loser) }
        2.times { game_test.board.update_board(2, loser) }
        game_test.board.update_board(3, loser)
        game_test.board.update_board(1, winner)
        game_test.board.update_board(2, winner)
        game_test.board.update_board(3, winner)
        game_test.board.update_board(4, winner)
      end
      it 'returns true for winning player' do
        winner = 'X'
        expect(game_test.descending_victory?(winner)).to be true
      end

      it 'returns false for losing player' do
        loser = 'O'
        expect(game_test.descending_victory?(loser)).to be false
      end
    end
  end
  describe '#ascending_victory?' do
    context 'when there are no marked spaces' do
      it 'returns false' do
        player_symbol = 'X'
        expect(game_test.ascending_victory?(player_symbol)).to be false
      end
    end

    context 'when there are 4 ascending diagonal spaces that do not match' do
      before do
        player_one = 'X'
        player_two = 'O'
        game_test.board.update_board(1, player_one)
        game_test.board.update_board(2, player_two)
        game_test.board.update_board(2, player_two)
        2.times { game_test.board.update_board(3, player_two) }
        3.times { game_test.board.update_board(4, player_two) }
        game_test.board.update_board(3, player_one)
        game_test.board.update_board(4, player_one)
      end
      it 'returns false' do
        player_one = 'X'
        expect(game_test.ascending_victory?(player_one)).to be false
      end
    end

    context 'when there are 4 ascending diagonal spaces that match' do
      before do
        winner = 'X'
        loser = 'O'
        game_test.board.update_board(1, winner)
        game_test.board.update_board(2, loser)
        2.times { game_test.board.update_board(3, loser) }
        3.times { game_test.board.update_board(4, loser) }
        game_test.board.update_board(4, winner)
        game_test.board.update_board(3, winner)
        game_test.board.update_board(2, winner)
      end
      it 'returns true for winning player' do
        winner = 'X'
        expect(game_test.ascending_victory?(winner)).to be true
      end

      it 'returns false for losing player' do
        loser = 'O'
        expect(game_test.ascending_victory?(loser)).to be false
      end
    end
  end
end