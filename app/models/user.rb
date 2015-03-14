class User
  include Mongoid::Document

  field :card_num, type: String
  field :student_id, type: String
  field :true_name, type: String
  field :college, type: String
  field :introduce, type: String
  field :phone, type: String
  field :status, type: String

  validates :card_num, presence: true,
                      uniqueness: true

  has_and_belongs_to_many :borrowed_books, 
                          class_name: 'Book', 
                          inverse_of: :borrower

  has_one :current_borrow_book, 
          class_name: 'Book', 
          inverse_of: :current_borrowed_user

  has_many :evaluations

  def borrow(book)
    if book.status == 'BORROWED'
      return false
    end

    self.borrowed_books << book
    now_time = Time.now
    book.update_attributes(:status => 'BORROWED', 
                           :borrow_time => now_time, 
                           :shoud_restitution_time => now_time + Setting.new.can_borrow_time)
  end

  def restitution(book)
    book.update_attributes(:status => 'CANBORROW', 
                           :actual_restitution_time => Time.now)
  end
end
