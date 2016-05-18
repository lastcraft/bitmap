class InvalidBitmapSize < RuntimeError; end

class Bitmap
  attr_reader :image

  def initialize(width, height)
    raise InvalidBitmapSize if width < 1 or width > 250
    raise InvalidBitmapSize if height < 1 or height > 250
    @width, @height = width, height
    clear
  end
  
  def clear
    @image = Array.new(@height) { Array.new(@width) {'O'}}
    self
  end
  
  def set(x, y, colour)
    @image[@height - y][x - 1] = colour
    self
  end
  
  def vertical(x, y1, y2, colour)
    y2, y1 = y1, y2 if y1 > y2
    (y1..y2).each {|y| set(x, y, colour) }
    self
  end
end
