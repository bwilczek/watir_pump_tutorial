# frozen_string_literal: true

class GreeterPage2_1 < WatirPump::Page
  uri '/greeter.html'

  # Each element declaration consists of 3 parts:
  # - Watir method name (from Watir::Container module). Here: text_field
  #     @see https://www.rubydoc.info/gems/watir/Watir/Container
  # - Name of the element inside this page object. Here: name
  # - Watir locator hash. Here: { id: 'name' }
  #     @see http://watir.com/guides/locating/
  text_field :name, id: 'name'
  # One can consider the line above to be the equivalent of:
  #   def name
  #     root.text_field(id: 'name') # root == browser in case of Pages
  #   end

  # The following two elements follow the same convention
  button :set, id: 'set_name'
  div :greeting, id: 'greeting'
end

RSpec.describe GreeterPage2_1 do
  it 'returns the right types' do
    GreeterPage2_1.open do
      expect(name).to eq root.text_field(id: 'name')
      expect(name).to be_a Watir::TextField
    end
  end

  it 'displays greeting' do
    GreeterPage2_1.open do
      name.set 'Bogdan'
      set.click
      expect(greeting.text).to eq 'Hello Bogdan!'
    end
  end
end
