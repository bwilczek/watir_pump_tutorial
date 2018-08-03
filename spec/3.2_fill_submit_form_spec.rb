# frozen_string_literal: true

class ToDoListPage3_2 < WatirPump::Page
  uri '/todo_list.html'

  text_field_writer :item_name, role: 'new_item'

  # When a method responsible for form submission is called `submit`
  # it will be invoked automatically by `fill_form!` method
  button_clicker :submit, role: 'add'

  query :values, -> { root.ul.spans(role: 'name').map(&:text) }
end

RSpec.describe ToDoListPage3_2 do
  let(:list_item) { { item_name: item_name } }
  let(:item_name) { 'Pineapple' }
  it 'fills the form' do
    ToDoListPage3_2.open do
      # No need to invoke `submit` explicitly. `fill_form!` will do it automatically.
      fill_form!(list_item)
      expect(values).to include item_name
    end
  end
end
