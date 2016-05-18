require_relative 'bitmap'
require_relative 'parser'

class Editor
  def initialize
    @on_exit = ->{ }
    @bitmap = nil
    @parser = Parser.new
                .on(/^\s*X\s*$/) do
                  @on_exit.call
                end
                .on(/^\s*[?]\s*$/) do
                  help
                end
                .on(/^\s*I\s+(\d+)\s+(\d+)\s*$/) do |width, height|
                  @bitmap = Bitmap.new(width.to_i, height.to_i)
                  ''
                end
                .on(/^\s*S\s*/) do
                  @bitmap.image.map {|row| row.join}.join("\n")
                end
                .on(/^\s*L\s+(\d+)\s+(\d+)\s+(.)\s*$/) do |x, y, colour|
                  @bitmap.set(x.to_i, y.to_i, colour)
                  ''
                end
                .on(/^\s*V\s+(\d+)\s+(\d+)\s+(\d+)\s+(.)\s*$/) do |x, y1, y2, colour|
                  @bitmap.vertical(x.to_i, y1.to_i, y2.to_i, colour)
                  ''
                end
                .on(/^\s*H\s+(\d+)\s+(\d+)\s+(\d+)\s+(.)\s*$/) do |x1, x2, y, colour|
                  @bitmap.horizontal(x1.to_i, x2.to_i, y.to_i, colour)
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
    end
  end

  private
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
