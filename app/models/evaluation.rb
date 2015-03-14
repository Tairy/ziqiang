class Evaluation
  include Mongoid::Document

  field :content, type: String
  field :time, type: String
  # field :author, type: String
  # field :book, type: String

  validates :content, presence: true
  validates :time, presence: true

  belongs_to :book
  belongs_to :user
end
