class ApplicationController < Sinatra::Base
  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../../views', __FILE__)

  enable :sessions

  get '/' do
    @questions = Questions.all
    erb :index
  end

  get '/questions' do
  	@question = Questions.new()
    ff = 1
    @qd = Questions.count + 1
    until Questions.find_by(id: @qd) == nil
      ff += 1
      @qd = Questions.count + ff
    end
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
    @id = params[:id]
    if params[:cat] == "Ans"
      @qs = Ans.find(params[:id])
      @qs.destroy
      redirect "view?id=#{@id}"
    else
      @qs = Questions.find(params[:id])
      @qs.destroy
      redirect to('/')
    end
  end

  get '/answer' do
    @answer = Ans.new
    session['id'] = params[:id]
    @qs = Questions.find(params[:id])
    erb :answer
  end

  post '/answer' do
    session['id'] = params[:id]
    @url = "/answer?id=#{session['id']}"
    @url2 = "/view?id=#{session['id']}"
    @answer = Ans.new(params[:ans])
    if @answer.save
      redirect to(@url2)
    else
      redirect to(@url)
    end
  end

  get '/view' do
    session['id'] = params[:id]
    @id = params[:id]
    @qs = Questions.find(session['id'])
    erb :view
  end

  get '/edit' do
    @id = params[:id]
    @cat = params[:cat]
    session['id'] = @id
    session['cat'] = @cat
    @gg = Questions.find(@id)
    if @cat == "ans"
      @gb = Ans.find(@id)
    end
    erb :edit
  end

  post '/edit' do
    if session['cat'] == "question"
      @update_db = Questions.find(session['id'].to_i)
      @udb = @update_db.update(params[:question])
    else
      @update_db = Ans.find(session['id'].to_i)
      @udb = @update_db.update(params[:ans])
    end
    if @udb == true
      redirect "/view?id=#{session['id']}"
    else
      redirect "/edit?cat=#{session['cat']}&id=#{session['id']}"
    end
  end

  post '/search' do
    session['key'] = params[:q]
    redirect "/search?q=#{session['key']}"
  end

  get '/search' do
    session['key'] = params[:q]
    erb :search
  end

  get '/category' do
    erb :category
  end
end
