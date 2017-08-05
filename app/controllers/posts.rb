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

  get :promotions do
    @page = 1
    @tags = Tag.order_by(:created_at => 'desc')
    @versions = Version.where(promotion: true).order_by(:updated_at => 'desc').limit(8)
    @order = "promotions"
    render 'cards'

  end
  get :promotions, :with => :page do
    @page = params[:page].to_i
    @tags = Tag.order_by(:created_at => 'desc')
    @versions = Version.where(promotion: true).order_by(:updated_at => 'desc').limit(8).skip(8*(params[:page].to_i-1))
    @order = "promotions"
    render 'cards'

  end
  get :last_update do
    @page = 1
    @tags = Tag.order_by(:created_at => 'desc')
    @versions = Version.order_by(:updated_at => 'desc').limit(8)
    @order = "last_update"
    render 'cards'

  end
  get :last_update, :with => :page do
    @page = params[:page].to_i
    @tags = Tag.order_by(:created_at => 'desc')
    @versions = Version.order_by(:updated_at => 'desc').limit(8).skip(8*(params[:page].to_i-1))
    @order = "last_update"
    render 'cards'

  end
  get :last_create do
    @page = 1
    @tags = Tag.order_by(:created_at => 'desc')
    @versions = Version.order_by(:created_at => 'desc').limit(8)
    @order = "last_create"
    render 'cards'

  end
  get :last_create, :with => :page do
    @page = params[:page].to_i
    @tags = Tag.order_by(:created_at => 'desc')
    @versions = Version.order_by(:created_at => 'desc').limit(8).skip(8*(params[:page].to_i-1))
    @order = "last_create"
    render 'cards'

  end

  get :tag, :with => :name do
    @tags =  Tag.order_by(:created_at => 'desc')
    @tag = Tag.where(name: params[:name]).first

    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end
    @posts = @tag.posts.limit(8).skip(8*(@page-1))
    if @posts.nil?
      @posts = []
    end
    @order = "tag"


    render "index"
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
