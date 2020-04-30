# frozen_string_literal: true

class FindCombinations
  def call(target:, packs:)
    @results = []
    @target = target
    @per_pack = packs.keys
    @series = per_pack.map { |v| target / v }
    find_combinations if target_reacheable?(target, per_pack)
    results
  end

  private

  def target_reacheable?(target, per_pack)
    (target % per_pack.reduce(:gcd)).zero?
  end

  def find_combinations(depth = 0, iterators = [])
    if depth < series.count
      (0..series[depth]).each do |i|
        iterators[depth] = i
        find_combinations(depth + 1, iterators)
      end
    elsif target_reached?(iterators)
      @results.push(iterators.dup)
    end
  end

  def target_reached?(iterators)
    target ==
      iterators.map.with_index { |amount, i| amount * per_pack[i] }.sum
  end

  attr_reader :per_pack, :results, :target, :series
end
