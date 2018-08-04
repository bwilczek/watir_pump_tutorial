# frozen_string_literal: true

class FormPage3_3 < WatirPump::Page
  uri '/form.html'

  # Element writers. Names have to match the the keys of the hash provided to `fill_form` method
  text_field_writer :name, id: 'name'
  textarea_writer :description, id: 'description'

  # Element readers declared here will be used by method `form_data`
  # to return a hash of values returned by individual readers (where reader names are the keys)
  # NOTE: usually, in real life apps, readers and writers live on different pages
  #   (in Rails it would be `show` for readers and `edit` for writers)
  span_reader :name, id: 'res_name'
  span_reader :description, id: 'res_description'

  # TODO refactor me
  radio_writer :gender, name: 'gender'
  span_reader :gender, id: 'res_gender'

  radio_group :predicate, name: 'predicate'
  span_reader :predicate, id: 'res_predicate'

  checkbox_writer :hobbies, name: 'hobbies[]'
  custom_reader :hobbies
  query :hobbies, -> { split_span('res_hobbies') }

  checkbox_writer :continents, name: 'continents[]'
  custom_reader :continents, -> { split_span('res_continents') }

  select_writer :car, name: 'car'
  span_reader :car, id: 'res_car'

  select_writer :ingredients, name: 'ingredients[]'
  custom_reader :ingredients

  button_clicker :submit, id: 'generate'

  query :split_span, ->(id) { root.span(id: id).text.split(', ') }

  def ingredients
    root.ul(id: 'res_ingredients')&.lis&.map(&:text) || []
  end
  # refactor code above

  button_clicker :submit, id: 'generate'
end

RSpec.describe FormPage3_3 do
  let(:data) do
    {
      name: 'Kasia',
      description: 'I like pie. And cookies.',
      gender: 'Female',
      predicate: 'No',
      hobbies: ['Gardening', 'Dancing'],
      continents: ['Asia', 'Africa'],
      car: 'Opel',
      ingredients: ['Mozarella', 'Eggplant']
    }
  end

  it 'fills the form' do
    FormPage3_3.open do
      fill_form!(data)
      expect(form_data).to eq data
    end
  end
end
