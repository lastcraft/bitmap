class InvalidBitmapSize < RuntimeError; end

class Bitmap
  attr_reader :image

  def initialize(width, height)
    raise InvalidBitmapSize if width < 1 or width > 250
    raise InvalidBitmapSize if height < 1 or height > 250
    @image = Array.new(height) { Array.new(width) {'O'}}
  end
  
  def set(x, y, colour)
    @image[x - 1][y - 1] = colour
    self
  end
end
