# # Class for individual contacts, also holds
# # a list of all contacts
class Contact
  DEFAULT_CONTACTS = [
    {
      name: 'Aldo Boris',
      email: 'aldo.boris@gmail.com'
    },
    {
      name: 'Doris Grey',
      email: 'greymon83@hotmail.com'
    },
    {
      name: 'Lous Renard',
      email: 'renous@gmail.com'
    },
    {
      name: 'Onyx Ratt',
      email: 'Rottxy@facebook.com'
    }
  ]
  ## In-memory list of contacts
  class << self
    attr_accessor :contacts

    def create(name, email)
      @contacts << { name: name, email: email }
    end
  end

  @contacts = DEFAULT_CONTACTS

  #   attr_accessor :name
  #   attr_accessor :email
  #
  #   def initialize(name, email)
  #     # @name = name
  #     # @email = email
  #   end
  #
  #   def to_s
  #     # TODO: return string representation of Contact
  #   end
  #
  #
  #   def find(index)
  #     # @@contacts[index]
  #   end
  #
  #   def all
  #     # @contacts
  #   end
  #
  #
end
