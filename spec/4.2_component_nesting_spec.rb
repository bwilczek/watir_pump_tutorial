# frozen_string_literal: true

class ToDoListItem4_2 < WatirPump::Component
  span_reader :label, role: 'name'

  def remove
    root.link(role: 'rm').click
    label_reader_element.wait_while_present
  end
end

class ToDoList4_2 < WatirPump::Component
  text_field_writer :item_name, role: 'new_item'

  # This shortcut won't work because of the network delay:
  #  button_clicker :submit, role: 'add'
  # A real `submit` method will be required

  components :items, ToDoListItem4_2, :lis
  query :values, -> { items.map(&:label) }

  def submit
    cnt_before = values.count
    root.button(role: 'add').click
    Watir::Wait.until { values.count > cnt_before }
  end

  def [](label)
    items.find { |i| i.label == label }
  end
end

class ToDoListPage4_2 < WatirPump::Page
  uri '/todo_list.html?random_delay=1'

  component :todo_list, ToDoList4_2, -> { root.div(id: 'todos_groceries') }
end

RSpec.describe ToDoListPage4_2 do
  let(:list_item) { { item_name: item_name } }
  let(:item_name) { 'Pineapple' }
  it 'fills the form' do
    ToDoListPage4_2.open do
      todo_list.fill_form!(list_item)
      expect(todo_list.values).to include item_name
      todo_list[item_name].remove
      expect(todo_list.values).not_to include item_name
    end
  end
end
