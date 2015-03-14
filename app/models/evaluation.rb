class Evaluation
  include Mongoid::Document

  field :content, type: String
  field :time, type: String
  field :author, type: String
  field :book, type: String
end
