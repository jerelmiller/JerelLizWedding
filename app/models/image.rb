class Image < ActiveRecord::Base
  belongs_to :user

  attr_accessible :title, :image
  has_attached_file :image,
    storage: :dropbox,
    dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
    styles: { regular: "500x500>", thumb: "200x200>", large: "700x700>" },
    dropbox_options: {
      path: proc { |style| "#{Rails.env}/#{style}/#{id}/#{image.original_filename}"}
    }

  validates_attachment :image, presence: { message: 'must be present' },
    content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }

  before_post_process :image?

  validates :title, presence: true

  private

    # Make sure we are processing an image
    def image?
      !(image_content_type =~ /^image.*/).nil?
    end
end
