class Book
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  field :name, type: String
  field :author, type: String
  field :summary, type: String
  # field :tag, type: String
  # field :donor, type: String
  field :image, type: String
  field :large_image, type: String
  field :donate_time, type: DateTime
  field :status, type: String
  field :borrow_time, type: DateTime
  field :shoud_restitution_time, type: DateTime
  field :actual_restitution_time, type: DateTime
  field :barcode, type: String
  field :borrow_times, type: String
  field :reserve_user_id, type: String

  validates :name, presence: true
  validates :author, presence: true
  # validates :donor, presence: true
  validates :barcode, presence: true

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :borrowers, class_name: 'User', inverse_of: :borrowed_books
  belongs_to :reserver, class_name: 'User', inverse_of: :reserved_books
  has_one :current_borrowed_user, class_name: 'User', inverse_of: :current_borrow_book
  has_many :evaluations
  belongs_to :donor

  def current_borrower
    if self.status == 'CANBORROW'
      return false
    end

    self.borrowers.last
  end

  def confirmborrow
    if self.status == "RESERVERD"
      self.status = "BORROWED"
      self.borrowers << self.reserver
      self.reserver.borrowed_books << self
      self.reserver.save
      self.save
      self.reserver = nil
      return true
    end
    return false
  end

  def confimrestitu
    if self.status == "RESTITUTIONED"
      self.status = "CANBORROW"
      self.save
      return true
    end
    return false
  end

  def get_info_from_douban
    res = Net::HTTP.get(URI.parse("https://api.douban.com/v2/book/isbn/#{self.barcode}"))
    json_info = JSON::parse(res)
    self.name = json_info['subtitle']
    self.author = json_info['author'][0]
    self.image = json_info['image']
    self.summary = json_info['summary']
    self.large_image = json_info['images']['large']
  end
end