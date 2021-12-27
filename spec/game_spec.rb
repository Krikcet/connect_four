
require_relative '../lib/game'

describe Game do
  describe '#verify_input' do
    subject(:game_verify) { described_class.new }
    context 'when input is between 1 and 7' do
      it 'returns input' do
        valid_input = 7
        expect(game_verify.verify_input(valid_input)).to eq(valid_input)
      end

      context 'when input is more than 7' do
        it 'returns nil' do
          invalid_input = 8
          expect(game_verify.verify_input(invalid_input)).to be_nil
        end
      end

      context 'when the chosen column is full' do
        before do
          valid_input = 6
          6.times { game_verify.board.update_board(valid_input, 'X') }
        end
        it 'returns nil' do
          valid_input = 6
          expect(game_verify.verify_input(valid_input)).to be_nil
        end
      end
    end
  end

  describe '#choose_column' do
    subject(:game_choose) { described_class.new }
    context 'when input is valid' do
      before do
        valid_input = '5'
        allow(game_choose).to receive(:gets).and_return(valid_input)
      end
      it 'returns input as integer' do
        expect(game_choose.choose_column).to eq(5)
      end

      it 'does not return error message' do
        error_message = 'Please choose a different column.'
        expect(game_choose).not_to receive(:puts).with(error_message)
        game_choose.choose_column
      end
    end
    
    context 'when first chosen column is full and second chosen column is not' do
      before do
        valid_input = '5'
        allow(game_choose).to receive(:gets).and_return(valid_input)
        6.times { game_choose.board.update_board(valid_input.to_i, 'X') }
      end
      it 'puts error message once' do
        valid_input = '5'
        error_message = 'Please choose a different column.'
        allow(game_choose).to receive(:verify_input).and_return(nil, valid_input.to_i)
        expect(game_choose).to receive(:puts).with(error_message).once
        game_choose.choose_column
      end
    end
  end
end