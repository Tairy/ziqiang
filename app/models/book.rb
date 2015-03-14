class Book
  include Mongoid::Document
  field :name, type: String
  field :author, type: String
  field :tag, type: String
  # field :donor, type: String
  field :donate_time, type: DateTime
  field :status, type: String
  field :borrow_time, type: DateTime
  field :shoud_restitution_time, type: DateTime
  field :actual_restitution_time, type: DateTime
  field :barcode, type: String
  field :borrow_times, type: String

  validates :name, presence: true
  validates :author, presence: true
  # validates :donor, presence: true
  validates :barcode, presence: true

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :borrowers, class_name: 'User', inverse_of: :borrowed_books
  has_one :current_borrowed_user, class_name: 'User', inverse_of: :current_borrow_book
  has_many :evaluations
  belongs_to :donor

  def current_borrower
    if self.status == 'CANBORROW'
      return false
    end

    self.borrowers.last
  end
end