require 'rails_helper'

describe Snippet do
  subject { Snippet.new }

  it do
    should validate_length_of(:body).is_at_most(8192)
    should validate_presence_of(:body)
  end

  describe '#truncated_body' do
    it do
      snippet = Snippet.new
      expect(snippet.truncated_body).to eq('')

      snippet.body = 'One two three four five'
      expect(snippet.truncated_body).to    eq('One two three four five')
      expect(snippet.truncated_body(5)).to eq('One two three four five')
      expect(snippet.truncated_body(4)).to eq('One two three four…')
      expect(snippet.truncated_body(3)).to eq('One two three…')
    end
  end
end
