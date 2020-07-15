# frozen_string_literal: true

module Codebreaker
  class Game
    attr_reader :difficulty, :player, :secret_code, :attempts, :hints

    DEFAULT_DIFFICULTIES = { easy: { attempts: 15, hints: 2 },
                             hard: { attempts: 10, hints: 1 },
                             hell: { attempts: 5, hints: 1 } }.freeze
    USER_NAME_SIZE = [3, 20].freeze
    CODE_SIZE = 4
    RESULT_DEFAULT = { exact_match: 0, number_match: 0, no_match: 0 }.freeze

    def initialize(player, difficulty)
      @secret_code = generate
      @player = player
      @difficulty = difficulty
      @hints = hints_amount(difficulty)
      @attempts = attempts_amount(difficulty)
      @hint_list = @secret_code.dup
      @won = false
    end

    def use_attempt
      @attempts -= 1
    end

    def parse(code, answer)
      result = RESULT_DEFAULT.dup
      secret_code = code.dup
      exact_match_size(secret_code, answer).times { result[:exact_match] += 1 }
      return result if won?

      number_match_size(secret_code, answer).times { result[:number_match] += 1 }
      no_match_size(result).times { result[:no_match] += 1 }
      result
    end

    def attempts_amount(difficulty)
      DEFAULT_DIFFICULTIES.dig(difficulty, :attempts)
    end

    def hints_amount(difficulty)
      DEFAULT_DIFFICULTIES.dig(difficulty, :hints)
    end

    def valid_guess?(guess)
      true if guess.size == CODE_SIZE &&
              guess.match?(/[1-6]/)
    end

    def hint
      @hints -= 1
      hint_index = rand(0...4)
      hint = @hint_list[hint_index]
      @hint_list.delete_at(hint_index)
      hint
    end

    def create_stats
      name = @player.name
      difficulty = @difficulty
      attempts_total = attempts_amount(@difficulty)
      attempts_used = attempts_total - @attempts
      hints_total = hints_amount(@difficulty)
      hints_used = hints_total - @hints
      [{ name: name, difficulty: difficulty, attempts_total: attempts_total,
         attempts_used: attempts_used, hints_total: hints_total, hints_used: hints_used }]
    end

    def won?
      @won
    end

    def lost?
      @attempts.zero?
    end

    private

    def generate
      code = []
      CODE_SIZE.times do
        code << (1..6).to_a.sample
      end
      code.map(&:to_i)
    end

    def exact_match_size(code, answer)
      exact_size = exact(code, answer).compact.size
      @won = true if exact_size == code.length
      exact_size
    end

    def number_match_size(code, answer)
      exact = exact(code, answer)
      code = delete_exact(exact, code)
      answer = delete_exact(exact, answer)
      code.map { |value| answer.select { |next_value| value == next_value } }.flatten.uniq.size
    end

    def delete_exact(correct, code)
      correct.zip(code).reject { |a, b| a == b }.flatten.compact
    end

    def exact(secret_code, guess)
      guess.zip(secret_code).map { |a, b| a if a == b }
    end

    def no_match_size(result_hash)
      CODE_SIZE - result_hash[:exact_match] - result_hash[:number_match]
    end
  end
end
