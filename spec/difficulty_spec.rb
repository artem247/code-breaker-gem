# frozen_string_literal: true

require_relative 'spec_helper'

module Codebreaker
  RSpec.describe Difficulty do
    let(:difficulty_choice) { :easy }
    let(:difficulty_obj) { described_class.new(:easy) }

    describe '.initialize' do
      it 'difficulty instance is correctly initialized' do
        expect(difficulty_obj.class).to eq(described_class)
      end
    end

    describe '#attempts' do
      it 'is possible to access attempts in the Difficulty object' do
        stub_const('DEFAULT_DIFFICULTIES', { easy: { attempts: 15 } })
        expect(difficulty_obj.attempts).to eq(DEFAULT_DIFFICULTIES.dig(:easy, :attempts))
      end
    end
  end
end
