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
  
  it "triggers error block on gibberish" do
    expect(@editor.parse('blurgh!')).to eql('unrecognised command :(')
  end
end
