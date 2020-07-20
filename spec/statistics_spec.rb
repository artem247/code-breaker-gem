# frozen_string_literal: true

require_relative 'spec_helper'

module Codebreaker
  RSpec.describe Statistics do
    describe 'initialization' do
      let(:difficulty) { Difficulty.new(:easy) }
      let(:user) { User.new('Robert') }
      let(:game) { Game.new(user, difficulty) }

      it 'Statistics service is properly initialized and can create data hash' do
        stat_data = Statistics.new(game).create_stats
        expect(stat_data.dig(0, :name)).to eq(user.name)
      end
    end
  end
end
