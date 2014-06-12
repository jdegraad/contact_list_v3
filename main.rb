#!/usr/bin/env ruby
require_relative 'contact'
require_relative 'application'
require_relative 'contact_database'

ContactDatabase.open_from_file
Application.new.run
ContactDatabase.save_to_file(Contact.contacts)
