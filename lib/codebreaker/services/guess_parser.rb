module Codebreaker
  class GuessParser
    include Defaults

    def initialize(secret_code, answer)
      @secret_code = secret_code.dup
      @answer = answer
    end

    def check_guess
      result = RESULT_DEFAULT.dup
      exact_match_size(secret_code, @answer).times { result[:exact_match] += 1 }
      return result if exact_match_size(secret_code, @answer).times == code.length?
  
      number_match_size(secret_code, answer).times { result[:number_match] += 1 }
      no_match_size(result).times { result[:no_match] += 1 }
      result
    end
  
    private
  
    def exact_match_size(code, answer)
      exact_size = exact(code, answer).compact.size
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
