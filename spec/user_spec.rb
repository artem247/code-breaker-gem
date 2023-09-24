# frozen_string_literal: true

require_relative 'spec_helper'

module Codebreaker
  RSpec.describe User do
    let(:proper_name) { 'name' }
    let(:short_name) { 'aa' }
    let(:user) { described_class.new(proper_name) }

    describe '.initialize' do
      it 'User object is correctly created' do
        expect(user.class).to eq(described_class)
      end

      it 'User name is available for reading' do
        expect(user.name).to eq(proper_name)
      end
    end
  end
end
