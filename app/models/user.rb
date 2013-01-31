class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :images
  has_many :blogs

  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true, :on => :create
  validates :password, :presence => true, :confirmation => true, :on => :update, :unless => lambda { self.password.blank? }
  validates_presence_of :first_name, :last_name

  def to_s
    "#{first_name} #{last_initial}"
  end

  private

    def last_initial
      "#{last_name[0]}."
    end
end
