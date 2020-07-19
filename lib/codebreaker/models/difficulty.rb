# frozen_string_literal: true

module Codebreaker
  class Difficulty
    include Defaults
  
    attr_accessor :attempts
    attr_reader :difficulty
  
    def initialize(chosen_difficulty)
      @difficulty = chosen_difficulty
      @attempts = attempts_amount
      @hints = hints_amount
    end
  
    private
  
    def attempts_amount
      DEFAULT_DIFFICULTIES.dig(@difficulty, :attempts)
    end
  
    def hints_amount
      DEFAULT_DIFFICULTIES.dig(@difficulty, :hints)
    end
  end
end