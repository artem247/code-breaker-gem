# frozen_string_literal: true

module Codebreaker
  module Defaults
    USER_NAME_SIZE = [3, 20].freeze
    CODE_SIZE = 4
    RESULT_DEFAULT = { exact_match: 0, number_match: 0, no_match: 0 }.freeze
    CODE_RANGE = (1..6).freeze
    CODE_PATTERN = /^[1-6]{4}$/.freeze
    DEFAULT_DIFFICULTIES = { easy: { attempts: 15, hints: 2 },
                             hard: { attempts: 10, hints: 1 },
                             hell: { attempts: 5, hints: 1 } }.freeze
  end
end
