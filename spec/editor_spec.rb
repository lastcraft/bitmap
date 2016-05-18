require 'rspec'
require_relative '../lib/editor'

describe 'Interactive editor' do
  before do
    @editor = Editor.new
  end
  
  it "triggers exit block on X" do
    exited = false
    @editor.on_exit { exited = true }
    @editor.parse('X')
    expect(exited).to be_truthy
  end
end
