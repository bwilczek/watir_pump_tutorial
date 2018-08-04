# frozen_string_literal: true

class ToDoListItem4_3 < WatirPump::Component
  span_reader :label, role: 'name'
  link_clicker :remove, role: 'rm'
end

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

class CollectionIndexedByTitle4_3 < WatirPump::ComponentCollection
  def [](title)
    find { |l| l.title == title }
  end
end

class ToDoListPage4_3 < WatirPump::Page
  uri '/todo_lists.html'

  components :todo_lists, ToDoList4_3, -> { root.divs(role: 'todo_list') }
  decorate :todo_lists, CollectionIndexedByTitle4_3
end

RSpec.describe ToDoListPage4_3 do
  it 'fills the form' do
    ToDoListPage4_3.open do
      todo_lists['Groceries'].fill_form!(item_name: 'Pineapple')
      expect(todo_lists['Groceries'].values).to include 'Pineapple'

      todo_lists['Work'].fill_form!(item_name: 'Implement class ElementDecorator')
      expect(todo_lists['Work'].values).to include 'Implement class ElementDecorator'

      todo_lists['Groceries']['Bread'].remove
      expect(todo_lists['Groceries'].values).not_to include 'Bread'
    end
  end
end
