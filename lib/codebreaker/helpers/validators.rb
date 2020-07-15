# frozen_string_literal: true

module Codebreaker
  module Validators
    def self.valid?(type, object)
      case type
      when :user then validate_class(User, object)
      when :difficulty
        validate_class(Symbol, object)
        validate_occurence(Game::DEFAULT_DIFFICULTIES.keys, object)
      when :name
        validate_class(String, object)
        validate_string_size(Game::USER_NAME_SIZE, object)
      end
      true
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
