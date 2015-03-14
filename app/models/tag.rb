class Tag
  include Mongoid::Document

  field :name, type: String
  field :books, type: String

  has_and_belongs_to_many :books
end
