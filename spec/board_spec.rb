# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#create_grid' do
    context 'when no arguments are given' do
      subject(:board_test) { described_class.new }

      it 'returns array with 6 rows' do
        rows = board_test.grid
        expect(rows.count).to eq(6)
      end

      it 'each row has 7 columns' do
        rows = board_test.grid
        columns = rows.transpose
        expect(columns.count).to eq(7)
      end
    end
  end
end