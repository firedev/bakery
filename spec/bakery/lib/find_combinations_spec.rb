# frozen_string_literal: true

require 'spec_helper'

describe FindCombinations do
  subject(:combinations) do
    described_class.new.call({ target: target, packs: packs })
  end

  describe 'valid target 12' do
    let(:target) { 12 }
    let(:packs) do
      {
        3 => 3.99,
        4 => 4.99,
        5 => 5.99,
      }
    end

    it 'finds all combinations' do
      expect(combinations).to eq [
        [0, 3, 0],
        [1, 1, 1],
        [4, 0, 0],
      ]
    end
  end

  describe 'long valid target' do
    let(:target) { 200 }
    let(:packs) do
      {
        3 => 3.99,
        4 => 4.99,
        5 => 5.99,
      }
    end

    it 'finds all combinations' do
      expect(combinations).not_to eq []
    end
  end

  describe 'invalid target' do
    let(:target) { 19 }
    let(:packs) do
      { 6 => 6.66 }
    end

    it 'returns and empty array' do
      expect(combinations).to eq []
    end
  end

  describe 'long invalid target' do
    let(:target) { 202 }
    let(:packs) do
      { 3 => 3.33 }
    end

    it 'returns and empty array' do
      expect(combinations).to eq []
    end
  end
end
