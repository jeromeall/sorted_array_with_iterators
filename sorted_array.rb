require 'pry'

class SortedArray
  attr_reader :internal_arr

  def initialize arr=[]
    @internal_arr = []
    arr.each { |el| add el }
  end

  def add el
    # we are going to keep this array
    # sorted at all times. so this is ez
    lo = 0
    hi = @internal_arr.size
    # note that when the array just
    # starts out, it's zero size, so
    # we don't do anything in the while
    # otherwise this loop determines
    # the position in the array, *before*
    # which to insert our element
    while lo < hi
      # let's get the midpoint
      mid = (lo + hi) / 2
      if @internal_arr[mid] < el
        # if the middle element is less 
        # than the current element
        # let's increment the lo by one
        # from the current midway point
        lo = mid + 1
      else
        # otherwise the hi *is* the midway 
        # point, we'll take the left side next
        hi = mid 
      end
    end

    # insert at the lo position
    @internal_arr.insert(lo, el)
  end

  def each &block
    # loop over all element in @internal_arr
    # yield to each element
    
    # let's keep track of our index
    i = 0
    until i == @internal_arr.size # until you get the last element of the array
      yield @internal_arr[i]      # yield to the element with the index
      i += 1                      # increment to next index
    end
    @internal_arr                 # return the array

  end

  def map &block
    new_array = []
    self.each {|el| new_array << (yield el)}
    new_array

    # i = 0
    # new_array=[]
    # until i == @internal_arr.size
    #   new_array[i] = yield @internal_arr[i]
    #   i+=1
    # end
    #   new_array
  end

  def map! &block
    new_arr = []
    self.each{|ele| new_arr << (yield ele) }
    @internal_arr = new_arr
    
    # i = 0
    # until i == @internal_arr.size
    #   @internal_arr[i] = yield @internal_arr[i]
    #   i+=1
    # end
    #  @internal_arr
  end

  def find &block
    i = 0
    while i < @internal_arr.size  
      if yield @internal_arr[i] == true
        return @internal_arr[i]
      end
      i += 1
    end
    return nil
  end

    # i = 0
    # until i == @internal_arr.size
      
    #   if (yield @internal_arr[i]) == value
    #       return value
    #   en

  def inject acc=nil, &block
    while i< @internal_arr.size
      acc = (yield acc, @internal_arr[i])
      i += 1
    end
    return acc
  end

end

arr = SortedArray.new
arr.map { |e| e*2 }