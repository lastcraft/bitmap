require_relative '../lib/editor'

class BitmapEditor
  def run
    editor = Editor.new
    editor.on_exit do
      puts 'goodbye!'
      @running = false
    end
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      puts editor.parse(input)
    end
  end
end
