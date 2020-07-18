# frozen_string_literal: true

require_relative 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:user) {User.new('name')}
    let(:difficulty) {:easy}
    let(:game) {Game.new(user, difficulty)}

    it 'code is generated after initialization' do
      expect(game.secret_code).not_to be_empty
    end

  #  it 'attempts amount is correct for the difficulty' do
  #    expect(game.attempts).to eq(DEFAULT_DIFFICULTIES.dig(:easy, :attempts))
 #   end

  end
end
