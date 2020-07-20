# frozen_string_literal: true

require_relative 'spec_helper'

module Codebreaker
  RSpec.describe Codebreaker::Validators do
    describe 'name validations' do
      let(:short_name) { 'd' }
      let(:long_name) { 'RobertRobertRobertRobertRobertRobertRobertRobert' }
      let(:number) { 5 }
      let(:ok_name) { 'Robert' }

      it 'short name raises error' do
        expect { Validators.valid?(:name, short_name) }.to raise_error(StringSizeError)
      end

      it 'long name raises error' do
        expect { Validators.valid?(:name, long_name) }.to raise_error(StringSizeError)
      end

      it 'name which is not a string raises a class error' do
        expect { Validators.valid?(:name, number) }.to raise_error(ClassError)
      end

      it 'proper name does not raises an error' do
        expect { Validators.valid?(:name, ok_name) }.not_to raise_error
      end
    end

    describe 'difficulty choice validations' do
      let(:ok_difficulty) { :easy }
      let(:wrong_name_difficulty) { :ok }
      let(:wrong_class_difficulty) { 'easy' }

      it 'difficulty is validated when its correct' do
        expect { Validators.valid?(:difficulty_choice, ok_difficulty) }.not_to raise_error
      end

      it 'difficulty raises an error when it is not from a list of approved difficulties' do
        expect { Validators.valid?(:difficulty_choice, wrong_name_difficulty) }.to raise_error(OccurenceError)
      end

      it 'difficulty raises an error when it is of incorrect class' do
        expect { Validators.valid?(:difficulty_choice, wrong_class_difficulty) }.to raise_error(ClassError)
      end
    end

    describe 'guess validations' do
      let(:short_guess) { [3, 3, 3] }
      let(:guess_outside_of_range) { [9, 3, 3, 8] }

      it 'Guesses that have less numbers then needed would raise an error' do
        expect { Validators.valid?(:guess, short_guess) }.to raise_error(GuessError)
      end

      it 'Guesses that have wrong numbers then needed would raise an error' do
        expect { Validators.valid?(:guess, guess_outside_of_range) }.to raise_error(GuessError)
      end
    end
  end
end
