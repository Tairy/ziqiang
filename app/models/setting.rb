class Setting
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def get(key)
    self.find(key)
  end
end
