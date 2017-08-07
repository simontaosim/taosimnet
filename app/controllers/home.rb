Taosimnet::App.controllers :home do
  layout :app

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
    @tags = Tag.order_by(:created_at => 'desc')
    @page = 1
    if params[:page]
      @page = params[:page].to_i
    end
    @versions= Version.order_by(:updated_at => 'desc').order_by(:updated_at => 'desc').limit(8).skip(8*(@page-1))
    render 'index'
  end

end
