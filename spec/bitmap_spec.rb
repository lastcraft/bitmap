require 'rspec'
require_relative '../lib/bitmap'

describe Bitmap do
  it "initialises to grid" do
    expect(Bitmap.new(1, 1).image).to eq([['O']])
    expect(Bitmap.new(2, 1).image).to eq([['O', 'O']])
    expect(Bitmap.new(1, 2).image).to eq([['O'], ['O']])
  end
  
  it "throws if size larger than 250" do
    Bitmap.new(250, 250)
    expect { Bitmap.new(250, 251) }.to raise_error InvalidBitmapSize
    expect { Bitmap.new(251, 250) }.to raise_error InvalidBitmapSize
  end
  
  it "throws if size not at least 1" do
    Bitmap.new(1, 1)
    expect { Bitmap.new(0, 1) }.to raise_error InvalidBitmapSize
    expect { Bitmap.new(1, 0) }.to raise_error InvalidBitmapSize
  end
  
  it "can set an individual pixel" do
    expect(Bitmap.new(1, 1).set(1, 1, 'X').image).to eq([['X']])
    expect(Bitmap.new(2, 2).set(2, 2, 'X').image).to eq([['O', 'O'], ['O', 'X']])
  end
  
  it "can clear the whole bitmap" do
      expect(Bitmap.new(2, 2).set(2, 2, 'X').clear.image).to eq([['O', 'O'], ['O', 'O']])
  end
end
