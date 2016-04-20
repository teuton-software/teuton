# encoding: utf-8

describe "Select a number and gues" do
  
  number=rand(10)
  max=10
  min=1
	
  context "Case [#{number}]" do

    it "is equal 5" do
      expect(number).to be 5
    end

  end
end
