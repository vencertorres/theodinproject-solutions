def bubble_sort(numbers)
  numbers.length.times do |_|
    (1...numbers.length).each do |i|
      if numbers[i - 1] > numbers[i]
        numbers[i - 1], numbers[i] = numbers[i], numbers[i - 1]
      end
    end
  end

  numbers
end
