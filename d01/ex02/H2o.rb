#!/usr/bin/env ruby -w

def hash_2_output
		data =[
			['Caleb' , 24],
			['Calixte', 84],
			['Calliste', 65],
			['Calvin', 12],
			['Cameron', 54],
			['Camil', 32],
			['Camille', 5],
			['Can', 52],
			['Caner', 56],
			['Cantin', 4],
			['Carl', 1],
			['Carlito', 23],
			['Carlo', 19],
			['Carlos', 26],
			['Carter', 54],
			['Casey', 2]
			]
		data.inject(Hash.new{|name_hash, key|
		name_hash[key] = [] }) {
		| # declare name_hash as hashmap, where the value is always an array referenced by key
		new_hash, (key, value)| # first arg, the new hash we created, and second arg, is the sub array of each element in data
		new_hash[value] << key # create a new_hash map where value is key, and key is value. << is a method, where
		# new_hash[value] receives key, and "<<" meaning is determined by ruby's hashmap system.
		new_hash # return new hash as the variable for the next interation to be used on LHS
		}.
			each {
				|key, value| puts "#{key} : #{value.join(' ')}"
			}
end

if $PROGRAM_NAME == __FILE__
	hash_2_output
end