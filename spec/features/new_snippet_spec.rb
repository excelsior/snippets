require 'rails_helper'

describe 'New snippet' do
  scenario do
    visit '/snippets/new'
    click_button 'Save'

    expect(page).to have_selector('.alert', text: 'Snippet can\'t be blank')

    fill_in 'snippet_body', with: 'A' * 8193
    click_button 'Save'

    expect(page).to have_selector('.alert', text: 'Snippet is too long (maximum is 8192 characters)')

    fill_in 'snippet_body', with: 'Yet another snippet'
    click_button 'Save'

    expect(current_path).to eq('/')
    expect(page).to have_selector('.success', text: 'Snippet was created successfully.')

    snippet = Snippet.last
    expect(page).to have_selector('h3', text: "##{snippet.id}")
    expect(page).to have_selector('.snippet__body', text: snippet.truncated_body)
  end
end
