class Admin
  include Mongoid::Document

  field :username, type: String
  field :password, type: String
  field :email, type: String

  validates :username, presence: true,
                       uniqueness: true
  validates :password, presence: true
  validates :email, presence: true,
                    uniqueness: true
end
