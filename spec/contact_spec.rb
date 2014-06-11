require 'rspec'
require_relative '../contact'

describe Contact do
  before :each do
    Object.send(:remove_const, 'Contact')
    load 'contact.rb'
  end

  describe 'initialization' do

  end

  describe '#to_s' do

  end

  # use . for class methods
  describe '.create' do
    it 'exists' do
      expect(Contact).to respond_to(:create)
    end

    it 'saves contact to class variable' do
      Contact.create('Doil Sel', 'dsel@gmail.com')
      contact = Contact.contacts.size
      expect(contact).to eq 5
    end
  end

  # use . for class methods
  describe '.find' do

  end

  # use . for class methods
  describe '.all' do

  end

end
