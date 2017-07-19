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
    size = User.where(name: params["username"], pass: params["criptoPassword"]).size()
    puts size;
    size.to_json

  end

  get :new do
    render 'new'
  end

  post :create do

  end

end
