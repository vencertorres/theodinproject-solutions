def stock_picker(prices)
  min_price = prices[0]
  min_index = 0
  max_profit = 0
  buy_day = 0
  sell_day = 0

  prices.each_with_index do |current_price, day|
    if current_price < min_price
      min_price = current_price
      min_index = day
    elsif current_price - min_price > max_profit
      max_profit = current_price - min_price
      buy_day = min_index
      sell_day = day
    end
  end

  [buy_day, sell_day]
end
