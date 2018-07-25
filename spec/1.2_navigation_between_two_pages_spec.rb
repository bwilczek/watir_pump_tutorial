# frozen_string_literal: true

class IndexPage < WatirPump::Page
  uri '/index.html'

  # Declare a link to another page
  link :greeter_link, href: 'greeter.html'
end

class GreeterPage < WatirPump::Page
  uri '/greeter.html'
  h1 :header
end

class FormPage < WatirPump::Page
  uri '/form.html'
end

RSpec.describe 'Navigation with links' do
  it 'opens a valid linked page' do
    IndexPage.open { greeter_link.click }

    # Unlike `open`, `use` method does not navigate to given page.
    # It does check if the page is loaded though.
    GreeterPage.use { expect(header.text).to include 'Greeter' }
  end

  it 'times out on an invalid page' do
    IndexPage.open { greeter_link.click }

    # When trying to interact with a page that is not open an exception is raised
    expect { FormPage.use }.to raise_error(Watir::Wait::TimeoutError)
    # The exception is `timeout` since `use` method waits a few seconds, hoping for the page to load
  end
end
