require 'sinatra'
require 'dotenv/load'
require 'openai'

get '/' do
  erb :index, locals: { text_response: nil }
end

post '/search' do
  # It sends to the API the request with the parameter
  # sent from the form through the prompt.
  response = client.completions(
    parameters: {
      model: 'text-davinci-003',
      prompt: params['search'],
      max_tokens: 50
    }
  )
  # It processes the response and selects the answer
  # from the JSON sent, in the "choices" key.
  text_response = response["choices"].map { |c| c["text"] }
  erb :index, locals: { text_response: text_response }
end

def client
  @client ||= OpenAI::Client.new(access_token: ENV['TOKEN_OPENAI'])
end
