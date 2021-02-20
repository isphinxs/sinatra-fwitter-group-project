class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slug = self.username.gsub(" ", "-")
    slug
  end

  def self.find_by_slug(slug)
    username_to_search = slug.gsub("-", " ")
    User.find_by(:username => username_to_search)
  end
end
