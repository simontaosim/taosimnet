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

  get :good do
    redirect_to url(:account, :name => "John", :id => 5)
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
    post = Post.where(title: params[:post][:post_title]).first
    if post.nil?
      post = Post.new
    end
    post.title = params[:post][:post_title]
    post.body = params[:post][:post_text]
    user = User.find(session[:userId])
    post.user = user
    post.save
    version = Version.where(basic_post: post.id).first
    if version.nil?
      version = Version.new
      version.basic_post = post
      version.name = post.title+"草稿"
      version.status = "draft"
      version.post = post
      version.save
    end
    result = {
      post_id: post.id.to_s,
      post_version: version.id.to_s
    }
    result.to_json


    # post.save!


    # version = Version.new
    # version.name =

  end

  get :tag_post, :map => '/tag_a_post/:post_id/version/:id' do
      @post = Post.find(params[:post_id])
      render "/posts/tag_post"
  end
  get :account, :map => '/the/accounts/:name/and/:id' do
     # url_for(:account, :name => "John", :id => 5) => "/the/accounts/John/and/5"
     # access params[:name] and params[:id]
   end

  post :create do

  end

  get  :show, :with => :id do
    render "/posts/show"
  end

  get :preview, :with => :id do
    @post = Post.find(params[:id])
    render "/posts/preview"
  end

end
