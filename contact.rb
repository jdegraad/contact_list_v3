class Contact

  ## In-memory list of contacts
  @@contacts = [
    # {
    #   name: "Bob",
    #   email: "bob@facebook.com"
    # },
    # {
    #   name: "Steve",
    #   email: "steve@gmail.com"
    # },
    # {
    #   name: "George",
    #   email: "george@hotmail.com"
    # },
    # {
    #   name: "Cyndi",
    #   email: "cyndi@gov.bc.ca"
    # }
  ]

  attr_accessor :name
  attr_accessor :email

  def initialize(name, email)
    # @name = name
    # @email = email
  end

  def to_s
    # TODO: return string representation of Contact
  end

  ## Class Methods
  class << self
    def create(name, email)
      # @@contacts << { name: name, email: email}
    end

    def find(index)
      # @@contacts[index]
    end

    def all
      # @@contacts
    end
  end

end
