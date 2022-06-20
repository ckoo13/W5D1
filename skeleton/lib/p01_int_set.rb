require "byebug"

class MaxIntSet
  attr_accessor :store

  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    if num.between?(0, @max)
      @store[num] = true
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)

  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % num_buckets
    @store[bucket] << num
  end

  def remove(num)
    bucket = num % num_buckets
    @store[bucket].delete(num)
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    bucket = num % num_buckets

    if !@store[bucket].include?(num)
      if @count == num_buckets
        resize!
        self.insert(num)
      else
        @store[bucket] << num
        @count += 1
      end
    end
  end

  def remove(num)
    bucket = num % num_buckets
    if @store[bucket].include?(num)
      @store[bucket].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    previous_store = @store

    initialize(num_buckets * 2)

    previous_store.each do |bucket|
      bucket.each do |ele|
        self.insert(ele)
      end
    end

  end
end
