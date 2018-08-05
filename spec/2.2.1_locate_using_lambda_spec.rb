# frozen_string_literal: true

class GreeterPage2_2_1 < WatirPump::Page
  uri '/greeter.html'

  # This notation can be considered a shorthand for a regular method declaration
  text_field :name, -> { root.text_field(id: 'name') }
  # The line above is equivalent to this pseudocode:
  #   def name
  #     element = root.text_field(id: 'name')
  #     # whatever is inside the body of the lambda comes here
  #     raise 'some message' unless element.is_a? TextField
  #     element
  #   end

  # The lambda can be parametrized
  button :set, ->(id) { root.button(id: id) }
  # The line above is equivalent to the following pseudocode:
  #   def set(id)
  #     element = root.button(id: id)
  #     raise 'some message' unless element.is_a? Button
  #     element
  #   end

  # The type of the located element is validated against the class macro name. Here: button
  button :not_a_button, -> { root.text_field(id: 'name') }
  # As the spec below demostrates method created this way is exptected to throw an exception

  # Let's add a 'regularly' located element
  div :greeting, id: 'greeting'

  # Elemtents located with lambdas can refer to other elements
  span :greeted_name, -> { greeting.span }
  # There is no way to achieve this behavior without lambdas
end

RSpec.describe GreeterPage2_2_1 do
  it 'displays greeting' do
    GreeterPage2_2_1.open do
      expect(name).to be_a(Watir::TextField)
      name.set 'Bogdan'

      expect(set('set_name')).to be_a(Watir::Button)
      set('set_name').click

      expect(greeting).to be_a(Watir::Div)
      expect(greeting.text).to eq 'Hello Bogdan!'

      expect(greeted_name).to be_a(Watir::Span)
      expect(greeted_name.text).to eq 'Bogdan'

      expect { not_a_button }.to raise_error(WatirPump::Errors::ElementMismatch)
    end
  end
end
