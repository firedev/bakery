# frozen_string_literal: true

require 'spec_helper'

describe Bakery do
  subject(:bill) do
    described_class.new.call(order)
  end

  after do
    puts
    puts '-' * 20
    puts
    puts order
    puts
    puts '-' * 20
    puts
    puts bill
    puts
    puts '-' * 20
    puts
  end

  describe('GOOD') do
    describe('simple order 21 CF') do
      let(:order) { '21 CF' }
      let(:expected) do
        <<~BILL
          21 CF $39.93
            2 x 9 $16.99
            1 x 3 $5.95
        BILL
      end

      it 'produces a correct bill' do
        expect(bill).to eq expected
      end
    end

    describe('slow order 200 MB11') do
      let(:order) { '200 MB11' }
      let(:expected) do
        <<~BILL
          200 MB11 $623.75
            25 x 8 $24.95
        BILL
      end

      it 'produces a correct bill' do
        expect(bill).to eq expected
      end
    end

    describe('simple order with whitelines') do
      let(:order) do
        <<~ORDER

          1 VS5

        ORDER
      end

      let(:expected) do
        <<~BILL
          1 VS5 N/A
        BILL
      end

      it 'produces a correct bill' do
        expect(bill).to eq expected
      end
    end

    describe('full order') do
      let(:order) do
        <<~ORDER
          10 VS5
          14 MB11
          13 CF
        ORDER
      end

      let(:expected) do
        <<~BILL
          10 VS5 $17.98
            2 x 5 $8.99

          14 MB11 $54.80
            1 x 8 $24.95
            3 x 2 $9.95

          13 CF $25.85
            2 x 5 $9.95
            1 x 3 $5.95
        BILL
      end

      it 'produces a correct bill' do
        expect(bill).to eq expected
      end
    end
  end

  describe('BAD') do
    describe('empty order') do
      let(:order) { nil }

      it 'does not flinch' do
        expect(bill).to eq ''
      end
    end

    describe('nonexisting items') do
      let(:order) { '99 WHAY' }
      let(:expected) { '99 WHAY N/A' }

      it 'does not flinch' do
        expect(bill).to eq expected
      end
    end

    describe('1 VS5, inventory should have single items') do
      let(:order) { '1 VS5' }
      let(:expected) do
        <<~BILL
          1 VS5 N/A
        BILL
      end

      it 'shows product as not found' do
        expect(bill).to eq expected
      end
    end

    describe('some items missing') do
      let(:order) do
        <<~ORDER
          1 VS5
          2 CF
          8 MB11
        ORDER
      end

      let(:expected) do
        <<~BILL
          1 VS5 N/A

          2 CF N/A

          8 MB11 $24.95
            1 x 8 $24.95
        BILL
      end

      it 'shows product as not found' do
        expect(bill).to eq expected
      end
    end
  end
end
