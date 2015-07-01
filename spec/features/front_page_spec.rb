require 'rails_helper'

describe 'Front page' do
  let!(:private_snippet) { Snippet.create!(body: 'Public snippet', private: true) }
  let!(:public_snippet)  { Snippet.create!(body: 'Public snippet') }

  it 'displays only public snippets' do
    visit '/'

    expect(page).to     have_selector('h3', text: "##{public_snippet.id}")
    expect(page).not_to have_selector('h3', text: "##{private_snippet.id}")
  end
end
