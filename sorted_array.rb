require 'pry'

class SortedArray
  attr_reader :internal_arr

  def initialize arr=[]
    @internal_arr = []
    arr.each { |el| add el }
  end

  def add el
    # we are going to    this array
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


  # loop over all element in @internal_arr
  # yield to each element
  def each &block

    i = 0                         # let's keep track of our index
    until i == @internal_arr.size # until you get the last element of the array
      yield @internal_arr[i]      # yield to the block of code with @internal_arr[i] as the element
      i += 1                      # increment to next index
    end
    @internal_arr                 # return the array when reaching end of it

  end


  # for each element in the block
  # return a new array with elements 
  # that return true in the block
  def map &block
    new_array = []                              # create a new array where elements will go into
    self.each {|el| new_array << (yield el)}    # for each true element in the block, shovel that element into new array
    new_array                                   # return the new array
  end




  # for each
  def map! &block
    new_arr = []
    self.each{|ele| new_arr << (yield ele) }
    @internal_arr = new_arr

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
    i = 0
    while i< @internal_arr.size
      acc = (yield acc, @internal_arr[i])
      i += 1
    end
    # binding.pry
    return acc
    
  end

end


