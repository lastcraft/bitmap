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
  
  it "responds with an error if no image created yet" do
    expect(@editor.parse('S')).to eq("no image created yet :(")
  end
  
  it "responds with sizing error if image too big or zero size" do
    expect(@editor.parse('I 0 1')).to eq("width and height between 1 and 250 :(")
    expect(@editor.parse('I 1 251')).to eq("width and height between 1 and 250 :(")
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
    expect(@editor.parse('S')).to eq("ABBB\nAOOO\nAOOC")
  end
  
  it "gives a message when trying to draw outside the image" do
    @editor.parse('I 4 3')
    expect(@editor.parse('L 4 5 X')).to eq("number is out of bounds :(")
  end
  
  it "can clear the image" do
    expect(@editor.parse('I 3 3')).to eq('')
    @editor.parse('H 1 3 1 X')
    @editor.parse('C')
    expect(@editor.parse('S')).to eq("OOO\nOOO\nOOO")
  end
end
