# frozen_string_literal: true

class FormatInvoice
  def call(
    amount:,
    code:,
    inventory:,
    invoice:
  )
    lines(amount, code, inventory, invoice)
  end

  private

  def lines(amount, code, inventory, invoice)
    [
      [amount, code, currency(invoice.total)].join(' '),
      *packs_breakdown(invoice.combination || [], inventory, code),
      '',
    ]
  end

  def packs_breakdown(combination, inventory, code)
    combination.map.with_index do |total, pack_number|
      next if total.zero?

      packs = inventory[code]['packs']
      per_pack = packs.keys[pack_number]
      pack_price = packs.values[pack_number]
      ["\s\s", total, ' x ', per_pack, ' ', currency(pack_price)].join
    end.compact
  end

  def currency(number)
    number ? format('$%<number>.2f', number: number) : 'N/A'
  end

  def count_elements(collection)
    counts = Hash.new(0)
    collection&.each { |pack| counts[pack] += 1 }
    counts
  end
end
