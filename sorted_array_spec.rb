  require 'rspec'
require './sorted_array.rb'
require 'pry'

shared_examples "yield to all elements in sorted array" do |method|
    specify do 
      expect do |b| 
        sorted_array.send(method, &b) 
      end.to yield_successive_args(2,3,4,7,9) 
    end
end

# 
describe SortedArray do
  let(:source) { [2,3,4,7,9] }                  # array passed in SortedArray class to create a new instance
  let(:sorted_array) { SortedArray.new source } # create an instance of the sorted array from source

  # tests for iterators
  describe "iterators" do

    # tests for iterators that don't change the original array
    describe "that don't update the original array" do 



      # tests for the each method
      describe :each do


        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each
        end


        it 'should return the array' do
          # call each method on sorted_array where you return each element
          # and the resulting array is equal to the original array (also source)
          sorted_array.each {|el| el }.should eq sorted_array.internal_arr
        end
      end



      # tests for the map method
      describe :map do


        it 'the original array should not be changed' do
          # instance of the original array
          original_array = sorted_array.internal_arr  
          # when you call map on sorted_array
          # it should not change the original_array
          expect { sorted_array.map {|el| el } }.to_not change { original_array }  
        end


        it_should_behave_like "yield to all elements in sorted array", :map

       
        it 'creates a new array containing the values returned by the block (times 2)' do
          # when calling map to double every element in sorted_array
          # it returns a new array with the values [4,6,8,14,18]
          sorted_array.map {|ele| ele*2 }.should == [4,6,8,14,18]
        end

        it 'does not not return an array with the same object id as the sorted array' do
          sorted_array.map {|ele| ele }.object_id.should_not == sorted_array.internal_arr.object_id
        end


      end

    end



    describe "that update the original array" do
      describe :map! do
        it 'the original array should be updated' do
           sorted_array.map! {|el| el }.should_not eq sorted_array
        end

        it_should_behave_like "yield to all elements in sorted array", :map!

        it 'should replace value of each element with the value returned by block' do
          sorted_array.internal_arr.map!{|ele| ele*2}.should_not eq source
        end
      end
    end
  end

  describe :find do

    it "should find return the value that you are looking for based on block" do
      # pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-find"
      source.find  { |i| i % 2 == 0 }.should eq(2)
    end

    it "should return nil if it doesn't find the element" do
      source.find { |i| (i % 2 == 0 && i % 3 == 0)}.should eq(nil)
      # source.find  { |i| i % 2 == 0 }.should eq()
    end

  end

  describe :inject do
    # specify do 
    #   expect do |b| 
    #     block_with_two_args = Proc.new { |acc, el| return true}
    #     sorted_array.send(method, block_with_two_args) 
    #   end.to yield_successive_args([0,2], [2,3], [5,4],[9,7], [16,9]) 
    

    it "returns the sum of all the elements in the array" do
      # pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-inject"
      sorted_array.inject(0){ |sum, x| sum += x }.should eq(25) 
    end

  # end
end
end
