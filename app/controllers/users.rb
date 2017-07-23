Taosimnet::App.controllers :users do

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

  end

  get :me do
    if session[:userId].nil?
      redirect_to url(:user_session, :new)
    end
    render 'me'
  end



  get :new do

  end

  post :save_draft do
    puts params[:post].to_json
  end

  post :create do

  end

end
