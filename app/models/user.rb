class User
  include Mongoid::Document

  field :card_num, type: String
  field :student_id, type: String
  field :true_name, type: String
  field :college, type: String
  field :introduce, type: String
  field :phone, type: String
  field :status, type: String
end
