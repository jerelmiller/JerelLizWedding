class Blog < ActiveRecord::Base
  belongs_to :user

  attr_accessible :title, :body, :cover_photo, :user_id

  has_attached_file :cover_photo,
    storage: :dropbox,
    dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
    styles: {
      regular: "355x355>", 
      clipped: "355x355#", 
      large: "800x800>", 
    },
    dropbox_options: {
      path: proc { |style| "#{Rails.env}/cover_photos/#{style}/#{id}/#{cover_photo.original_filename}"}
    }

  validates_attachment :cover_photo, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }

  before_post_process :image?

  validates :title, :body, presence: true
  validates :title, uniqueness: true

  private

    def image?
      !(cover_photo_content_type =~ /^image.*/).nil?
    end
end