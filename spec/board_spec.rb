# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#create_grid' do
    context 'when no arguments are given' do
      subject(:board_grid) { described_class.new }

      it 'returns array with 6 rows' do
        rows = board_grid.grid
        expect(rows.count).to eq(6)
      end

      it 'each row has 7 columns' do
        rows = board_grid.grid
        columns = rows.transpose
        expect(columns.count).to eq(7)
      end
    end
  end

  describe '#update_board' do
    subject(:board_update) { described_class.new }
    context 'when first move is made' do
     
      it 'changes bottom space in column to player symbol' do
        input = 5
        player_symbol = 'X'
        expect { board_update.update_board(input, player_symbol) }.to change { board_update.grid.transpose[input - 1].last }.to(player_symbol)
      end

      it 'does not change any other spaces in the column' do
        input = 5
        player_symbol = 'X'
        expect { board_update.update_board(input, player_symbol) }.not_to change { board_update.grid.transpose[input - 1].first }
      end
    end
    context 'when a column has been marked previously' do
      before do
        board_update.grid.last[4] = 'O'
      end
      it 'changes lowest unmarked space to symbol' do
        input = 5
        player_symbol = 'X'
        expect { board_update.update_board(input, player_symbol) }.to change { board_update.grid[-2][input - 1] }.to(player_symbol)
      end
    end
  end
end
