# frozen_string_literal: true

# Page under test: todo_lists.html

# ToDoListItem class: same as in previous example, but without network delays
class ToDoListItem4_3 < WatirPump::Component
  span_reader :label, role: 'name'
  link_clicker :remove, role: 'rm'
end

# ToDoList class: same as in previous example, but without network delays
class ToDoList4_3 <  WatirPump::Component
  div_reader :title, role: 'title'
  text_field_writer :item_name, role: 'new_item'
  button_clicker :submit, role: 'add'
  components :items, ToDoListItem4_3, :lis
  query :values, -> { items.map(&:label) }

  def [](label)
    items.find { |i| i.label == label }
  end
end

# A decorator class for the collection of components declared in the Page class below.
# Adds [] "operator" to allow access to individual ToDoList by its title
class CollectionIndexedByTitle4_3 < WatirPump::ComponentCollection
  def [](title)
    find { |l| l.title == title }
  end
end

class ToDoListPage4_3 < WatirPump::Page
  uri '/todo_lists.html'

  # Collection of components, this time located by a lambda
  components :todo_lists, ToDoList4_3, -> { root.divs(role: 'todo_list') }

  # Use `decorate` to wrap given method (here: `todo_lists`) with a decorator class
  #   that will add provide additional features of the object returned initially.
  #   Here the decorator class `CollectionIndexedByTitle4_3` modified behavior of [] operator.
  decorate :todo_lists, CollectionIndexedByTitle4_3
end

RSpec.describe ToDoListPage4_3 do
  it 'fills the form' do
    ToDoListPage4_3.open do
      # There are three ToDoLists on the page.
      # The collection can be accessed through `todo_lists` method.
      # Thanks to decoration they can be accessed by the list title, instead of integer array index.

      todo_lists['Groceries'].fill_form!(item_name: 'Pineapple')
      expect(todo_lists['Groceries'].values).to include 'Pineapple'

      todo_lists['Work'].fill_form!(item_name: 'Implement class ElementDecorator')
      expect(todo_lists['Work'].values).to include 'Implement class ElementDecorator'

      todo_lists['Groceries']['Bread'].remove
      expect(todo_lists['Groceries'].values).not_to include 'Bread'
    end
  end
end
