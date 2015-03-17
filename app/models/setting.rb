class Setting
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def self.get_option(option)
    self.first[option]
  end

  def self.set_option(key, value)
    if self.first.nil?
      object = self.new(key => value)
      object.save
    else
      self.first.update_attribute(key,value)
    end
  end
end
