# frozen_string_literal: true

require_relative 'spec_helper'

module Codebreaker
  RSpec.describe GuessParser do
    describe 'right answer' do
      let(:answer) { [3, 3, 3, 3] }
      let(:code) { [3, 3, 3, 3] }

      it 'parser checks that the answer is right' do
        result = GuessParser.new(code, answer).check_guess
        expect(result).to eq({ exact_match: 4, number_match: 0, no_match: 0 })
      end
    end

    describe 'output matrix' do
      data = [[[6, 5, 4, 3], [5, 6, 4, 3], { exact_match: 2, number_match: 2, no_match: 0 }],
              [[6, 5, 4, 3], [6, 4, 1, 1], { exact_match: 1, number_match: 1, no_match: 2 }],
              [[6, 5, 4, 3], [6, 5, 4, 4], { exact_match: 3, number_match: 0, no_match: 1 }],
              [[6, 5, 4, 3], [3, 4, 5, 6], { exact_match: 0, number_match: 4, no_match: 0 }],
              [[6, 5, 4, 3], [6, 6, 6, 6], { exact_match: 1, number_match: 0, no_match: 3 }],
              [[6, 5, 4, 3], [2, 6, 6, 6], { exact_match: 0, number_match: 1, no_match: 3 }],
              [[6, 5, 4, 3], [2, 2, 2, 2], { exact_match: 0, number_match: 0, no_match: 4 }],
              [[6, 6, 6, 6], [1, 6, 6, 1], { exact_match: 2, number_match: 0, no_match: 2 }],
              [[1, 2, 3, 4], [3, 1, 2, 4], { exact_match: 1, number_match: 3, no_match: 0 }],
              [[1, 2, 3, 4], [1, 5, 2, 4], { exact_match: 2, number_match: 1, no_match: 1 }],
              [[1, 2, 3, 4], [1, 2, 3, 4], { exact_match: 4, number_match: 0, no_match: 0 }]]

      data.each do |calc|
        it "returns correct result for #{calc[0]} and #{calc[1]}" do
          result = GuessParser.new(calc[0], calc[1]).check_guess
          expect(result).to eq(calc[2])
        end
      end
    end
  end
end
