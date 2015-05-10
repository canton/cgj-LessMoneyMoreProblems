#!/usr/bin/env ruby

def solve(coins, c, v)
  # puts "coins:#{coins}, c:#{c}, v:#{v}"
  possibilities = (0..c).to_a.repeated_permutation(coins.count).map{ |p|
    p.each_with_index.map{ |n,i| n * coins[i] }.inject(:+)
  }.select{ |x| x <= v }.to_a
  missing = (1..v).to_a - possibilities
  possibilities.uniq!
  possibilities.sort!
  missing.sort!
  # puts "possibilities:#{possibilities}"
  # puts "missing:#{missing}"

  new_coins = []
  while !missing.empty? do
    smallest = missing.first
    new_coin new_coins, possibilities, missing, smallest, c, v
    missing = missing - possibilities
    possibilities.uniq!
    possibilities.sort!
    missing.sort!
    # puts "possibilities:#{possibilities}"
    # puts "missing:#{missing}"
  end
  # if missing.include? 1
  #   new_coin new_coins, possibilities, missing, 1, c, v
  #   missing = missing - possibilities
  #   puts "possibilities:#{possibilities}"
  #   puts "missing:#{missing}"
  # end
  # puts "empty?:#{missing.empty?}"
  return new_coins if missing.empty?

  nil
end

def new_coin(new_coins, possibilities, missing, _new, c, v)
  # possibilities = (1..c).map{ |n| n*_new }.product(possibilities).map{ |a| a.inject(:+) }.select{ |x| x <= v } + possibilities
  added = (1..c).map{ |n|
    # puts "    #{n*_new}"
    n*_new
  }.product(possibilities).map{ |a| a.inject(:+) }.select{ |x| x <= v }
  # puts "added:#{added}"
  possibilities.push(*added)
  new_coins << _new
end

def test(coins, c, v, ans)
  actual = solve coins, c, v
  raise "coins=#{coins}, c=#{c}, v=#{v}, expected=#{ans}, actual=#{actual}" if actual.count != ans
end

# test [1,2,4,5,10,23,25,50,100], 1, 100, 0
# test [1,2,4,5,10,23,25,50], 1, 100, 0
# test [1,2,4,5,10,23,25], 1, 100, 1
# test [1,2,4,5,10,23], 1, 100, 2
# test [1,2,4,5,10], 1, 100, 3

case_count = gets.chomp.to_i
case_count.times { |cc|
  buffer = gets.chomp.split(' ')
  c = buffer[0].to_i
  d = buffer[1].to_i
  v = buffer[2].to_i
  coins = gets.chomp.split(' ').map(&:to_i)

  ans = solve coins, c, v
  puts "Case ##{cc+1}: #{ans.count}"
  # puts "new coins - #{ans}"
}
