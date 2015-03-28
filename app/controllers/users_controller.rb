class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
    @users = User.page(params[:page]).per(1)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    user_temp = User.find_by(:card_num => user_params["card_num"])
    # @user = user_temp.nil? ? User.new(user_params) : user_temp
    if user_temp.nil?
      @user = User.new(user_params)
      auth = @user.auth

      respond_to do |format|
        if auth == "AUTH_SUCCESS"
          if @user.save
            @user.get_user_info
            format.html { redirect_to @user, notice: '登录成功' }
            format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        elsif auth = "WRONG_USERNAME_OR_PASSWORD"
          format.html { render :new }
          format.json { render json: "用户名密码错误", status: :unprocessable_entity }
        else
          format.html { render :new }
          format.json { render json: "服务器故障，请稍后再试", status: :unprocessable_entity }
        end
      end
    else
      @user = user_temp
      @user.update_attribute("password",user_params['password'])

      respond_to do |format|
        if @user.auth == "AUTH_SUCCESS"
          @user.update_attribute("uuid", @user.uuid)
          format.html { redirect_to @user, notice: '登录成功' }
          format.json { render :show, status: :created, location: @user }
        elsif auth = "WRONG_USERNAME_OR_PASSWORD"
          format.html { render :new }
          format.json { render json: "用户名密码错误", status: :unprocessable_entity }
        else
          format.html { render :new }
          format.json { render json: "服务器故障，请稍后再试", status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:card_num, 
                                   :password)
    end
end
