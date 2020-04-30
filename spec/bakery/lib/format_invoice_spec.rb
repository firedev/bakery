# frozen_string_literal: true

require 'spec_helper'

describe FormatInvoice do
  subject(:formatted) do
    described_class.new.call(
      amount: amount,
      code: code,
      inventory: inventory,
      invoice: invoice,
    )
  end

  let(:inventory) do
    {
      'CODE' => {
        'packs' => {
          3 => 3.30,
          4 => 4.40,
          5 => 5.50,
        },
      },
    }
  end

  let(:amount) { 13 }
  let(:code) { 'CODE' }
  let(:invoice) do
    double(:invoice, total: 60.6, combination: [1, 2, 3])
  end

  it 'shows reasonable invoice' do
    expect(formatted.join("\n")).to eq <<~BILL
      13 CODE $60.60
        1 x 3 $3.30
        2 x 4 $4.40
        3 x 5 $5.50
    BILL
  end
end
