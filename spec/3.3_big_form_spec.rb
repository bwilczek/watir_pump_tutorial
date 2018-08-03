# frozen_string_literal: true

class FormPage3_3 < WatirPump::Page
  uri '/form.html'

  # Element writers. Names have to match the the keys of the hash provided to `fill_form` method
  text_field_writer :name, id: 'name'

  # Element readers declared here will be used by method `form_data`
  # to return a hash of values returned by individual readers (where reader names are the keys)
  # NOTE: usually, in real life apps, readers and writers live on different pages
  #   (in Rails it would be `show` for readers and `edit` for writers)
  span_reader :name, id: 'res_name'

  button_clicker :submit, id: 'generate'
end

RSpec.describe FormPage3_3 do
  let(:data) do
    OpenStruct.new.tap do |d|
      d.name = 'Kasia'
    end
  end

  it 'fills the form' do
    FormPage3_3.open do
      fill_form!(data)
      expect(form_data).to include(name: 'Kasia')
    end
  end
end
