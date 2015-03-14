class Donor
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :address, type: String
  field :identify, type: String
  field :wordsto, type: String
  field :donored_books, type: String
end
