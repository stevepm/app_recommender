require 'sinatra/base'
require 'rack-flash'

class App < Sinatra::Application

  enable :sessions
  use Rack::Flash

  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end

  get '/' do
    session[:app_name] = '' unless session[:app_name]
    session[:app_url] = '' unless session[:app_url]
    erb :index, :locals => {:error_message => flash[:error_message], :app_name => session[:app_name], :app_url => session[:app_url]}
  end

  post '/create' do
    session[:app_name] = app_name = h(params[:app_name])
    session[:app_url] = app_url = h(params[:app_url])

    if !validate_app_name(app_name)
      redirect '/'
    elsif !validate_url(app_url)
      redirect '/'
    else
      if AppRepository.create?(app_name, app_url)
        redirect '/view_apps'
      else
        flash[:error_message] = 'App has already been submitted'
        redirect '/'
      end
    end

  end

  get '/view_apps' do
    db = DB[:apps]
    erb :view_apps, :locals => {:db => db}
  end

  def validate_url(url)
    if url =~ /^(https?:\/\/)?(\w+)\.([a-zA-Z]{2,6})(\/\w*)*\/?$/
      true
    elsif url.strip.empty?
      true
    else
      flash[:error_message] = 'Please enter a valid URL'
      false
    end
  end

  def validate_app_name(app_name)
    if app_name.strip.empty?
      flash[:error_message] = 'You must enter a name'
      false
    elsif app_name.length > 15
      flash[:error_message] = 'App name must be less than 15 characters'
      false
    else
      true
    end
  end

end