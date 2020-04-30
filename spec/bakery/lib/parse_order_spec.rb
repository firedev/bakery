# frozen_string_literal: true

describe ParseOrder do
  subject(:parsed) do
    described_class.new.call(order, inventory)
  end

  let!(:inventory) do
    {
      'CODE' => {},
    }
  end

  describe 'allows only existing code' do
    let(:order) do
      <<~ORDER
        1 CODE
        2 BLEH
        MEH
      ORDER
    end

    it 'extracts good lines correctly' do
      good, = parsed
      expect(good).to eq [{ amount: 1, code: 'CODE' }]
    end

    it 'extracts bad lines correctly' do
      _, bad = parsed
      expect(bad).to eq [
        '2 BLEH',
        'MEH',
      ]
    end
  end
end
