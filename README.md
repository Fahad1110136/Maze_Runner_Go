## Maze Runner Go
# Maze Runner Game — x86 Assembly (8086)

Maze Runner is a fully interactive maze-based game developed entirely in x86 Assembly Language for the 8086 architecture. The project demonstrates low-level game development concepts by directly interfacing with hardware using BIOS interrupts, manual memory management, and interrupt service routines—without relying on any high-level libraries or game engines.
This project was built to deeply understand computer architecture, real-time input handling, memory-mapped I/O, and interrupt-driven programming.

# Game Overview

1. Navigate through complex mazes using keyboard arrow keys
2. Avoid enemies and manage score strategically
3. Collect points and power-ups
4. Activate SupraMan Mode to temporarily walk through walls for few seconds
5. Beat the maze before the time runs out
6. The entire game is rendered in text mode using direct access to video memory (0xB800).

# Technical Highlights

1. Low-Level Rendering (Video Memory)

Direct writing to text-mode video memory (0xB800)
Each screen element is written as a character + attribute word
Custom borders, maze walls, paths, UI panels, score, and timer
No graphics libraries used

2. Multi-Level Maze System

Five different 20×20 maze levels
Each level stored as a structured word array
Maze elements encoded symbolically:
Hash → Walls
Space → Open path
S → Start
E → Exit
♥ → Points
☠ → Enemy
⚡ → SupraMan key
A custom maze renderer converts array data into visual output row by row.

# Input Handling (Keyboard Interrupt)

Implemented a custom Keyboard Interrupt Service Routine (INT 09h)
Captures raw scan codes for:
1. Up
2. Down
3. Left
4. Right
Enables smooth, real-time movement
All movement passes through collision validation logic

#Collision Detection Logic

Each movement is validated before execution:
1. Walls block movement
2. Enemies reduce score
3. Hearts increase score
4. Power-ups activate special modes
5. Exit triggers game completion
Collision logic ensures correct behavior even during power-up states.

# SupraMan Mode (Special Feature)

SupraMan Mode is a time-limited power-up designed at the assembly level.

1. Features:

Activated by collecting a special key
Allows the player to walk through walls
Overrides normal collision rules
Visually indicated in the UI

2. Implementation:

Controlled via:
supermanmode flag
supermantimer counter
Automatically deactivates after timer expiration
Timing is synchronized using the system timer interrupt.

# Timer System (INT 08h)

Uses hardware timer ticks (20 ticks = 1 second)
Tracks:
1. Game duration
2. SupraMan countdown
3. Triggers Game Over when time expires
4. Stops incrementing time after winning
5. All timing logic is interrupt-driven and precise.

# Scoring System

1. +200 points for collecting hearts
2. −100 points when hitting enemies
3. Score is updated dynamically on screen
4. Manual integer-to-ASCII conversion for display
5. No library functions are used for number formatting.

# Game States

1. Win Condition

Reach the exit (E)
Displays a congratulatory message
Stops timer and finalizes score

2. Game Over

Triggered when time limit is exceeded
Displays an “Out of Time” message
Ends program execution cleanly
