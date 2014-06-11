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
      option_choice input
    end
  end

  private

  # Prints the main menu only
  def show_main_menu
    clear_screen
    puts "Welcome to the app. What's next?".cyan
    puts ' new      - Create a new contact'.light_green
    puts ' list     - List all contacts'.green
    puts ' show #id - Find contact by index/id'.magenta
    puts ' find     - Find contact by name or email'.light_red
    puts ' quit     - Exit Application'.red
    print '> '.light_blue
  end

  def quit
    clear_screen
    puts 'See you later...'.green
    @running = false
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def new_contact_screen
    clear_screen
    puts 'Create a new contact'.red
    puts '===================='.red
    print 'Enter the name: '.yellow
    name = gets.chomp
    print 'Enter the email: '.yellow
    email = gets.chomp
    new_contact name, email
  end

  def new_contact(name, email)
    clear_screen
    Contact.create name, email
    puts "Sorry #{email} is already assigned to a person".red if Contact.exists? email
    press_enter_continue
  end

  def list_contacts_screen
    clear_screen
    puts 'List of all contacts'.red
    puts '===================='.red
    puts list_contacts
    press_enter_continue
  end

  def list_contacts
    contacts = Contact.all
    result_string = "\n"
    counter = 0
    contacts.each do |contact|
      result_string << "#{counter.to_s.red}: #{contact}\n"
      counter += 1
    end
    result_string
  end

  def option_choice(input)
    case input

    when 'quit'
      quit
    when 'new'
      new_contact_screen
    when 'list'
      list_contacts_screen
    when 'find'
      find_contact_screen
    end
  end

  def find_contact_screen
    clear_screen
    puts 'Lookup a Contact'.red
    puts '================'.red
    print 'Enter name or email of contact: '.yellow
    input = gets.chomp
    puts find_contact input
    press_enter_continue
  end

  def find_contact(input)
    contacts_found = Contact.find(input)
    contact_string = "\n"
    contacts_found.each do |contact|
      contact_string << "#{contact}\n"
    end
    contact_string
  end

  def press_enter_continue
    print "\nPress enter to continue....".yellow
    STDIN.getc
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
