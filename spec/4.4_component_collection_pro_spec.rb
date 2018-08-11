# frozen_string_literal: true

# Page under test: todo_lists.html

class ToDoListItem4_4 < WatirPump::Component
  span_reader :label, role: 'name'
  link_clicker :remove, role: 'rm'
end

class ToDoList4_4 <  WatirPump::Component
  div_reader :title, role: 'title'
  text_field_writer :item_name, role: 'new_item'
  button_clicker :submit, role: 'add'
  components :items, ToDoListItem4_4, :lis
  query :values, -> { items.map(&:label) }

  def [](label)
    items.find { |i| i.label == label }
  end

  # Introduce the two methods below to make the spec look more natural
  def add(item_name)
    fill_form!(item_name: item_name)
  end

  def include?(item)
    !self[item].nil?
  end
end

class CollectionIndexedByTitle4_4 < WatirPump::ComponentCollection
  def [](title)
    find { |l| l.title == title }
  end
end

class ToDoListPage4_4 < WatirPump::Page
  uri '/todo_lists.html'

  components :todo_lists, ToDoList4_4, -> { root.divs(role: 'todo_list') }
  decorate :todo_lists, CollectionIndexedByTitle4_4
end

RSpec.describe ToDoListPage4_4 do
  it 'Adds and removes items' do
    ToDoListPage4_4.open do
      todo_lists['Groceries'].add('Pineapple')
      expect(todo_lists['Groceries']).to include 'Pineapple'

      todo_lists['Work'].add('Read RubyWeekly')
      expect(todo_lists['Work']).to include 'Read RubyWeekly'

      todo_lists['Groceries']['Bread'].remove
      expect(todo_lists['Groceries']).not_to include 'Bread'
    end
  end
end
