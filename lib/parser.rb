class NoMatch < RuntimeError; end

module Tokens
  def literal(token)
    Regexp.escape(token)
  end
  
  def number
    '(\d+)'
  end
  
  def letter
    '(.)'
  end
end

class Parser
  def initialize
    @patterns = []
  end

  def parse(command)
    each_pattern do |pattern, callback|
      if result = pattern.match(command)
        return callback.call(*result[1..-1])
      end
    end
    raise NoMatch
  end
  
  def on(*tokens, &callback)
    pattern = Regexp.new('^\s*' + tokens.join('\s+') + '\s*$')
    @patterns << [pattern, callback]
    self
  end
  
  private
  def each_pattern
    @patterns.each {|pair| yield pair[0], pair[1] }
  end
end
