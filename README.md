# 24-25-S1-EE2026-Project

> Modules Structure

- Top_Student

  - menu

  - game

    - player
      - player_hitbox
      - player_pos
        - player_move
          - player_move_input
          - player_speed
    
    - stage

    - logic
      - score_display
      - is_collision
        - collision_animation

> Inter-module communication variables
> - menu
  
  - inputs
  
  - outputs
    - game_active
        
    - player_chassis_colour
    - player_wheels_colour

- game

  - inputs
    - game_active
    
- player

  - inputs
    - game_pause
  
    - player_chassis_colour
    - player_wheels_colour
  
  - outputs
    - is_player_hitbox

- stage

  - inputs
    - game_pause

  - outputs
    - is_obstacle_hitbox

- logic

  - inputs
    - is_player_hitbox
    - is_obstacle_hitbox

  - outputs
    - game_pause


