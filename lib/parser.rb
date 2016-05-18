class NoMatch < RuntimeError; end

class Parser
  def initialize
    @patterns = []
  end

  def parse(command)
    each_pattern do |pattern, callback|
      if result = pattern.match(command)
          return callback.call(*result[1..-1]) if callback
      end
    end
    raise NoMatch
  end
  
  def on(pattern, &callback)
    @patterns << [pattern, callback]
    self
  end
  
  private
  def each_pattern
    @patterns.each {|pair| yield *pair }
  end
end
