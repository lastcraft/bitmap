require_relative 'bitmap'
require_relative 'parser'

class NoBitmap < RuntimeError; end

class Editor
  def initialize
    extend Tokens
    @on_exit = ->{ }
    @bitmap = nil
    @parser = Parser.new
                .on('X') do
                  @on_exit.call
                end
                .on(literal('?')) do
                  help
                end
                .on('I', number, number) do |width, height|
                  @bitmap = Bitmap.new(width.to_i, height.to_i)
                  ''
                end
                .on('S') do
                  bitmap.image.map(&:join).join("\n")
                end
                .on('L', number, number, letter) do |x, y, colour|
                  bitmap.set(x.to_i, y.to_i, colour)
                  ''
                end
                .on('V', number, number, number, letter) do |x, y1, y2, colour|
                  bitmap.vertical(x.to_i, y1.to_i, y2.to_i, colour)
                  ''
                end
                .on('H', number, number, number, letter) do |x1, x2, y, colour|
                  bitmap.horizontal(x1.to_i, x2.to_i, y.to_i, colour)
                  ''
                end
                .on('C') do
                  bitmap.clear
                  ''
                end
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
    rescue OutOfBounds
      'number is out of bounds :('
    rescue InvalidBitmapSize
      'width and height between 1 and 250 :('
    rescue NoBitmap
      'no image created yet :('
    end
  end

  private
  def bitmap
    raise NoBitmap unless @bitmap
    @bitmap
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
