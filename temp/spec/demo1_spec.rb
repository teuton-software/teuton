# encoding: utf-8

describe "Select a number between 1-10" do
  number=rand(10)
  max=10
  min=1
	
  context "Case [#{number}]" do
    it "is less than #{max}" do
      expect(number).to be <= max
    end
    it "is greater than #{min}" do
      expect(number).to be >= min
    end
  end
end
