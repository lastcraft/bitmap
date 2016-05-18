require 'rspec'
require_relative '../lib/editor'

describe "Interactive editor" do
  before do
    @editor = Editor.new
  end
  
  it "triggers exit block on X" do
    exited = false
    @editor.on_exit { exited = true }
    @editor.parse('X')
    expect(exited).to be_truthy
  end
  
  it "gives help text on ?" do
    expect(@editor.parse('?')).to a_string_matching('X - Terminate')
  end
  
  it "gives error on gibberish" do
    expect(@editor.parse('blurgh!')).to eql('unrecognised command :(')
  end
  
  it "can create a blank image" do
    expect(@editor.parse('I 3 3')).to eq('')
    expect(@editor.parse('S')).to eq("OOO\nOOO\nOOO")
  end
  
  it "can draw things" do
    @editor.parse('I 4 3')
    @editor.parse('H 1 4 1 B')
    @editor.parse('V 1 1 3 A')
    @editor.parse('L 4 3 C')
    expect(@editor.parse('S')).to eq("AOOC\nAOOO\nABBB")
  end
end
