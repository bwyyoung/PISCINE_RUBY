
require_relative '../models/datamanager.rb'

class GameController < ApplicationController

	respond_to? :html
	$view ||= 'title_screen'

	$player ||= {
		slot: 1,
		life: 20,
		strength: 5,
		index: 0,
		movieballs: 100,
		Moviemons: {},
		My_Moviemons: [],
		MoviemonBattle: '',
		coord: [1.352083, 103.819836],
		mapx: 50,
		mapy: 50
	}
	@@MAP_MIN= 0
	@@MAP_MAX = 100
	@@gs_walking = 'walking'
	@@param_control = 'control'
	@@button_a = 'buttonA'
	@@button_b = 'buttonB'
	@@button_up = 'up'
	@@button_down = 'down'
	@@button_left = 'left'
	@@button_right = 'right'
	@@button_start = 'start'
	@@button_select = 'select'
	@@button_shutdown = 'power'
	@@server_started = false

	@@url_moviedex = 'moviedex'
	@@url_title_screen = 'title_screen'
	@@url_shutdown = 'shutdown'
	@@url_load = 'loading_game'
	@@url_save = 'saving_game'
	@@url_world_map = 'world_map'
	@@url_battle = 'battle'
	@@url_moviedex_detail = 'moviedex_detail'


	def title_screen
		unless @@server_started
			unless File.exist?('public/save.json')
				Datamanager.instance.reset_default_settings
			end
			@@server_started = true
		end
		puts 'calling title screen'
		puts params[@@param_control]
		case params[@@param_control]
			when @@button_shutdown
				puts 'calling shutdown from title screen'
				shutdown
			when @@button_start
				Datamanager.instance.set_default
				redirection @@url_world_map
			when @@button_select
				redirection  @@url_load
		end
	end

	def redirection(url)
		$view = url
		redirect_to :"#{$view}"
	end

	def shutdown
		Datamanager.instance.set_default
		redirection @@url_title_screen
	end

	def loading_game
	end

	def saving_game

	end

	def world_map
		puts 'calling world map'
		@game_state = @@gs_walking
		puts params[@@param_control]
		case params[@@param_control]
			when @@button_shutdown
				shutdown
			when @@button_a
			when @@button_b
			when @@button_left
				if $player[:mapx] > @@MAP_MIN
					$player[:mapx] -= 1
					$player[:coord][1] -= 0.0010
				end
			when @@button_right
				if $player[:mapx] < @@MAP_MAX
					$player[:mapx] += 1
					$player[:coord][1] += 0.0010
				end
			when @@button_down
				if $player[:mapy] > @@MAP_MIN
					$player[:mapy] -= 1
					$player[:coord][0] -= 0.0010
				end
			when @@button_up

				if $player[:mapy] < @@MAP_MAX
					$player[:mapy] += 1
					$player[:coord][0] += 0.0010
				end
			when @@button_select
				redirection @@url_save
			when @@button_start
				redirection @@url_moviedex
		end
	end

	def battle

	end

	def moviedex
		# puts "player moviex" + $player[:moviedex]
		@film = $player[:moviedex][$player[:index]] unless $player[:index].nil?
		# puts $player[:moviedex][ $player[:index] ]
	end

	def victory
	end

	def lose
	end

	def coward
	end




end
