# frozen_string_literal: true

class GreeterPage2_6 < WatirPump::Page
  uri '/greeter.html'

  # `writer` macro works similarly as `reader` and `clicker`.
  # The main difference is that it generates method with a name ending with `=`
  text_field_writer :name, id: 'name'

  button_clicker :greet, id: 'set_name'
  div_reader :greeting, id: 'greeting'
end

RSpec.describe GreeterPage2_6 do
  it 'displays greeting' do
    GreeterPage2_6.open do
      # Remember to invoke the writer method with `self.`.
      # Otherwise a local variable with that name will be created.
      self.name = 'Bogdan'

      # <name>_writer_element method is defined befind the scene to provide accesss to the associated element
      expect(name_writer_element).to be_a(Watir::TextField)

      greet
      expect(greeting).to eq 'Hello Bogdan!'
    end
  end
end
