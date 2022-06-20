class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    hash_key = key.hash
    bucket = hash_key % num_buckets

    if !@store[bucket].include?(key)
      if @count == num_buckets
        resize!
        self.insert(key)
      else
        @count += 1
        @store[bucket] << key
      end
    end
  end

  def include?(key)
    hash_key = key.hash

    bucket = hash_key % num_buckets

    @store[bucket].include?(key)
  end

  def remove(key)
    hash_key = key.hash
    bucket = hash_key % num_buckets

    if @store[bucket].include?(key)
      @store[bucket].delete(key)
      @count -= 1
    end
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
