require 'active_support/all'
require_relative '../models/datamanager.rb'
require_relative '../models/soundmanager.rb'

class GameController < ApplicationController

	respond_to? :html
	$view ||= 'title_screen'

	$player ||= {
		'slot' => 1,
		'life' => 50,
		'strength' => 5,
		'index' => 0,
		'movieballs' => 100,
		'Moviemons' => {},
		'My_Moviemons' => [],
		'MoviemonBattle' => '',
		'coord' => [1.352083, 103.819836],
		'mapx' => 50,
		'mapy' => 50
	}

	@@MonsterHP = 0
	@@MonsterSTR = 0
	@@PlayerHP= 50
	@@Player_full_HP = 50
	@@Player_default_HP = 50
	@@PlayerSTR = 5
	@@MAP_MIN= 0
	@@MAP_MAX = 100
	@@gs_walking = 'walking'
	@@gs_ball = 'ball'
	@@gs_battle = 'battle'
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
	@@game_state = ''
	@@movietitle = ''
    @@battle_captured = false
	@@moviedex_index = 0
	@@save_index = 0

	helper_method :game_state, :movietitle, :gs_ball, :gs_battle,
				  :Dictionary_Movie, :Luck, :battle_commentary,
				  :Dictionary_MyMovies, :selected_movie, :max_slots,
				  :save_index, :HP_Monster, :HP_Player

	def HP_Monster
		@@MonsterHP
	end
	def HP_Player
		@@PlayerHP
	end

	def HP_Player_FULL
		@@Player_full_HP
	end

	def STR_Player
		@@PlayerSTR
	end

	def STR_Monster
		@@MonsterSTR = ($player['Moviemons'][@@movietitle]['imdbRating'].to_i)
		return @@MonsterSTR
	end

	def max_slots
		return Datamanager.instance.get_max_slots
	end

	def save_index
		@@save_index
	end

	def Dictionary_Movie
		$player['Moviemons'][@@movietitle]
	end

	def selected_movie
		if $player['My_Moviemons'].length > 0
			return $player['My_Moviemons'][@@moviedex_index]
		end
		return ''
	end

	def Dictionary_MyMovies
		if $player['My_Moviemons'].length > 0
			return $player['My_Moviemons']
			#return $player[:Moviemons][$player[:My_Moviemons][@@moviedex_index]]
		end
		return {}
	end

	def Luck
		@C = ($player['Moviemons'][@@movietitle]['imdbRating'].to_i * 10)

		#puts "Monster HP = " + @C.to_s

		#return 100
		return @C
	end


	def capture(num)
		if rand(100) < num
			return true
		end
		return false
	end


	def battle_commentary
		@@battle_commentary
	end

	def game_state
		@@game_state
	end

	def movietitle
		@@movietitle
	end

	def gs_ball
		@@gs_ball
	end

	def gs_battle
		@@gs_battle
	end

	def title_screen
		unless File.exist?('public/save.json')
			Datamanager.instance.reset_default_settings
		end
		unless @@server_started
			Soundmanager.instance.play_sound_main
			@@server_started = true
		end
		puts 'calling title screen'
		puts params[@@param_control]
		case params[@@param_control]
			when @@button_shutdown
				return shutdown
			when @@button_start
				Datamanager.instance.set_default
				Soundmanager.instance.play_song_world
				@@game_state = @@gs_walking
				@@movietitle = ''
				@@battle_commentary = ''
				return redirection @@url_world_map
			when @@button_select
				@@save_index = 0
				@@game_state = @@gs_walking
				@@movietitle = ''
				@@battle_commentary = ''
				return redirection  @@url_load
		end
	end

	def redirection(url)
		$view = url
		redirect_to :"#{$view}"
	end

	def shutdown
		@@game_state = @@gs_walking
		@@movietitle = ''
		@@battle_commentary = ''
		Datamanager.instance.set_default
		Soundmanager.instance.play_sound_main
		return redirection @@url_title_screen
	end


	def world_map
		puts 'calling world map'
		if @@game_state != @@gs_battle
			@@game_state = @@gs_walking
			@@movietitle = ''
		end
		moved = false
		case params[@@param_control]
			when @@button_shutdown
				return shutdown
			when @@button_a
				if @@game_state == @@gs_battle
					@@battle_captured = false
					@@MonsterHP = Luck()
					@@MonsterSTR = STR_Monster()
					@@battle_lost = false
					@@PlayerHP = @@Player_full_HP
					return redirection @@url_battle
				end
			when @@button_b
				if @@game_state == @@gs_battle
					@@game_state = @@gs_walking
					@@movietitle = ''
				end
			when @@button_left
				if $player['mapx'] > @@MAP_MIN && @@movietitle.length == 0
					$player['mapx'] -= 1
					$player['coord'][1] -= 0.0010
					moved = true
				end
			when @@button_right
				if $player['mapx'] < @@MAP_MAX && @@movietitle.length == 0
					$player['mapx'] += 1
					$player['coord'][1] += 0.0010
					moved = true
				end
			when @@button_down
				if $player['mapy'] > @@MAP_MIN && @@movietitle.length == 0
					$player['mapy'] -= 1
					$player['coord'][0] -= 0.0010
					moved = true
				end
			when @@button_up
				if $player['mapy'] < @@MAP_MAX && @@movietitle.length == 0
					$player['mapy'] += 1
					$player['coord'][0] += 0.0010
					moved = true
				end
			when @@button_select
				if @@movietitle.length == 0
					@@save_index = 0
					return redirection @@url_save
				end
			when @@button_start
				if @@movietitle.length == 0
					@@moviedex_index = 0
					return redirection @@url_moviedex
				end
		end
		if moved && @@movietitle.length == 0
			random_num = rand(100)
			if random_num > 60
				@@movietitle = Datamanager.instance.get_random_movie
				@@game_state = @@gs_battle
				puts 'BATTLE MODE'
			elsif random_num > 40
				@@game_state = @@gs_ball
				puts 'BALL MODE'
				$player['movieballs'] += 1
			end
		end
	end

	@@battle_lost = false

	def battle
		puts 'BATTLE ROUND !!!!  '  +  rand(100).to_s
		@@battle_commentary = ''
		case params[@@param_control]
			when @@button_shutdown
				 return shutdown
			when @@button_a
				if @@battle_captured && !@@battle_lost
					@@game_state = @@gs_walking
					@@movietitle = ''
					@@battle_commentary = ''
					return redirection @@url_world_map
				end
				if 	@@battle_lost == false
					@@MonsterHP -= @@PlayerSTR
					@@PlayerHP = @@PlayerHP - @@MonsterSTR
				end
				if @@PlayerHP >= 0 && !@@battle_lost
					$player['movieballs'] -= 1
					if @@MonsterHP <= 0
						@@Player_full_HP = @@Player_full_HP + 10
						@@PlayerHP = @@Player_full_HP
						@@PlayerSTR = @@PlayerSTR + 1
						@@game_state = @@gs_walking
						@@battle_captured = true
						$player['My_Moviemons'].push(@@movietitle)
						@@battle_commentary = @@movietitle.to_s + ' Captured !'
						#return redirection @@url_world_map
					end
				else
					@@game_state = @@gs_walking
					@@PlayerHP = @@Player_full_HP
					@@battle_commentary = 'You failed ! Press B to quit battle...'
					@@battle_lost = true
				#	return redirection @@url_world_map
				end

			when @@button_b
				@@PlayerHP = @@Player_full_HP
				@@game_state = @@gs_walking
				@@movietitle = ''
				@@battle_commentary = ''
				@@battle_lost = false
				return redirection @@url_world_map
		end
	end

	def moviedex
		case params[@@param_control]
			when @@button_shutdown
				return shutdown
			when @@button_a
				if $player['My_Moviemons'].length > 0
					redirection @@url_moviedex_detail
				end
			when @@button_left
				if @@moviedex_index > 0
					@@moviedex_index -= 1
				end
			when @@button_right
				if @@moviedex_index < $player['My_Moviemons'].length - 1
					@@moviedex_index += 1
				end
			when @@button_b
				return redirection @@url_world_map
			when @@button_select
				return redirection @@url_world_map
			when @@button_start
				return redirection @@url_world_map
		end
	end

	def moviedex_detail
		case params[@@param_control]
			when @@button_shutdown
				return shutdown
			when @@button_b
				redirection @@url_moviedex
		end

	end

	def loading_game
		case params[@@param_control]
			when @@button_shutdown
				return shutdown
			when @@button_down
				if @@save_index < max_slots - 1
					@@save_index += 1
				end
			when @@button_up
				if @@save_index > 0
					@@save_index -= 1
				end
			when @@button_a
				$player['slot'] = @@save_index
				Datamanager.instance.load
				@@save_index = 0
				puts 'LOAD DATA '  +  $player.to_s
				@@PlayerHP = @@Player_default_HP
				@@Player_full_HP = @@Player_default_HP
				$player['My_Moviemons'].each{|mon|
					@@PlayerHP += 10
					@@Player_full_HP += 10
				}

				return redirection @@url_world_map
			when @@button_select
				@@save_index = 0
				return redirection  @@url_title_screen
		end
	end

	def saving_game
		case params[@@param_control]
			when @@button_shutdown
				return shutdown
			when @@button_down
				if @@save_index < max_slots - 1
					@@save_index += 1
				end
			when @@button_up
				if @@save_index > 0
					@@save_index -= 1
				end
			when @@button_a
				$player['slot'] = @@save_index
				Datamanager.instance.save
				@@save_index = 0
				return redirection @@url_world_map
			when @@button_select
				@@save_index = 0
				return redirection  @@url_world_map
		end
	end


	def victory
	end

	def lose
	end

	def coward
	end




end
