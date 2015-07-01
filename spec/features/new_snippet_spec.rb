require 'rails_helper'

describe 'New snippet' do
  scenario 'public' do
    visit '/snippets/new'
    click_button 'Save'

    expect(page).to have_selector('.alert', text: 'Snippet can\'t be blank')

    fill_in 'snippet_body', with: 'A' * 8193
    click_button 'Save'

    expect(page).to have_selector('.alert', text: 'Snippet is too long (maximum is 8192 characters)')

    fill_in 'snippet_body', with: 'Yet another snippet'
    click_button 'Save'

    snippet = Snippet.last
    expect(current_path).to eq("/snippets/#{snippet.id}")
    expect(page).to have_selector('.success', text: 'Snippet was created successfully.')

    expect(page).to have_selector('h2', text: "##{snippet.id}")
    expect(page).to have_selector('.snippet__body', text: snippet.body)
    expect(find('.snippet__shareLink input').value).to eq("http://www.example.com/snippets/#{snippet.id}")
  end

  scenario 'private' do
    visit '/snippets/new'

    fill_in 'snippet_body', with: 'Private snippet'
    check 'Private?'
    click_button 'Save'

    snippet = Snippet.last
    expect(current_path).to eq("/snippets/#{snippet.slug}")
    expect(page).to have_selector('.success', text: 'Snippet was created successfully.')

    expect(page).to have_selector('h2', text: "##{snippet.id}")
    expect(page).to have_selector('.snippet__body', text: snippet.body)
    expect(find('.snippet__shareLink input').value).to eq("http://www.example.com/snippets/#{snippet.slug}")
  end
end
