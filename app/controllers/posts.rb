Taosimnet::App.controllers :posts do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  get :index do
    @tags = Tag.order_by(:created_at => 'desc')
    @posts = Post.order_by(:created_at => 'desc')
    render 'index'
  end

  get :delete, :with => :id do
    @tags = Tag.order_by(:created_at => 'desc')
    if session[:userId].nil?
      redirect_to url(:user_session, :new)
    end
    Post.find(params[:id]).destroy
    redirect_to url(:users, :me)
  end

  get :edit, :with => :id do
    @tags = Tag.order_by(:created_at => 'desc')
    if session[:userId].nil?
      redirect_to url(:user_session, :new)
    end
    @post = Post.find(params[:id])
    puts @post.to_json
    render("edit")
  end

  get :published do
    @tags = Tag.order_by(:created_at => 'desc')
  end

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
    @tags = Tag.order_by(:created_at => 'desc')
    session[:userId].to_s

  end

  post :publish do
    # puts params[:id]
    # puts params[:tags]
    # puts params[:promotion]
    user = User.find(session[:userId])
    tags = params[:tags]
    if tags.nil?
      puts "tags null"
      tags = []
    end
    result = Post.publish(params[:id], tags, params[:promotion], user)
    if result
      puts "ok"
    end

  end

  get :new do
    @tags = Tag.order_by(:created_at => 'desc')
    
    if session[:userId].nil?
      redirect_to url(:user_session, :new)
    else
      render 'new'
    end
  end



end
