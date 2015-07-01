require 'rails_helper'

describe 'Snippet page' do
  let!(:snippet) { Snippet.create(body: 'Lorem ipsum dolore amet') }

  it 'is accessible directly' do
    visit "/snippets/#{snippet.id}"

    expect(page).to have_selector('h2',             text: "Snippet ##{snippet.id}")
    expect(page).to have_selector('.snippet__body', text: snippet.body)
    expect(find('.snippet__shareLink input').value).to eq("http://www.example.com/snippets/#{snippet.id}")
  end

  it 'is accessible from the front page' do
    visit '/'
    click_link "##{snippet.id}"

    expect(page).to have_selector('h2',             text: "Snippet ##{snippet.id}")
    expect(page).to have_selector('.snippet__body', text: snippet.body)
    expect(find('.snippet__shareLink input').value).to eq("http://www.example.com/snippets/#{snippet.id}")
  end
end
