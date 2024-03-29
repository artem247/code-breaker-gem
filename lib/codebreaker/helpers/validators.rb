# frozen_string_literal: true

module Codebreaker
  module Validators
    include Defaults

    def self.valid?(type, object)
      case type
      when :name then validate_name(object)
      when :difficulty_choice then validate_difficulty_choice(object)
      when :guess then validate_guess(object)
      else
        raise ValidationError, "Such #{type} entity could not be validated"
      end
      true
    end

    def self.validate_name(object)
      validate_class(String, object)
      validate_array_size(USER_NAME_SIZE, object.split(''))
    end

    def self.validate_difficulty_choice(object)
      validate_class(Symbol, object)
      validate_occurence(DEFAULT_DIFFICULTIES.keys, object)
    end

    def self.validate_guess(guess)
      return if guess.size == CODE_SIZE &&
                /^[1-6]{4}$/.match?(guess)

      raise GuessError,
            "Guess should be exactly #{CODE_SIZE} long,
            and consist of integers from #{CODE_RANGE.first} to #{CODE_RANGE.last}"
    end

    def self.validate_class(object_class, object)
      raise ClassError, "#{object.class} class must be equal #{object_class} " unless object.instance_of? object_class
    end

    def self.validate_array_size(size, array)
      return unless array.length > size.last || array.length < size.first

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
