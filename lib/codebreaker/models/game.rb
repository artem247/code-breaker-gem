# frozen_string_literal: true

module Codebreaker
  class Game
    include Defaults

    attr_reader :difficulty, :player, :secret_code, :attempts, :hints

    def initialize(player, difficulty)
      @secret_code = CodeGenerator.new.generate
      @player = player
      @difficulty = difficulty
      @hints = difficulty.hints
      @attempts = difficulty.attempts
      @hint_list = @secret_code.dup
      @won = false
    end

    def use_attempt
      @attempts -= 1
    end

    def hint
      @hints -= 1
      hint_index = rand(0...@hint_list.size)
      hint = @hint_list[hint_index]
      @hint_list.delete_at(hint_index)
      hint
    end

    def won?
      @won
    end

    def lost?
      attempts.zero?
    end

    def parse(guess)
      result = GuessParser.new(@secret_code, guess).check_guess
      @won = true if result.dig(:exact_match) == CODE_SIZE
      result
    end
  end
end
