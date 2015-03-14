class Book
  include Mongoid::Document
  field :name, type: String
  field :author, type: String
  field :tag, type: String
  field :donor, type: String
  # field :evaluation, type: String
  field :donate_time, type: DateTime
  field :status, type: String
  field :restitution_time, type: DateTime
  # field :borrower, type: String
  field :barcode, type: String
  field :borrow_times, type: String

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :borrower, class_name: 'Book'
  has_many :evaluations
  belongs_to :donor
end