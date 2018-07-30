# frozen_string_literal: true

class ToDoListPage3_1 < WatirPump::Page
  uri '/todo_list.html'

  text_field_writer :item_name, role: 'new_item'

  button_clicker :add, role: 'add'

  query :values, -> { root.ul.spans(role: 'name').map(&:text) }
end

RSpec.describe ToDoListPage3_1 do
  let(:list_item) { { item_name: item_name } }
  let(:item_name) { 'Pineapple' }
  it 'fills the form' do
    ToDoListPage3_1.open do
      fill_form(list_item)
      add
      expect(values).to include item_name
    end
  end
end
