require 'rails_helper'

describe Snippet do
  subject { Snippet.new }

  it do
    should validate_length_of(:body).is_at_most(8192)
    should validate_presence_of(:body)
  end
end
