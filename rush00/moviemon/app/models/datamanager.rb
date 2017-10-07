require 'uri'
require 'json'
require 'net/http'

class Hash
	def sample(n)``
		Hash[to_a.sample(n)]
	end
end



class Datamanager
	# the class variable @@instance holds
	# a reference to the singleton object.
	@@instance = Datamanager.new
	# the class #instance method returns the
	# single reference to the object instance.
	def self.instance
		@@instance
	end
	# The #new method is privatized, disallowing
	# the creation of additional instances of the
	# Datamanager class, and limiting instances
	# of the Datamanager class to the @@instance
	# variable provided by the #instance method.
	private_class_method :new

	def initialize
		self.set_default
	end
	
	@@movie_list =[
		'Aliens',
		'The_Rocky_Horror_Picture_Show',
		'Hellboy',
		'Manos-_The_Hands_of_Fate',
		'Freddy',
		'Avatar',
		'Horror',
		'Terror',
		'Saw',
		'Pride_and_Prejudice_and_Zombies'
	]
	@@slot = 0
	@@life = 20
	@@max_slots = 3
	def set_default
		@@mapx = 50
		@@mapy = 50
		@@coord           = [1.352083, 103.819836]
		@@movieballs      = 100
		@@Moviemons       = {}
		@@My_Moviemons    = []
		@@MoviemonBattle  = ''
		@@strength        = 0
		@@index 		  = 0
		@@slot = 0
		@@life = 20
		@@max_slots = 3

		if File.exist?('public/save.json')
			file = File.read('public/save.json')
			save_data = JSON.parse(file, :symbolize_names => true)
			puts 'resetting moviemons'
			puts save_data[:'0'][:Moviemons]
			@@Moviemons = save_data[:'0'][:Moviemons]
		end

		$player = {
			slot: @@slot,
			life: @@life,
			strength: @@strength,
			index: @@index,
			movieballs: @@movieballs,
			Moviemons: @@Moviemons,
			My_Moviemons: @@My_Moviemons,
			MoviemonBattle: '',
			coord: @@coord,
			mapx: @@mapy,
			mapy: @@mapx
		}
	end


	def get_max_slots()
		return @@max_slots
	end


	def move_coord(cls, x, y)
		@coord[0] = x
		@coord[1] = y
	end

	
	def modif_movieballs(cls, nb)
		@@movieballs = nb
	end

	
	def add_moviemons(cls, name)
		@@My_Moviemons.append(name)
	end

	
	def del_moviemons(cls, name)
		@@Moviemons.delete(name)
	end

	def get_random_movie()
		return $player[:Moviemons].sample(1).keys[0]
	end

	def reset_default_settings
		puts 'reset_default_settings'
		self.set_default
		@@movie_list.each{ |elem|
			r = Net::HTTP.get(URI('http://www.omdbapi.com/?t=' + elem + '&apikey=41f80ff7'))
			moviemon = JSON.parse(r)
			@@Moviemons[moviemon['Title'].gsub(' ', '_').gsub(':', '-')] = moviemon
		}
		$player =
			{
				slot: @@slot,
				life: @@life,
				strength: @@strength,
				index: @@index,
				movieballs: @@movieballs,
				Moviemons: @@Moviemons,
				My_Moviemons: @@My_Moviemons,
				MoviemonBattle: '',
				coord: @@coord,
				mapx: @@mapy,
				mapy: @@mapx
			}
		json_data = {}
		json_data['movie_list'] = @@movie_list
		File.open('public/save.json', 'w+') do |f|
			@@max_slots.times{|x|
				puts 'creating slots ' + x.to_s
				json_data[x] = $player.clone
				json_data[x][:slot] = x
			}
			f.write(JSON.pretty_generate(json_data))
		end
	end

	def load
		puts 'loading load  11111111'
		unless File.exist?('public/save.json')
			reset_default_settings
		end
		save_data = JSON.parse(File.read('public/save.json'), :symbolize_names => true)
		$player = save_data[$player[:slot].to_s.parameterize.underscore.to_sym]
		puts 'loading load ' + $player.to_s

	end

	def save
		unless File.exist?('public/save.json')
			reset_default_settings
		end
		array_data = JSON.parse(File.read('public/save.json'))
		File.open('public/save.json', 'w+') do |f|
			array_data[$player[:slot].to_s] = $player.clone
			f.write(JSON.pretty_generate(array_data))
		end
	end

	def get_movie(my_movie)
		return @@Moviemons[my_movie]
	end
end