
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
	@@param_control = 'control'
	@@button_a = 'buttonA'
	@@button_b = 'buttonB'
	@@button_up = 'up'
	@@button_down = 'down'
	@@button_left = 'left'
	@@button_right = 'right'
	@@button_start = 'start'
	@@button_select = 'select'

	def title_screen
		case params[@@param_control]
			when @@button_a

			when @@button_b
				redirect_to : '/'
		end
	end

	def shutdown
		puts params.to_s
	end

	def loading_game
	end

	def saving_game
	end

	def world_map
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

	def power
		Datamanager.instance.load
		if $view == 'shutdown'
			$view = 'title_screen'
			redirect_to :"#{$view}"
		else
			$view = 'shutdown'
			redirect_to :"#{$view}"
		end
	end

	def buttonA
		case $view
			when "saving_game"
				$view = "world_map"
				Datamanager.instance.save
				redirect_to world_map_path
			when "loading_game"
				$view = "world_map"
				Datamanager.instance.load
				redirect_to world_map_path
			when "coward", "victory", "lose"
				$view = "world_map"
				redirect_to world_map_path
			when "battle"
				redirect_to :"#{$view}"
			else
				redirect_to :"#{$view}"
		end
	end

	def buttonB
		if $view == "battle"

		end
		redirect_to :"#{$view}"
	end

	def select
		case $view
			when "title_screen"
				$view = 'loading_game'
				redirect_to :"#{$view}"
			when "moviedex"
				$view = "world_map"
				redirect_to :"#{$view}"
			when "world_map"
				$view = "saving_game"
				redirect_to :"#{$view}"
			when "saving_game"
				$view = "world_map"
				redirect_to :"#{$view}"
			when "loading_game"
				$view = "title_screen"
				redirect_to :"#{$view}"
			else
				redirect_to :"#{$view}"
		end
	end

	def start
		case $view
			when "title_screen" #launch new game
				redirect_to :"#{$view}"
			when "world_map"
				redirect_to :"#{$view}"
			else
				redirect_to :"#{$view}"
		end
	end

	def up
		case $view
			when "world_map"

				redirect_to :"#{$view}"
			when "loading_game", "saving_game"
				redirect_to :"#{$view}"
			else
				redirect_to :"#{$view}"
		end
	end

	def down
		case $view
			when "world_map"

				redirect_to :"#{$view}"
			when "loading_game", "saving_game"
				$player[:slot] = $player[:slot] < 3 ? $player[:slot] + 1 : 1
				redirect_to :"#{$view}"
			else
				redirect_to :"#{$view}"
		end
	end

	def right
		case $view
			when "world_map"

				redirect_to :"#{$view}"
			when "moviedex"

				redirect_to :"#{$view}"
			else
				redirect_to :"#{$view}"
		end
	end

	def left
		case $view
			when "world_map"

				redirect_to :"#{$view}"
			when "moviedex"

			else
				redirect_to :"#{$view}"
		end

	end

end
