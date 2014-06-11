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
    puts ' show #id - Find contact by index/id (default: 0)'.magenta
    puts ' find     - Find contact by name or email'.light_red
    puts ' quit     - Exit Application'.red
    print '> '.light_blue
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
    when /^show/
      show_contact(input)
    end
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def press_enter_continue
    print "\nPress enter to continue....".yellow
    STDIN.getc
  end

  def quit
    clear_screen
    puts 'See you later...'.green
    @running = false
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

  def show_contact(input)
    clear_screen
    id = input[/\d+$/].to_i
    puts "Showing contact with index of #{id}".red
    puts '==================================='.red
    puts Contact.show(id)
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

  def new_contact(name, email)
    clear_screen
    if Contact.exists? email
      puts "Sorry #{email} is already assigned to a person".red
    else
      puts 'Contact added to database'.green
    end
    Contact.create name, email
    press_enter_continue
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

  def list_contacts_screen
    clear_screen
    puts 'List of all contacts'.red
    puts '===================='.red
    puts list_contacts
    press_enter_continue
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
end
