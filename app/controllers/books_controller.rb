class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :reserve, :restitution]

  # GET /books
  # GET /books.json
  def index
    # @books = Book.all
    @books = Book.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @books, status: :ok }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.status = "CANBORROW"

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/reserve/1
  # PATCH/PUT /books/reserve/1.json
  def reserve
    reserver = User.find(current_user._id)

    if reserver.nil?
      error = "请登录后再操作!"
      is_success = false
    elsif params['command'] == "RESERVE"
      respond_to do |format|
        if reserver.reseve(@book)
          # format.json { render :json => "预约成功", status: :ok }
          format.js
          #redirect_to @book
        else
          format.json { render :json => "书籍被预约或借出，请稍候再尝试预约！", status: :error }
        end
      end
    elsif params['command'] == "CANCELRESERVE"
      respond_to do |format|
        if reserver.cancel_reseve(@book)
          format.json { render :json => "取消预约成功", status: :ok }
        else
          format.json { render :json => "取消预约失败，请稍候尝试", status: :error }
        end
      end
    else
      respond_to do |format|
        format.json { render :json => "参数错误", status: :error }
      end
    end
  end

  def restitution
    restitutioner = User.find(params['user_id'])

    if restitutioner.nil?
      error = "参数错误，用户不存在!"
      is_success = false
    else
      respond_to do |format|
        if restitutioner.restitution(@book)
          format.json { render :json => "归还预约成功，等待管理员处理", status: :ok }
        else
          format.json { render :json => "归还失败，请稍候尝试", status: :error }
        end
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
    # if params['book']['command'] == 'CONFIRMBORROW'
    #   respond_to do |format|
    #     if @book.confirmborrow
    #       format.html { redirect_to @book, notice: '确认借出成功' }
    #     else
    #       format.html { render :reserve_list }
    #     end
    #   end
    # elsif params['book']['command'] == 'CONFIRMRESTITUTE'
    #   respond_to do |format|
    #     if @book.confimrestitu
    #       format.html { redirect_to @book, notice: '确认归还成功' }
    #     else
    #       format.html { render :restitution_list }
    #     end
    #   end
    # else
    # end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reserve_list
    @books = Book.where(:status => "RESERVERD").page(params[:page]).per(1)
  end

  def restitution_list
    @books = Book.where(:status => "RESTITUTIONED").page(params[:page]).per(1)
  end

  def outtime_list
    @books = Book.page(params[:page]).per(1)
  end

  def honor_list
    @books = Book.page(params[:page]).per(1)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, 
                                   :author, 
                                   :tags,
                                   :donate_time,
                                   :barcode)
    end

    # def response(error)
      
    # end
end