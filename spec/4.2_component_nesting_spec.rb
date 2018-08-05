# frozen_string_literal: true

# Page under test: todo_list.html

# Let's extract the ToDo list item into a sub-component
# and add support for the item removal
class ToDoListItem4_2 < WatirPump::Component
  span_reader :label, role: 'name'

  # Simple link_clicker macro would not work here because of network delay.
  # Only after the element is not present anymore this method can return
  def remove
    root.link(role: 'rm').click
    # The line below makes use of two concepts:
    #  - *_reader_element method created automatically next to the actual reader method. Here: `label`
    #  - Watir's `Element#wait_while_present`
    label_reader_element.wait_while_present
  end
end

class ToDoList4_2 < WatirPump::Component
  text_field_writer :item_name, role: 'new_item'

  # Components can be nested. And grouped into array-like collections.
  # ToDoList contains a collection of ToDoListItems.
  # The location expression (here: `:lis`) must return a Watir::ElementCollection
  components :items, ToDoListItem4_2, :lis
  query :values, -> { items.map(&:label) }

  # The shortcut in the line below won't work because of the network delay:
  #  button_clicker :submit, role: 'add'
  # A real `submit` method will be required
  def submit
    cnt_before = values.count
    root.button(role: 'add').click
    # This method can return only after the new item element has been successfully added
    Watir::Wait.until { values.count > cnt_before }
  end

  # Add [] "operator" to allow accessing list items (sub-components) by their labels
  def [](label)
    items.find { |i| i.label == label }
  end
end

class ToDoListPage4_2 < WatirPump::Page
  # URL param `random_delay` enables simulation of network delays between user actions
  uri '/todo_list.html?random_delay=1'

  component :todo_list, ToDoList4_2, -> { root.div(id: 'todos_groceries') }
end

RSpec.describe ToDoListPage4_2 do
  let(:new_item) { { item_name: item_name } }
  let(:item_name) { 'Pineapple' }
  it 'fills the form' do
    ToDoListPage4_2.open do
      todo_list.fill_form!(new_item)
      # waiting for the new item to be added is a part of `fill_form` (via `submit` method)
      expect(todo_list.values).to include item_name

      # [] "operator" example use
      todo_list[item_name].remove
      # waiting for the item to  be removed is a part of `remove` method
      expect(todo_list.values).not_to include item_name
    end
  end
end
