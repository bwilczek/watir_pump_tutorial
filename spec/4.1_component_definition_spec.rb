# frozen_string_literal: true

class ToDoList4_1 < WatirPump::Component
  text_field_writer :item_name, role: 'new_item'
  button_clicker :submit, role: 'add'
  query :values, -> { root.ul.spans(role: 'name').map(&:text) }
end

class ToDoListPage4_1 < WatirPump::Page
  uri '/todo_list.html'

  component :todo_list, ToDoList4_1, :div, id: 'todos_groceries'
  # alternatively can be located with a lambda:
  # component :todo_list, ToDoList4_1, -> { root.div( id: 'todos_groceries' ) }
end

RSpec.describe ToDoListPage4_1 do
  let(:list_item) { { item_name: item_name } }
  let(:item_name) { 'Pineapple' }
  it 'fills the form' do
    ToDoListPage4_1.open do
      todo_list.fill_form!(list_item)
      expect(todo_list.values).to include item_name
    end
  end
end
