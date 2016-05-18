require_relative '../lib/editor'

class BitmapEditor
  def initialize
    @editor = Editor.new
    @editor.on_exit { exit_console }
  end

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      puts @editor.parse(input)
    end
  end

  private
    def exit_console
      puts 'goodbye!'
      @running = false
    end
end
