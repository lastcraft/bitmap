require 'rspec'
require_relative '../lib/parser'

describe Parser do
  it "raises if no match" do
    expect { Parser.new.parse('') }.to raise_error NoMatch
  end
end
