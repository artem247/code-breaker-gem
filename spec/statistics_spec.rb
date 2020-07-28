# frozen_string_literal: true

require_relative 'spec_helper'

module Codebreaker
  RSpec.describe Statistics do
    let(:difficulty) { Difficulty.new(:easy) }
    let(:user) { User.new('Robert') }
    let(:game) { Game.new(user, difficulty) }

    describe '.initialize' do
      it 'Statistics service is properly initialized' do
        stats = described_class.new(game)
        expect(stats.class).to eq(described_class)
      end
    end

    describe '#create_stats' do
      it 'Statistics service can create data hash' do
        stat_data = described_class.new(game).create_stats
        expect(stat_data.dig(0, :name)).to eq(user.name)
      end
    end
  end
end
