class User
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  field :card_num, type: String
  field :password, type: String
  field :student_id, type: String
  field :true_name, type: String
  field :college, type: String
  field :introduce, type: String
  field :phone, type: String
  field :status, type: String
  field :is_admin, type: Boolean
  field :uuid, type: String
  field :sex, type: String

  validates :card_num, presence: true,
                      uniqueness: true

  has_and_belongs_to_many :borrowed_books, 
                          class_name: 'Book', 
                          inverse_of: :borrower

  has_many :reserved_books,
           class_name: 'Book',
           inverse_of: :reserver

  has_one :current_borrow_book, 
          class_name: 'Book', 
          inverse_of: :current_borrowed_user

  has_many :evaluations

  def borrow(book)
    if book.status == 'BORROWED'
      return "HAS_BEEN_BORROWED"
    end

    if self.borrowed_books.count >= Setting.get_option('max_borrow_count')
      return "BORROW_BEYOND_RANGE"
    end

    self.borrowed_books << book
    now_time = Time.now
    book.update_attributes(:status => 'BORROWED', 
                           :borrow_time => now_time, 
                           :shoud_restitution_time => now_time + Setting.get_option('can_borrow_time').to_i)
  end

  def restitution(book)
    book.update_attributes(:status => 'CANBORROW', 
                           :actual_restitution_time => Time.now)
  end

  def auth
    params = {'user' => self.card_num, 
              'password' => self.password, 
              'appid' => '8a3fba612f4688b795d15d468e39e059'
            }
    puts self.password
    response = Net::HTTP.post_form(URI.parse('http://herald.seu.edu.cn/uc/auth'),params)

    if response.code == "200"
      self.uuid = response.body
      return "AUTH_SUCCESS"
      # self.update_attribute("uuid", response.body)
    elsif response.code == "401"
      return "WRONG_USERNAME_OR_PASSWORD"
    else
      return false
    end
  end

  def get_user_info
    if self.uuid.nil?
      return "WRONG_UUID"
    end

    params = {
      'uuid' => self.uuid
    }

    response = Net::HTTP.post_form(URI.parse('http://herald.seu.edu.cn/api/user'), params)
    response_data_json = JSON::parse(response.body)
    true_name = response_data_json['content']['name']
    study_num = response_data_json['content']['schoolnum']
    sex = response_data_json['content']['sex']
    self.update_attributes({:true_name => true_name, :student_id => study_num, :sex => sex})
  end
end
