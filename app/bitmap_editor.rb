require_relative '../lib/editor'

class BitmapEditor
  def run
    puts 'type ? for help'
    editor = Editor.new.on_exit do
      puts 'goodbye!'
      exit
    end
    loop do
      print '> '
      puts editor.parse(gets.chomp)
    end
  end
end
