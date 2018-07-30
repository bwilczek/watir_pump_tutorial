# frozen_string_literal: true

# Step 1: declare the class for page under test (index.html)
class IndexPage1_1 < WatirPump::Page
  # *REQUIRED*: URI of this page, relative to WatirPump.config.base_url
  uri '/index.html'

  # List of page elements, that we wish to interact with.
  # In this example we care only about the top header (the first `h1` found)
  h1 :header
  # More information about elements will come in the following chapters
end

# Step 2: create a spec for it
RSpec.describe IndexPage1_1 do
  it 'displays header element' do
    # Once page class is defined use a class method `open` to interact with it.
    # The declared elements (here: `header`) are available in the block passed to `open`.
    IndexPage1_1.open do
      expect(header).to be_instance_of Watir::Heading
      expect(header.text).to eq 'Welcome to WatirPump tutorial'
    end
  end

  # Page instance contains not only elements explicity declared in class definition.
  # It also provides references to browser instance, and the root element in the DOM tree.
  # All elements declared in class definition are being located relatively to this root.
  # For Pages root always points to `browser` reference.
  # In the following chapters, when Components are introduced, this term will gain more significance.
  it 'demonstrates Page instance API' do
    IndexPage1_1.open do
      # self.browser is a reference to Watir::Browser instance assosciated with current session.
      # @see https://www.rubydoc.info/gems/watir/Watir/Browser
      expect(browser).to be_instance_of Watir::Browser
      expect(browser.title).to include 'WatirPump'

      # Examine the lines below to learn how the element declaration in line 10 (`h1 :header`)
      # relates to Watir API for querying the DOM tree
      expect(root).to eq browser
      expect(root.body).to be_kind_of Watir::Body
      expect(root.h1).to eq header
      expect(browser.body.h1).to eq header

      # loaded? is always truthy here: this block would not execute if page was not loaded.
      # See chapter 1.3 to learn how to create custom criteria for page being loaded.
      expect(loaded?).to be_truthy
    end
  end
end
