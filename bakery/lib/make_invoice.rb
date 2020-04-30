# frozen_string_literal: true

require 'ostruct'

class MakeInvoice
  def call(combinations:, packs:)
    pack_prices = packs.values
    total, combination = find_best_combination(combinations, pack_prices)
    OpenStruct.new(
      total: total,
      combination: combination,
    )
  end

  private

  def find_best_combination(combinations, pack_prices)
    smallest_pack_prices_combinations = find_smallest_pack_prices(combinations)
    find_most_expensive(smallest_pack_prices_combinations, pack_prices)
  end

  def find_smallest_pack_prices(combinations)
    indexed_by_total_pack_prices = {}
    combinations.map do |combination|
      count = combination.sum
      (indexed_by_total_pack_prices[count] ||= []) << combination
    end
    min_length = indexed_by_total_pack_prices.keys.min
    indexed_by_total_pack_prices[min_length] || []
  end

  def find_most_expensive(smallest_pack_prices_combinations, pack_prices)
    indexed_by_price = Hash[
      smallest_pack_prices_combinations.map do |combination|
        [
          combination_price(combination, pack_prices),
          combination,
        ]
      end
    ]
    best_price = indexed_by_price.keys.max
    [best_price, indexed_by_price[best_price]]
  end

  def combination_price(combination, pack_prices)
    combination.each_with_index.reduce(0.to_f) do |acc, (per_pack, i)|
      acc + per_pack * pack_prices[i]
    end.round(2)
  end
end
