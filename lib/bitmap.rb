class InvalidBitmapSize < RuntimeError; end
class OutOfBounds < RuntimeError; end

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
    x_ok(x); y_ok(y)
    set!(x, y, colour)
    self
  end
  
  def vertical(x, y1, y2, colour)
    x_ok(x); y_ok(y1); y_ok(y2)
    y2, y1 = y1, y2 if y1 > y2
    (y1..y2).each {|y| set(x, y, colour) }
    self
  end
  
  private
  def set!(x, y, colour)
    @image[@height - y][x - 1] = colour
  end
  
  def x_ok(x)
    raise OutOfBounds unless x > 0 and x <= @width
    x
  end
  
  def y_ok(y)
    raise OutOfBounds unless y > 0 and y <= @height
    y
  end
end
