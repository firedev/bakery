# frozen_string_literal: true

require 'psych'

class Bakery
  def initialize(
    find_combinations: FindCombinations.new,
    format_invoice: FormatInvoice.new,
    make_invoice: MakeInvoice.new,
    inventory: Psych.load(File.open(__dir__ + '/inventory.yml')),
    parse_order: ParseOrder.new
  )
    @find_combinations = find_combinations
    @format_invoice = format_invoice
    @make_invoice = make_invoice
    @inventory = inventory
    @parse_order = parse_order
  end

  def call(order)
    good_lines, bad_lines = parse_order.call(order, inventory)
    [
      *process(good_lines),
      *bad_lines.map { |l| "#{l} N/A" },
    ].join("\n")
  end

  private

  def process(good_lines)
    good_lines.map do |code:, amount:|
      format_invoice.call(
        invoice: build_invoice(code, amount),
        amount: amount,
        code: code,
        inventory: inventory,
      )
    end
  end

  def build_invoice(code, amount)
    packs = inventory[code]['packs']
    combinations = find_combinations.call(target: amount, packs: packs)
    make_invoice.call(combinations: combinations, packs: packs)
  end

  attr_reader \
    :find_combinations,
    :format_invoice,
    :make_invoice,
    :inventory,
    :invoice_formatter,
    :parse_order
end
