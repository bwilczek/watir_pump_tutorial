# frozen_string_literal: true

class GreeterPage2_5 < WatirPump::Page
  uri '/greeter.html'

  text_field :name, id: 'name'

  # `clicker` macro is smilar to `reader`. If for given element the only action
  # that makes sense from the perspective of test logic is clicking then an elemet `clicker`
  # should be declared instead of an element.
  button_clicker :set, id: 'set_name'

  div_reader :greeting, id: 'greeting'
end

RSpec.describe GreeterPage2_5 do
  it 'displays greeting' do
    GreeterPage2_5.open do
      name.set 'Bogdan'
      set

      # <name>_clicker_element method is defined befind the scene to provide accesss to the associated element
      expect(set_clicker_element).to be_a(Watir::Button)
      expect(greeting).to eq 'Hello Bogdan!'
    end
  end
end
