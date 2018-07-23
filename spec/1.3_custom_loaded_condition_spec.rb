# frozen_string_literal: true

class IndexPage < WatirPump::Page
  uri '/index.html'
  a :slow_greeter_link, href: 'greeter.html?random_delay=1'
end

# This greeter page shows it's content after a random delay.
# `header` will not be displayed at once, although the HTML is loaded.
# One can consider that `header` is loaded using another request (XHR).
class SlowGreeterPage < WatirPump::Page
  uri '/greeter.html?random_delay=1'
  h1 :header
end

# This greeter page overwrites default mechanism for declaring page's "readiness".
# Method `loaded?` returns true after `header` has been loaded and is visible.
class FixedSlowGreeterPage < WatirPump::Page
  uri '/greeter.html?random_delay=1'
  h1 :header

  def loaded?
    header.visible?
  end
end

RSpec.describe 'Navigation with links' do
  it 'finds empty header on an incomplete page' do
    IndexPage.open { slow_greeter_link.click }

    # Default implementation of `loaded?` is used below.
    # Reports page as loaded before all XHR calls are processed.
    SlowGreeterPage.use { expect(header.text).to be_empty }
  end

  it 'finds proper header on a complete page' do
    IndexPage.open { slow_greeter_link.click }

    # Custom implementation of `loaded?` is used below.
    # Reports page as loaded when criteria explicity stated in `loaded?` method are met.
    FixedSlowGreeterPage.use { expect(header.text).to include 'Greeter' }
  end
end
