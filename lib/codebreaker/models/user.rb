# frozen_string_literal: true

module Codebreaker
  class User
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
