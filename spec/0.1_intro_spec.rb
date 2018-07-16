# frozen_string_literal: true

class IndexPage < WatirPump::Page
  uri '/index.html'
  h1 :header
end

RSpec.describe IndexPage do
  it 'displays header' do
    IndexPage.open do
      expect(header).to be_instance_of Watir::Heading
      expect(header.text).to eq 'Welcome to WatirPump tutorial'
    end
  end
end
