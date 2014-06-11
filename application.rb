# Class used for starting command line contact
class Application
  attr_reader :running

  def initialize
    @running = true
  end

  def run
    while @running
      show_main_menu
      input = gets.chomp

      case input

      when 'quit'
        quit
      when 'new'
        new_contact
      end
    end
  end

  private

  # Prints the main menu only
  def show_main_menu
    clear_screen
    puts "Welcome to the app. What's next?"
    puts ' new      - Create a new contact'
    puts ' list     - List all contacts'
    puts ' quit     - Exit Application'
    print '> '
  end

  def quit
    clear_screen
    puts 'See you later...'
    @running = false
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def new_contact
    clear_screen
    puts 'Create a new contact'
    puts '===================='
    print 'Enter the name: '
    name = gets.chomp
    print 'Enter the email: '
    email = gets.chomp
    Contact.create(name, email)
  end

  def list_contacts
    clear_screen
    puts 'List of all contacts'
    puts '===================='
    Contact.all.to_s
  end
end
