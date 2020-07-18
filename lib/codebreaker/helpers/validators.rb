# frozen_string_literal: true

module Codebreaker
  module Validators
    include Defaults

    def self.valid?(type, object)
      case type
      when :user then validate_user(object)
      when :difficulty then validate_difficulty(object)
      when :guess then validate_guess(object)
      end
      true
    end

    def self.validate_user(object)
      validate_class(User, object)
      validate_class(String, object.name)
      validate_string_size(USER_NAME_SIZE, object.name)
    end

    def self.validate_difficulty(object)
      validate_class(Symbol, object.difficulty)
      validate_occurence(DEFAULT_DIFFICULTIES.keys, object.difficulty)
    end

    def self.validate_guess(guess)
      return if guess.size == CODE_SIZE &&
              guess.match?(/[1-6]/)
      raise "Guess should be"
    end

    def self.validate_class(object_class, object)
      raise ClassError, "#{object.class} class must be equal #{object_class} " unless object.instance_of? object_class
    end

    def self.validate_string_size(size, string)
      return unless string.length > size.last && string.length < size.first

      raise StringSizeError,
            "String should be more then #{size.first} characters and less than #{size.last}"
    end

    def self.validate_occurence(array, object)
      return if array.include?(object)

      raise OccurenceError,
            "#{object} is not present in #{array.inspect} collection"
    end
  end
end
