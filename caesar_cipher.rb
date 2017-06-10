require 'sinatra'
require	'sinatra/reloader' if development?
require 'erb'
enable :sessions

def caesar_cipher(input,shift)
	output = ""
	input.scan(/./) do |character|
		if character =~ /[A-Z]/
			cipher_char = az_wrap(character,shift,'A')
		elsif character =~ /[a-z]/
			cipher_char = az_wrap(character,shift,'a')
		elsif character =~ /\W/
			cipher_char = character
		end
		output << cipher_char
	end
	return output
end

def az_wrap(character,shift,base)
	(((character.ord + shift) - base.ord) % 26 + base.ord).chr
end
	
post '/encrypt' do
	shift = params['shift_amount'].to_i
	input = params['message']
	answer = caesar_cipher(input,shift)
	erb :index, :locals => { :answer => answer }
end

get '/' do
	erb :index, locals: {answer: ''}
end