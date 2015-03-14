class Activity
  include Mongoid::Document

  field :topic, type: String
  field :start_time, type: DateTime
  field :end_time, type: DateTime
  field :introduce, type: String
end
