# frozen_string_literal: true

class GreeterPage2_5 < WatirPump::Page
  uri '/greeter.html'

  text_field :name, id: 'name'

  # `clicker` macro is smilar to `reader`. If for given element the only action
  # that makes sense from the perspective of test logic is clicking, then an elemet `clicker`
  # should be declared instead of an element.
  button_clicker :greet, id: 'set_name'

  div_reader :greeting, id: 'greeting'
end

RSpec.describe GreeterPage2_5 do
  it 'displays greeting' do
    GreeterPage2_5.open do
      name.set 'Bogdan'
      greet

      # For every <name>_clicker WatirPump creates another method: <name>_clicker_element
      # that returns reference to the element associated with the clicker
      expect(greet_clicker_element).to be_a(Watir::Button)
      expect(greeting).to eq 'Hello Bogdan!'
    end
  end
end
