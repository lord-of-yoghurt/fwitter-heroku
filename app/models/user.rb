class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :email, presence: true
  validates :username, presence: :true
  validates :password, length: { in: 6..20 }

  def slug
    username.downcase.split(/[^a-zA-Z0-9]+/).join('-')
  end

  def self.find_by_slug(slug)
    self.all.find{|obj| obj.slug == slug}
  end

end