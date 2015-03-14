class Tag
  include Mongoid::Document

  field :name, type: String
  field :books, type: String
end
