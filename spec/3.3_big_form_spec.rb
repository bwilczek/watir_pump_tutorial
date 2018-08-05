# frozen_string_literal: true

class FormPage3_3 < WatirPump::Page
  uri '/form.html'

  # Element writers. Names have to match the the keys of the hash provided to `fill_form` method
  # Elements can be located by both watir method notation, and lambdas
  text_field_writer :name, id: 'name'
  textarea_writer :description, -> { root.textarea(id: 'description') }
  radio_writer :gender, name: 'gender'
  radio_writer :predicate, name: 'predicate'
  checkbox_writer :hobbies, name: 'hobbies[]'
  checkbox_writer :continents, name: 'continents[]'
  select_writer :car, name: 'car'
  select_writer :ingredients, name: 'ingredients[]'

  # Element readers declared here will be used by method `form_data`
  # to return a hash of values returned by individual readers (where reader names are the keys)
  # NOTE: usually, in real life apps, readers and writers live on different pages
  #   (in Rails it would be `show` for readers and `edit` for writers)
  span_reader :name, id: 'res_name'
  span_reader :description, -> { root.span(id: 'res_description') }
  span_reader :gender, id: 'res_gender'
  span_reader :predicate, id: 'res_predicate'
  span_reader :car, id: 'res_car'

  # It happens quite often that the expected value for given key is either
  #  - spread across multiple HTML elements
  #  - require some extra processing
  # In such case `custom_readers` come handy. They can be declared in two ways
  #
  # 1. only declare that method with given name is a custom reader.
  #   It's body has to be  defined later in the code
  custom_reader :ingredients
  custom_reader :hobbies
  # query helper is a convenient way to generate one-liner methods
  query :hobbies, -> { split_span('res_hobbies') }

  # 2. One-liner readers can be declared inline with a lambda
  custom_reader :continents, -> { split_span('res_continents') }
  # NOTE: `custom_writers` are supported as well, however they are not needed as often as readers
  # custom_writer method names must end with `=` sign.

  button_clicker :submit, id: 'generate'

  # A support method that turns string (coma separated) content of a span element of provided ID
  # into an array of strings. Used in the custom readers above
  query :split_span, ->(id) { root.span(id: id).text.split(', ') }

  # Body a custom_reader declared above
  def ingredients
    root.ul(id: 'res_ingredients')&.lis&.map(&:text) || []
  end
end

RSpec.describe FormPage3_3 do
  let(:data) do
    {
      name: 'Kate',
      description: 'I like pie. And cookies.',
      gender: 'Female',
      predicate: 'No',
      hobbies: %w[Gardening Dancing],
      continents: %w[Asia Africa],
      car: 'Opel',
      ingredients: %w[Mozarella Eggplant]
    }
  end

  it 'fills the form' do
    FormPage3_3.open do
      # Invoke all the writers at once.
      # Names of the methods have to match the keys in the `data ` hash
      fill_form!(data)

      # `form_data` returns the results from all defined readers.
      expect(form_data).to eq data
    end
  end
end
