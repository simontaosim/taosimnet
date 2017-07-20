Taosimnet::App.controllers :user_session do
  layout 'app'

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :index do
    redirect_to url(:user_session, :new)
  end

  post :remote_login do
    users = User.where(name: params["username"], pass: params["criptoPassword"])
    if users.size > 0
      session[:userId] =  users.first._id
      puts users.first.id
      users.size.to_json
    else
      users.size.to_json
    end


  end

  get :new do
    @user = User.where(_id: session[:userId]).first;
    puts @user
    render 'new'
  end

  post :create do

  end

end
