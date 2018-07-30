# frozen_string_literal: true

class GreeterPage < WatirPump::Page
  uri '/greeter.html'

  # `element` macro acts similarly as macros specific to certain Watir methods
  # It does validate that the returned value is a generic Element,
  #  while the former validate the exact element type
  element :name, -> { root.text_field(id: 'name') }
  element :set, ->(id) { root.button(id: id) }
  element :greeting, -> { root.div(id: 'greeting') }
  element :greeted_name, -> { greeting.span }

  # If lambda returns invalid value (here a String instead of an Element)
  #  an exception will be raised
  element :not_an_element, -> { greeting.span.text }
end

RSpec.describe GreeterPage do
  it 'displays greeting' do
    GreeterPage.open do
      expect(name).to be_a(Watir::TextField)
      name.set 'Bogdan'

      expect(set('set_name')).to be_a(Watir::Button)
      set('set_name').click

      expect(greeting).to be_a(Watir::Div)
      expect(greeting.text).to eq 'Hello Bogdan!'

      expect(greeted_name).to be_a(Watir::Span)
      expect(greeted_name.text).to eq 'Bogdan'

      expect { not_an_element }.to raise_error(/element method did not return a Watir::Element/)
    end
  end
end
