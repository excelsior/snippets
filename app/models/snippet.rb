class Snippet < ActiveRecord::Base
  validates :body, length: { maximum: 8192 }, presence: true
end
