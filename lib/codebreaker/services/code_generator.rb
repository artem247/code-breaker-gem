# frozen_string_literal: true

module Codebreaker
  class CodeGenerator
    include Defaults

    def generate
      (1..CODE_SIZE).map { CODE_RANGE.to_a.sample }.map(&:to_i)
    end
  end
end
