# frozen_string_literal: true

class ToDoListPage3_1 < WatirPump::Page
  uri '/todo_list.html'

  # Define a writer for each form element
  text_field_writer :item_name, role: 'new_item'

  button_clicker :add, role: 'add'

  # `query` macro is a shorthand for a quick method definition
  query :values, -> { root.ul.spans(role: 'name').map(&:text) }
  # The line above is the equivalent of:
  # def values
  #   root.ul.spans(role: 'name').map(&:text)
  # end
end

RSpec.describe ToDoListPage3_1 do
  let(:list_item) { { item_name: item_name } }
  let(:item_name) { 'Pineapple' }
  it 'fills the form' do
    ToDoListPage3_1.open do
      # fill_form method accepts an object with data (Hash, Struct, OpenStruct, anything that responds to to_h)
      # for each of the keys it invokes an associated element writer method, and passes the value to it
      # Here the `list_item` object has only one key (`item_name`) with value 'Pineapple'
      # so `fill_form` will do just: `self.item_name = 'Pineapple'`
      # See example 3.3 to see how it can help with bigger forms
      fill_form(list_item)

      add
      expect(values).to include item_name
    end
  end
end
