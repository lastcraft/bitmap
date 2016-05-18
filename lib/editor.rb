require_relative 'bitmap'
require_relative 'parser'

class Editor
  def initialize
    @on_exit = ->{ }
    @bitmap = nil
    @parser = Parser.new
                .on(/^\s*X\s*$/) { @on_exit.call }
                .on(/^\s*[?]\s*$/) { help }
                .on(/^\s*I\s+(\d+)\s+(\d+)\s*$/) {|width, height| @bitmap = Bitmap.new(width.to_i, height.to_i); '' }
                .on(/^\s*S\s*/) { show(@bitmap) }
  end
    
  def on_exit &block
    @on_exit = block
    self
  end
  
  def parse(line)
    begin
      @parser.parse(line)
    rescue NoMatch
      'unrecognised command :('
    end
  end

  private
  def show(bitmap)
    bitmap.image.map {|row| row.join}.join
  end
  
  def help
    <<-END
      ? - Help
      I M N - Create a new M x N image with all pixels coloured white (O).
      C - Clears the table, setting all pixels to white (O).
      L X Y C - Colours the pixel (X,Y) with colour C.
      V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
      H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
      S - Show the contents of the current image
      X - Terminate the session"
    END
  end
end
