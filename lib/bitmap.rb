class InvalidBitmapSize < RuntimeError; end

class Bitmap
  attr_reader :image

  def initialize(width, height)
    raise InvalidBitmapSize if width > 250 or height > 250
    raise InvalidBitmapSize if width < 1 or height < 1
    @image = Array.new(height) { Array.new(width) {'O'}}
  end
end
