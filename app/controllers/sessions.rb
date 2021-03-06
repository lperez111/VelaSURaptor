get '/login' do
  erb :login
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/login' do
  user = User.find_by_email(params[:email])
  auth_user = user.authenticate(params[:password]) if user

  if auth_user
    session[:user_id] = auth_user.id
    redirect '/'
  elsif user
    @error = "Wrong password"
    erb :login
  else
    @error = "User #{params[:email]} was not found"
    erb :login
  end

end

post '/signup' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  redirect '/'
end


get '/edit_profile' do
  erb :edit_profile
end

post '/edit_profile' do
  current_user.update_attributes(first_name: params[:first_name],
                          last_name: params[:last_name],
                          email: params[:email],
                          birthdate: params[:birthdate],
                          home_city: params[:home_city],
                          zipcode: params[:zipcode],
                          gravatar: params[:gravatar])
  redirect to('/')
end

