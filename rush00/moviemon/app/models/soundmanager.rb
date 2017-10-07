##require 'audio-playback'

class Soundmanager
	@@instance = Soundmanager.new
	def self.instance
		@@instance
	end
	private_class_method :new

	@@initialized = false
	def initialize
		## this currently isnt working. Please try to find a way to play sounds in ruby.
		## i could do it in python, but not Ruby.
		##	@@output = AudioPlayback::Device::Output.gets
		#@@output = AudioPlayback::Device::Output.gets
		#	puts @@output.to_s
		#	options = {
		#		:channels => [0,1],
		#		:latency => 1,
		#		:output_device => @@output,
		#		:is_looping => true
		#	}
		#	sound = AudioPlayback::Sound.load('app/assets/images/main_theme.ogg', options)
		#	@@sound_1 = AudioPlayback::Playback.new(sound, @@output, is_looping: true)
		#	sound = AudioPlayback::Sound.load('app/assets/images/goodbye_moon_men.ogg', options)
		#	@@sound_2 = AudioPlayback::Playback.new(sound, @@output, is_looping: true)
		@@initialized = true
	end

	def play_sound_main
		if @@initialized == false
			initialize()

		end
		#@@sound_1.start
	end
	def play_song_world
		if @@initialized == false
			initialize()
		end
		##@@sound_2.start
	end
	def play_song_battle

	end


end