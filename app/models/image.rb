class Image < ActiveRecord::Base
  belongs_to :user

  attr_accessible :title, :image
  attr_accessor :image_file_name, 
    :image_content_type, 
    :image_file_size, 
    :image_updated_at
    
  has_attached_file :image, styles: { regular: ["500x500>", :png], thumb: ["200x200>", :png], large: ["700x700>", :png] },
    url: "/images/:id/:style/:hash.:extension",
    hash_secret: 'jerelAndLiz'

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
