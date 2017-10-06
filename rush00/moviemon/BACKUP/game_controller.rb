#require '../models/game_sessions.rb'



class GameController < ApplicationController
  $view ||= 'title_screen'

  $player ||= {
    slot: 1, 
    position: [0, 0], 
    life: 20, 
    strength: 5, 
    moviedex: [],
    index: 0
  }

  def title_screen

  end

  def shutdown
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
    if $view == 'shutdown'
      $view = 'title_screen'
      redirect_to :"#{$view}"
    else
      $view = 'shutdown'
      $player = {
        slot: 1,
        position: [0, 0], 
        life: 20, 
        strength: 5, 
        moviedex: [],
        index: 0,
        movies: []
      }
      redirect_to :"#{$view}"
    end
  end
end
