# frozen_string_literal: true

require_relative 'spec_helper'

module Codebreaker
  RSpec.describe CodeGenerator do
    describe '#generate' do
      it 'code has proper number of digits' do
        stub_const('CODE_SIZE', 4)
        code = described_class.new.generate
        expect(code.size).to eq(CODE_SIZE)
      end
    end
  end
end
