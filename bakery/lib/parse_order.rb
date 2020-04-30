# frozen_string_literal: true

class ParseOrder
  def call(order, inventory)
    allowed_lines = Regexp.new(
      # <00> <CODES|FROM|INVENTORY>
      "^(\\d+)\\s+(#{inventory.keys.join('|')})$",
    )
    parse_order(order, allowed_lines)
  end

  def parse_order(order, allowed_lines)
    good_lines, bad_lines =
      order.to_s.split(/\n/).map(&:strip).reject(&:empty?)
        .partition { |l| l[allowed_lines] }
    [
      parse_good_lines(good_lines, allowed_lines),
      bad_lines,
    ]
  end

  def parse_good_lines(good_lines, allowed_lines)
    good_lines.map do |line|
      match = line.match allowed_lines
      { code: match[2], amount: match[1].to_i }
    end
  end
end
