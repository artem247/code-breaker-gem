# frozen_string_literal: true

module Codebreaker
  class Statistics
    def initialize(game)
      @name = game.player.name
      @difficulty = game.difficulty
      @attempts_total = game.difficulty.attempts
      @attempts_used = @attempts_total - game.attempts
      @hints_total = game.difficulty.hints
      @hints_used = @hints_total - game.hints
    end

    def create_stats
      [{ name: @name, difficulty: @difficulty, attempts_total: @attempts_total,
         attempts_used: @attempts_used, hints_total: @hints_total, hints_used: @hints_used }]
    end
  end
end
