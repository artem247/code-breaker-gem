class Difficulty
  include Defaults
  
  attr_reader :difficulty, :attempts, :hints
  attr_writer :attempts, :hints

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