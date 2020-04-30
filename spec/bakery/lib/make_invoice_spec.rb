# frozen_string_literal: true

require 'spec_helper'

describe MakeInvoice do
  subject(:invoice) do
    described_class.new.call({ combinations: combinations, packs: packs }).to_h
  end

  describe 'sample invoice' do
    let(:combinations) do
      [
        [0, 3, 0],
        [1, 1, 1],
        [4, 0, 0],
      ]
    end

    let(:packs) do
      {
        3 => 3.90,
        4 => 4.90,
        5 => 6.90,
      }
    end

    it 'returns the minimum packs with the most price combination' do
      expect(invoice).to eq(
        total: 15.7,
        combination: [1, 1, 1],
      )
    end
  end
end
