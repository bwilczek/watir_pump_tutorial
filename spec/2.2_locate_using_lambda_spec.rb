# frozen_string_literal: true

class GreeterPage < WatirPump::Page
  uri '/greeter.html'

  text_field :name, -> { root.text_field(id: 'name') }
  button :set, -> (id) { root.button(id: id) }
  div :greeting, id: 'greeting'
  span :greeted_name, -> { greeting.span }
end

RSpec.describe GreeterPage do
  it 'displays greeting' do
    GreeterPage.open do
      name.set 'Bogdan'
      set('set_name').click
      expect(greeting.text).to eq 'Hello Bogdan!'
      expect(greeted_name.text).to eq 'Bogdan'
    end
  end
end
