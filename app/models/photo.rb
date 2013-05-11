class Photo
  def initialize(max_num = 100)
    @queue = []
    @max_num = max_num
  end

  def enqueue(obj)
    if length >= @max_num
      @queue.shift
    end
    @queue << obj
  end

  def each
    @queue.each do |obj|
      yield obj
    end
  end

  def last(num)
    num = min(num, self.length)
    (self.length - num...self.length).each do |i|
      yield @queue[i]
    end
  end

  def length
    @queue.length
  end

  private 

  def min(x, y)
    return x <= y ? x : y
  end
end
