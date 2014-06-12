require 'pry'
require 'colorize'
# # Class for individual contacts, also holds
# # a list of all contacts
class Contact
  attr_accessor :name, :email, :phone_numbers

  def initialize(name, email, phone = [])
    @name = name
    @email = email
    @phone_numbers = []
    process_numbers phone
  end

  def to_s
    "(#{@name}) #{@email}\n   ".green << numbers_to_s
  end

  def numbers_to_s
    if phone_numbers.empty?
      "No numbers stored\n".red
    else
      string = ''
      phone_numbers.each do |number_and_location|
        string << "#{number_and_location.join(', ')} \n   ".light_green
      end
      string
    end
  end

  ## In-memory list of contacts
  class << self
    attr_reader :contacts

    def create(name, email, phone = [])
      if exists? email
        "#{email} already exists in database".red
      else
        @contacts << Contact.new(name, email, phone)
        'Contact added to database'.green
      end
    end

    def all
      @contacts
    end

    def find(query)
      @contacts.select do |contact|
        contact.name[/^#{query}/im] || contact.email[/^#{query}/im]
      end
    end

    def exists?(email)
      !!(@contacts.detect do |contact|
        contact.email.downcase == email.downcase
      end)
    end

    def show(index)
      existing_contact = @contacts[index]
      if !existing_contact
        'Sorry cannot find contact with that ID'.red
      else
        existing_contact
      end
    end
  end

  def process_numbers(phones)
    phones.each_slice(2).to_a.each do |name_and_number|
      @phone_numbers << name_and_number
    end
  end

  DEFAULT_CONTACTS = [
    Contact.new('Aldo Boris', 'aldo.boris@gmail.com', ['Home', '778-282-2148', 'Mobile', '782-338-2642']),
    Contact.new('Doris Grey', 'greymon83@hotmail.com'),
    Contact.new('Lous Renard', 'renous@gmail.com', ['Home', '778-282-2348', 'Mobile', '782-238-2382']),
    Contact.new('Onyx Ratt', 'Rottxy@facebook.com'),
    Contact.new('Doris Malard', 'dmal@gmail.com')
  ]

  @contacts = DEFAULT_CONTACTS
end
