require 'rspec'
require_relative '../lib/parser'

describe Parser do
  it "raises if nothing to match" do
    expect { Parser.new.parse('') }.to raise_error NoMatch
  end
  
  it "raises if fails to match" do
    expect { Parser.new.on(/Z/) { }.parse('') }.to raise_error NoMatch
    expect { Parser.new.on(/Z/) { }.parse('A') }.to raise_error NoMatch
    expect { Parser.new.on(/^Z/) { }.parse(' Z') }.to raise_error NoMatch
  end
  
  it "triggers callback on exact match" do
    z = false
    Parser.new.on(/Z/) { z = true }.parse('Z')
    expect(z).to be_truthy
  end
  
  it "triggers block appropriate to the action" do
    y, z = false, false
    Parser.new
        .on(/Y/) { y = true }
        .on(/Z/) { z = true }
        .parse('Z')
    expect(y).to be_falsy
    expect(z).to be_truthy
  end
  
  it "matches the first pattern only" do
    y, z = false, false
    Parser.new
        .on(/Y/) { y = true }
        .on(/Z/) { z = true }
        .parse('ZY')
    expect(y).to be_truthy
    expect(z).to be_falsy
  end
  
  it "extracts sub patterns as block arguments" do
    parser = Parser.new
                .on(/add\s+(\d+)\s+(\d+)/) {|a, b| a.to_i + b.to_i }
                .on(/subtract\s+(\d+)\s+(\d+)/) {|a, b| a.to_i - b.to_i }
    expect(parser.parse('add 3 4') ).to eq(7)
    expect(parser.parse('subtract 300 400') ).to eq(-100)
  end
end
