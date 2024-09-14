---

### README.md

# THE SERPENTS'S OATH

This is a 2D RPG game built using the **Godot Engine** based Ancient India or Indian Mythology.

---

## Features

- **Player Movement**: Their are basic player movements (jump,run,crouch,slide,roll) and in future will add more features like climbing.
- **Enemy AI**: For Now their is only one enemy which can move randomly or chase player 
- **Combat System**:(Attack and Health Functionality Not Added Now)
---

## Scripts Overview

### Player Script (`player.gd`)

This script handles all the main character's actions, including movement and animations

**Core Functions:**

- **Movement**: Player movement is controlled by input actions, including walking, rolling, sliding, and jumping.
- **Crouch and Walk**: The player can crouch, which reduces the movement speed.

**Extra Features:**
- **Animation Updates**: Animations like rolling, crouching, walking, and idle are controlled by functions.
- **Rolling Mechanic**: This feature momentarily slows down the player and keeps them rolling until the task is finished.
- **Sliding Mechanism**: Our goal is to improve the smoothness of the slide.


---

### Enemy Script (`enemy.gd`)

The movement and interactions of the enemies are described in this script.Important variables:
- {speed}: The pace of enemy movement.
- {detection_range}: The range in which the player is detected by the adversary.

**Main Duties:**
- **Chasing the Player**: When the player is in the detection range, the opponent pursues them.
- **Random Movement**: The opponent moves at random when it cannot detect the player.
  
**Extra Features:**
- **Animation Management**: The animation is triggered by the enemy's movements (such as walking, attacking, etc.).

---

## How to Run the Game

1. Open the project in the Godot Engine.
2. Attach the `player.gd` script to the player character node and the `enemy.gd` script to the enemy character node.
3. Customize the variables in the scripts (e.g., `speed`, `jumpVelocity`) to adjust the gameplay.
4. Test the game by pressing the "Play" button in the Godot editor

---

## Controls

- **Move Left/Right**: `Arrow Keys` or `A/D`
- **Jump**: `Space`
- **Roll**: `R`
- **Crouch**: `C`
- **Slide**: `S`
- **Attack**: `F`

---
**More Features and Changes to come**
___
