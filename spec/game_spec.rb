# frozen_string_literal: true

require_relative 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:user) { User.new('name') }
    let(:difficulty) { Difficulty.new(:easy) }
    let(:game) { described_class.new(user, difficulty) }
    let(:def_difficulty) do
      { easy: { attempts: 15, hints: 2 },
        hard: { attempts: 10, hints: 1 },
        hell: { attempts: 5, hints: 1 } }
    end

    describe '.initialize' do
      it 'code is generated after initialization' do
        expect(game.secret_code).not_to be_empty
      end

      it 'hint amount should correspond to difficulty' do
        expect(game.hints).to eq(def_difficulty.dig(:easy, :hints))
      end

      it 'attempts amount should correspond to difficulty' do
        expect(game.attempts).to eq(def_difficulty.dig(:easy, :attempts))
      end

      it '#won? is false at the start of the game' do
        expect(game.won?).to eq(false)
      end
    end

    describe '#attempts' do
      it 'attempts are incremented by #use_attempt' do
        expect { game.use_attempt }.to change(game, :attempts)
          .from(def_difficulty.dig(:easy, :attempts)).to(def_difficulty.dig(:easy, :attempts) - 1)
      end

      it 'game is lost when there are no more attempts' do
        game.attempts.times { game.use_attempt }
        expect(game.lost?).to eq(true)
      end
    end

    describe '#hint' do
      it 'when using hint method - hints amount is decreased by one' do
        expect { game.hint }.to change(game, :hints)
          .from(def_difficulty.dig(:easy, :hints)).to(def_difficulty.dig(:easy, :hints) - 1)
      end

      it 'hint correctly gives a number from secret code' do
        expect(game.secret_code).to include(game.hint)
      end
    end

    describe '#parse' do
      context 'when answer is correct, guess parsing is working correctly ' do
        let(:answer) { game.secret_code }

        it '#parse will return a correct result' do
          expect(game.parse(answer)).to eq({ exact_match: 4, number_match: 0, no_match: 0 })
        end

        it 'if user has guessed #won? would return true' do
          game.parse(answer)
          expect(game.won?).to eq(true)
        end
      end

      context 'when answer is incorrect, guess parsing is working correctly ' do
        let(:answer) { game.secret_code.rotate(2) }

        it 'if user haven\'t guessed then won? would return false' do
          game.parse(answer)
          expect(game.won?).to eq(false)
        end
      end
    end
  end
end
