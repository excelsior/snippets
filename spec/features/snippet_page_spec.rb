require 'rails_helper'

describe 'Snippet page' do
  context 'public' do
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

  context 'private' do
    it 'is accessible by slug only' do
      snippet = Snippet.create(body: 'Private snippet', private: true)

      visit "/snippets/#{snippet.slug}"
      expect(page).to have_selector('h2',             text: "Snippet ##{snippet.id}")
      expect(page).to have_selector('.snippet__body', text: snippet.body)
      expect(find('.snippet__shareLink input').value).to eq("http://www.example.com/snippets/#{snippet.slug}")

      expect { visit "/snippets/#{snippet.id}" }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
