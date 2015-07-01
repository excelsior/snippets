class Snippet < ActiveRecord::Base
  validates :body, length: { maximum: 8192 }, presence: true

  def truncated_body(length = 15)
    return '' unless body

    truncated = (body || '').split(' ').first(length).join(' ')

    if truncated != body
      truncated + '…'
    else
      body
    end
  end
end
