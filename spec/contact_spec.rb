require 'rspec'
require 'colorize'
require_relative '../contact'

describe Contact do
  before :each do
    Object.send :remove_const, 'Contact'
    load 'contact.rb'
  end

  describe 'initialization' do
    subject(:contact) { Contact.new 'Test', 'test@gmail.com', ['Cell', '778-713-8214'] }

    it 'creates contact' do
      expect(contact).to be_a Contact
    end

    it 'sets name' do
      expect(contact.name).to eq 'Test'
    end

    it 'sets email' do
      expect(contact.email).to eq 'test@gmail.com'
    end

    it 'sets phonenumber' do
      expect(contact.phone_numbers).to eq [['Cell', '778-713-8214']]
    end

    it 'can take multiple phone numbers' do
      contact_phone = Contact.new 'Test', 'test@g.ca', ['Cell', '778-713-8214', 'Home', '604-123-2342']
      expect(contact_phone.phone_numbers).to eq [['Cell', '778-713-8214'], ['Home', '604-123-2342']]
    end
  end

  describe '.show' do
    it 'exists' do
      expect(Contact).to respond_to :show
    end

    it 'takes index/id and returns contact' do
      expect(Contact.show(2)).to be_a Contact
    end

    it "returns string if contact isn't found" do
      expected_string = 'Sorry cannot find contact with that ID'.red
      expect(Contact.show(234_21)).to eq expected_string
    end
  end

  describe '#to_s' do
    it 'exists' do
      expect(Contact).to respond_to :to_s
    end

    it 'displays index name and email' do
      contact_string = Contact.new('Test', 'Test@g.ca').to_s
      expect_string = "(Test) Test@g.ca\n   ".green + "No numbers stored\n".red
      expect(contact_string).to eq expect_string
    end
  end

  # use . for class methods
  describe '.create' do
    it 'exists' do
      expect(Contact).to respond_to :create
    end

    it 'saves contact to class variable' do
      Contact.create 'Doil Sel', 'dsel@gmail.com'
      contacts = Contact.contacts.size
      expect(contacts).to eq 6
    end

    it 'does not save duplicate entry' do
      expect(Contact).to receive(:exists?).and_return(true)
      Contact.create 'Onyx Ratt', 'Rottxy@facebook.com'
      contact = Contact.contacts.size
      expect(contact).to eq 5
    end

    it 'saves contacts with phone numbers' do
      Contact.create 'Oatt Fjil', 'Ofil@facebook.com', %w(Mobile 778-714-6452)
      contact = Contact.contacts.size
      expect(contact).to eq 6
    end

    it 'saves contacts with multiple numbers' do
      Contact.create 'Oatt Fjil', 'Ofil@facebook.com', %w(Moblie, 778-714-6452 Home 778-323-2421)

      contact = Contact.contacts.size
      expect(contact).to eq 6
    end
  end

  # use . for class methods
  describe '.find' do
    it 'exists' do
      expect(Contact).to respond_to :find
    end

    it 'can find by name' do
      contact = Contact.find 'Onyx'
      expect(contact.size).to eq 1
    end

    it 'can find by email' do
      contact = Contact.find 'Rottxy@facebook.com'
      expect(contact.size).to eq 1
    end

    it 'returns all entries where possible' do
      contact = Contact.find 'Doris'
      expect(contact.size).to eq 2
    end
  end

  # use . for class methods
  describe '.all' do
    it 'returns all contacts' do
      expect(Contact.all.size).to eq 5
    end
  end

  describe '.exists?' do
    it 'exists' do
      expect(Contact).to respond_to(:exists?)
    end

    it 'returns true if contact exists' do
      expect(Contact.exists? 'Rottxy@facebook.com').to eq true
    end

    it 'returns false if contact does not exist' do
      expect(Contact.exists? 'Rofttxy@facebook.com').to eq false
    end
  end

  describe '#process_numbers' do
    let(:contact) { Contact.new('Test', 'example') }

    it 'exists' do
      expect(contact).to respond_to(:process_numbers)
    end

    it 'adds single number to phone variable' do
      numbers = %w(Mobile 778-714-6452)
      expect(contact.process_numbers(numbers)).to eq [%w(Mobile 778-714-6452)]
    end

    it 'adds multiple numbers to the phone variable' do
      numbers = %w(Mobile 778-723-2342 Home 123-524-2342)
      expect(contact.process_numbers(numbers)).to eq [%w(Mobile 778-723-2342), %w(Home 123-524-2342)]
    end
  end
end
