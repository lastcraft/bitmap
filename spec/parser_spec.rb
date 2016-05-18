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
end
