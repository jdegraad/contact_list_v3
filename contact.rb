require 'pry'
require 'colorize'
# # Class for individual contacts, also holds
# # a list of all contacts
class Contact
  attr_accessor :name
  attr_accessor :email

  def initialize(name, email)
    @name = name
    @email = email
  end

  def to_s
    "(#{@name}) #{@email}".green
  end

  DEFAULT_CONTACTS = [
    Contact.new('Aldo Boris', 'aldo.boris@gmail.com'),
    Contact.new('Doris Grey', 'greymon83@hotmail.com'),
    Contact.new('Lous Renard', 'renous@gmail.com'),
    Contact.new('Onyx Ratt', 'Rottxy@facebook.com'),
    Contact.new('Doris Malard', 'dmal@gmail.com')
  ]
  ## In-memory list of contacts
  class << self
    attr_reader :contacts

    def create(name, email)
      @contacts << Contact.new(name, email) unless exists? email
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
  end

  @contacts = DEFAULT_CONTACTS
end
