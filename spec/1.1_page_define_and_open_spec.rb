# frozen_string_literal: true

# Step 1: declare the class for page under test (index.html)
class IndexPage < WatirPump::Page
  # *REQUIRED*: URI of this page, relative to WatirPump.config.base_url
  uri '/index.html'

  # List of page elements, that we wish to interact with.
  # In this example we care only about the top header (the first `h1` found)
  h1 :header
  # More information about elements will come in the following chapters
end

# Step 2: create a spec for it
RSpec.describe IndexPage do
  it 'displays header' do
    # Once page class is defined use a class method `open` to interact with it.
    # The declared elements (here: `header`) are available in the block passed to `open`.
    IndexPage.open do
      expect(header).to be_instance_of Watir::Heading
      expect(header.text).to eq 'Welcome to WatirPump tutorial'
    end
  end
end
