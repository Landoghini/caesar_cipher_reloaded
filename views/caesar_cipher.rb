require 'sinatra'
require	'sinatra/reloader' if development?
require 'erb'

def caesar_cipher(input,shift)
	output = ""
	input.each do |character|
		if character =~ /[A-Z]/
			cipher_char = az_wrap(character,shift,'A')
		elsif character =~ /[a-z]/
			cipher_char = az_wrap(character,shift,'a')
		elsif character =~ /\W/
			cipher_char = character
		end
		output << cipher_char
	end
	puts output
end

def az_wrap(character,shift,base)
	(((character.ord + shift) - base.ord) % 26 + base.ord).chr
end
			
					

get '/' do
	shift = params['shift_amount']
	input = params['message']
	answer = caesar_cipher(input,shift) 
	erb :index
end