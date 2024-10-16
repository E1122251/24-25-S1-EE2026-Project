# 24-25-S1-EE2026-Project

> Modules Structure
>
> - Top_Student
>
>   - menu
>
>   - game
>
>   - player
>     - player_hitbox
>     - player_pos
>       - player_move
>         - player_move_input
>         - player_speed
>    
>    - stage
>
>    - logic
>      - score_display
>      - is_collision
>        - collision_animation

> Inter-module communication variables
> - menu
>  
>   - inputs
>  
>   - outputs
>     - game_active
>        
>     - player_chassis_colour
>     - player_wheels_colour
>
> - game
>
>   - inputs
>     - game_active
>    
> - player
>
>   - inputs
>     - game_pause
>  
>     - player_chassis_colour
>     - player_wheels_colour
>  
>   - outputs
>     - is_player_hitbox
>
> - stage
>
>   - inputs
>     - game_pause
>
>   - outputs
>     - is_obstacle_hitbox
>
> - logic
>
>   - inputs
>     - is_player_hitbox
>     - is_obstacle_hitbox
>
>  - outputs
>    - game_pause

> Shared modules documentation
>
> - clock_variable_gen
>    - inputs
>      - clock_100mhz
>      - m
>        - ( (100 X 10 ** 6) / 2 X clock_desired ) - 1
>    - output
>      - clock_output
>
> - debounce
>   - inputs
>     - clock_100mhz
>     - signal
>   - outputs
>     - signal_debounced
>       - debounced for 50ms
>
> - vsync
>   - inputs
>     - clock_100mhz
>     - [6:0] pixel_x
>     - [5:0] pixel_y
>     - clock
>   - outputs
>     - clock_vsync
>   - Description
>     - Synchronises input clock with pixel_index such that clock is delayed untill pixel_index is equal to the last pixel
>     - Removes screen tearing for moving objects
>     - Only works up to 30Hz, at which point will cause stuttering
