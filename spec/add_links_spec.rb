require 'spec_helper'

feature "User adds a new link" do 
  scenario "when browsing the homepage" do 
    expect(Link.count).to eq(0)
    visit '/home'
    add_link("http://www.makersacademy.com/", "Makers Academy", ["education", "ruby"])
    expect(Link.count).to eq(1)
    link = Link.first
    expect(link.url).to eq("http://www.makersacademy.com/")
    expect(link.title).to eq("Makers Academy")
    expect(link.tags.map(&:text)).to include("education")
    expect(link.tags.map(&:text)).to include("ruby")
  end

  def add_link(url, title, tag = [])
    within('#new-link') do 
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      fill_in 'tag', :with => tag.join(' ')
      click_button 'save'
    end
  end
end