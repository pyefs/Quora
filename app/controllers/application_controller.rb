class ApplicationController < Sinatra::Base
  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../../views', __FILE__)

  get '/' do
  	@questions = Questions.all
    erb :index
  end

  get '/questions' do
  	@question = Questions.new
  	erb :questions
  end

  post '/questions' do
  	@question = Questions.new(params[:question])
  	if @question.save
  		redirect to('/')
  	else
  		erb :questions
  	end
  end

  get '/delete' do
  	@qs = Questions.find(params[:id])
  	@qs.destroy
  	redirect to('/')
  end
end
