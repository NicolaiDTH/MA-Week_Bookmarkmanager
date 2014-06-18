require 'spec_helper'

feature 'deleting links' do
  scenario 'deleting a link I just added' do
    Link.create(title: 'Google', url: 'http://google.com')
    Link.create(title: 'Bing', url: 'http://bing.com')
    expect(Link.count).to eq(2)
    visit '/links'
    click_link 'Delete Google'
    click_link 'Delete Bing'
    expect(Link.count).to eq(0)
  end
end