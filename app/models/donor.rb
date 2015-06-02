class Donor
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :address, type: String
  field :identify, type: String
  field :wordsto, type: String

  validates :name, presence: true
  validates :phone, presence: true
  # validates :identify, presence: true

  has_many :donored_books, class_name: 'Book'
end
