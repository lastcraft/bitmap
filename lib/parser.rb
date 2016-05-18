class NoMatch < RuntimeError; end

class Parser
  def parse(command)
    raise NoMatch
  end
end
