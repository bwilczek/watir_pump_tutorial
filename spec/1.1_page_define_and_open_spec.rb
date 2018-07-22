# frozen_string_literal: true

class IndexPage < WatirPump::Page
  # *REQUIRED*: URI of this page, relative to WatirPump.config.base_url
  uri '/index.html'

  # list of relevant elements, in this example we care only about the top header
  # more information about elements will come in the following chapters
  h1 :header
end

RSpec.describe IndexPage do
  it 'displays header' do
    # once page class is defined use a class method `open` to interact with it
    # the declared elements (here: `header`) are available
    # in the block passed to `open`
    IndexPage.open do
      expect(header).to be_instance_of Watir::Heading
      expect(header.text).to eq 'Welcome to WatirPump tutorial'
    end
  end
end
