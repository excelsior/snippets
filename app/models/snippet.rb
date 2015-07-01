class Snippet < ActiveRecord::Base
  validates :body, length: { maximum: 8192 }, presence: true

  scope :only_public, -> { where(private: false) }

  before_save :set_slug

  def to_param
    private? ? slug : id.to_s
  end

  def truncated_body(length = 15)
    return '' unless body

    truncated = (body || '').split(' ').first(length).join(' ')

    if truncated != body
      truncated + '…'
    else
      body
    end
  end

  private
    def set_slug
      if private?
        begin
          self.slug = SecureRandom.hex(8)
        end while Snippet.exists?(slug: slug)
      end

      true
    end
end
