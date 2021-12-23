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
          expect(player_verify.verify_input(8)).to be_nil
        end
      end
    end
  end
end