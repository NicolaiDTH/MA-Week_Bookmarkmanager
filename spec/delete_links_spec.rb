require 'spec_helper'

feature 'deleting links' do
  scenario 'deleting a link' do
    Link.create(title: 'Google', url: 'http://google.com')
    expect(Link.count).to eq(1)
    visit '/links'
    click_link 'omit'
    expect(Link.count).to eq(0)
  end
end