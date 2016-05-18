class Editor
  def initialize
    @on_exit = ->{ }
  end
    
  def on_exit &block
    @on_exit = block
  end
  
  def parse(line)
    @on_exit.call if line =~ /^\s*X/
  end
end
