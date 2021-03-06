class Admin::UsersController < Admin::AdminController


  # GET /admin_users
  # GET /admin_users.xml
  def index
    @search = User.search(params[:search])
    @search.order = "ascend_by_login" unless @search.order
    @users =  @search.paginate(:page => params[:page], :include=>[])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => User.all }
    end
  end

  # GET /admin_users/1
  # GET /admin_users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /admin_users/new
  # GET /admin_users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # POST /admin_users
  # POST /admin_users.xml
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        @user.is_admin = params[:user][:is_admin] if admin?
        @user.is_staff = params[:user][:is_staff]
        @user.save
        flash[:notice] = t('users.created')
        format.html { redirect_to(admin_user_url(@user)) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])  
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      @user.is_admin = params[:user][:is_admin] if admin?
      @user.is_staff = params[:user][:is_staff]
      @user.save
      flash[:notice] = t('users.updated')
      redirect_to admin_user_url(@user)
    else
      render :action => 'edit'
    end
  end

  def reset_password
    @user = User.find(params[:id])
    @user.deliver_password_reset_instructions!
    flash[:notice] = t('users.password_sent')
    redirect_to admin_user_path(@user)
  end

  # DELETE /admin_users/1
  # DELETE /admin_users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.delete
    flash[:notice] = t('users.destroyed')
    redirect_to admin_users_url
  end
end
