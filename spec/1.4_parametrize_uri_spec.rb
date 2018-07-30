# frozen_string_literal: true

class QueryPage1_4 < WatirPump::Page
  # To learn more about URI template syntax:
  # @see https://github.com/sporkmonger/addressable
  uri '/query.html{?query*}'
end

RSpec.describe QueryPage1_4 do
  it 'displays params URL query string' do
    QueryPage1_4.open(query: { name: 'Bob', age: 34 }) do
      # `browser` is a reference to Watir browser object. It is available in all pages.
      expect(browser.url).to include('name=Bob&age=34')
      expect(browser.text).to include('name: Bob')
      expect(browser.text).to include('age: 34')
    end
  end
end
