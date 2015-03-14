class Tag
  include Mongoid::Document

  field :name, type: String
  # field :books, type: String

  validates :name, presence: true,
                   uniqueness: true
  # validates :books, presence: true

  has_and_belongs_to_many :books
end
