# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#verify_input' do
    subject(:player_verify) { described_class.new('X') }
    context 'when input is between 1 and 7' do
      it 'returns input' do
        valid_input = 7
        expect(player_verify.verify_input(valid_input)).to eq(valid_input)
      end

      context 'when input is more than 7' do
        it 'returns nil' do
          invalid_input = 8
          expect(player_verify.verify_input(invalid_input)).to be_nil
        end
      end
    end
  end

  describe '#choose_column' do
    subject(:player_choose) { described_class.new('X') }
    context 'when input is valid' do
      before do
        valid_input = '5'
        allow(player_choose).to receive(:gets).and_return(valid_input)
      end
      it 'returns input as integer' do
        expect(player_choose.choose_column).to eq(5)
      end

      it 'does not return error message' do
        error_message = 'Please choose a different column.'
        expect(player_choose).not_to receive(:puts).with(error_message)
        player_choose.choose_column
      end
    end
  end
end