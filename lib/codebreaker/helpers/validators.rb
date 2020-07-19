# frozen_string_literal: true

module Codebreaker
  module Validators
    include Defaults

    def self.valid?(type, object)
      case type
      when :name then validate_name(object)
      when :user then validate_user(object)
      when :difficulty_choice then validate_difficulty_choice(object)
      when :difficulty_object then validate_difficulty_object(object)
      when :guess then validate_guess(object)
      end
      true
    end

    def self.validate_user(object)
      validate_class(User, object)
    end

    def self.validate_name(object)
      validate_class(String, object)
      validate_string_size(USER_NAME_SIZE, object)
    end

    def self.validate_difficulty_choice(object)
      validate_class(Symbol, object)
      validate_occurence(DEFAULT_DIFFICULTIES.keys, object)
    end

    def self.validate_difficulty_object(object)
      validate_class(Difficulty, object)
    end

    def self.validate_guess(guess)
      return if guess.size == CODE_SIZE &&
                guess.match?(/[1-6]/)

      raise GuessError, 
        "Guess should be exactly #{CODE_SIZE} long, 
        and consist of integers from #{CODE_RANGE.first} to #{CODE_RANGE.last}"
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
