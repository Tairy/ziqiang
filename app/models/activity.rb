class Activity
  include Mongoid::Document

  field :topic, type: String
  field :start_time, type: DateTime
  field :end_time, type: DateTime
  field :introduce, type: String

  validates :topic, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :introduce, presence: true
end
