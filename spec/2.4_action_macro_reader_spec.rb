# frozen_string_literal: true

class IndexPage < WatirPump::Page
  uri '/index.html'

  # For certain cases, when the only thing that text logic needs to to with an element
  # is to read its content it is more efficient to declare an element reader
  # instead of an element
  h1_reader :header
  # The line above is the equivalent of
  # def header
  #   root.h1.text
  # end
end

# Step 2: create a spec for it
RSpec.describe IndexPage do
  it 'displays header element' do
    IndexPage.open do
      expect(header).to be_a(String)
      expect(header).to eq 'Welcome to WatirPump tutorial'

      # For every readder WatirPump creates another function: <name>_reader_element
      # that returns reference to the element associated with the reader
      expect(header_reader_element).to be_a(Watir::Heading)
    end
  end
end
