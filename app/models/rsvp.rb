class Rsvp < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :attending, numericality: true, presence: true

  attr_accessible :name, :attending

end