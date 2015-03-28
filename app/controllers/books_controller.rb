class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :reserve]

  # GET /books
  # GET /books.json
  def index
    # @books = Book.all
    @books = Book.page(params[:page]).per(1)

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
    unless params['reserve_user_id'].nil?
      reserver = User.find(params['reserve_user_id'])
      puts reserver
      unless reserver.nil?
        reserver.reserved_books << @book
        respond_to do |format|
          if @book.update_attributes(:reserver => reserver, :status => "RESERVED")
            format.json { render :json => "预约成功", status: :ok }
          else
            format.json { render :json => "预约失败，未知错误", status: :error }
          end
        end 
      end
      # respond_to do |format|
      #   if @book.status == "CANBORROW" && @book.update_attributes(:reserve_user_id => params['reserve_user_id'], :status => "RESERVED")
      #     format.json { render :json => "预约成功", status: :ok }
      #   else
      #     format.json { render :json => "预约失败，未知错误", status: :error }
      #   end
      # end
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
    @books = Book.where(:status => "RESERVED").page(params[:page]).per(1)
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
                                   :barcode,
                                   :status)
    end
end