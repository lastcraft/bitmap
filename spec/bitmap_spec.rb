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
    expect(Bitmap.new(2, 2).set(1, 2, 'X').image).to eq([['X', 'O'], ['O', 'O']])
    expect(Bitmap.new(2, 2).set(2, 2, 'X').image).to eq([['O', 'X'], ['O', 'O']])
    expect(Bitmap.new(2, 2).set(2, 1, 'X').image).to eq([['O', 'O'], ['O', 'X']])
  end
  
  it "throws if out of image bounds if setting invalid coordinates" do
    expect { Bitmap.new(1, 1).set(1, 2, 'X') }.to raise_error OutOfBounds
    expect { Bitmap.new(1, 1).set(1, 0, 'X') }.to raise_error OutOfBounds
    expect { Bitmap.new(1, 1).set(2, 1, 'X') }.to raise_error OutOfBounds
    expect { Bitmap.new(1, 1).set(0, 1, 'X') }.to raise_error OutOfBounds
  end
  
  it "can clear the whole bitmap" do
    expect(Bitmap.new(2, 2).set(2, 2, 'X').clear.image).to eq([['O', 'O'], ['O', 'O']])
  end
  
  it "draws vertical lines" do
    expect(Bitmap.new(3, 3).vertical(2, 2, 3, 'X').image).to eq([['O', 'X', 'O'], ['O', 'X', 'O'], ['O', 'O', 'O']])
    expect(Bitmap.new(3, 3).vertical(2, 3, 2, 'X').image).to eq([['O', 'X', 'O'], ['O', 'X', 'O'], ['O', 'O', 'O']])
    expect(Bitmap.new(3, 3).vertical(1, 1, 3, 'X').image).to eq([['X', 'O', 'O'], ['X', 'O', 'O'], ['X', 'O', 'O']])
    expect(Bitmap.new(3, 3).vertical(1, 3, 3, 'X').image).to eq([['X', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']])
  end
  
  it "raises if trying to draw vertical lines out of bounds" do
    expect { Bitmap.new(3, 3).vertical(2, 2, 4, 'X') }.to raise_error OutOfBounds
  end
  
  it "going out of bounds does not leave inconsistent debri" do
    bitmap = Bitmap.new(2, 2)
    bitmap.vertical(1, 1, 4, 'X') rescue nil
    expect(bitmap.image).to eq([['O', 'O'], ['O', 'O']]);
  end
  
  it "draws horizontal lines" do
    expect(Bitmap.new(3, 3).horizontal(2, 3, 1, 'X').image).to eq([['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'X', 'X']])
  end
  
  it "raises if trying to draw horizontal lines out of bounds" do
    expect { Bitmap.new(3, 3).horizontal(2, 4, 1, 'X') }.to raise_error OutOfBounds
  end
end
