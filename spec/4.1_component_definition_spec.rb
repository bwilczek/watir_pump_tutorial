# frozen_string_literal: true

# Page under test: todo_list.html

# Let's extract the functionality of the ToDo list into a component
# so that in could be reused on multiple pages. Or even used multiple times on the same page.
class ToDoList4_1 < WatirPump::Component
  text_field_writer :item_name, role: 'new_item'
  button_clicker :submit, role: 'add'
  query :values, -> { root.ul.spans(role: 'name').map(&:text) }
end

class ToDoListPage4_1 < WatirPump::Page
  uri '/todo_list.html'

  # Declaration of a component in page is done with `component` class macro
  # It accepts:
  #   - the name of an instance methods that will return reference to the component. Here: `todo_list`
  #   - component Class. Here: ToDoList4_1
  #   - location (mounting point) of the component in the DOM tree (same mechanism as with elements)
  component :todo_list, ToDoList4_1, :div, id: 'todos_groceries'
  # Alternatively can be located with a lambda:
  #   component :todo_list, ToDoList4_1, -> { root.div( id: 'todos_groceries' ) }
  # The "mounting point" declared here will the the `root` for the component instance.
end

RSpec.describe ToDoListPage4_1 do
  let(:list_item) { { item_name: item_name } }
  let(:item_name) { 'Pineapple' }
  it 'fills the form' do
    ToDoListPage4_1.open do
      # Component instance reference is returned by `todo_list` method.
      # Methods `fill_form` and `values` are invoked on that component.
      todo_list.fill_form!(list_item)
      expect(todo_list.values).to include item_name
    end
  end
end
