# Maze Runner Go
## 🧩 Maze Runner Game — x86 Assembly Architecture

Maze Runner is a fully interactive maze-based game developed entirely in **x86 Assembly Language for the 8086 architecture**. The project demonstrates low-level game development concepts by directly interfacing with hardware using **BIOS interrupts, manual memory management, and interrupt service routines**—without relying on any high-level libraries or game engines.

This project was built to deeply understand:

- Computer architecture  
- Real-time input handling  
- Memory-mapped I/O  
- Interrupt-driven programming  

---

# 🎮 Game Overview

1. Navigate through complex mazes using **keyboard arrow keys**
2. Avoid enemies and manage score strategically
3. Collect **points and power-ups**
4. Activate **SupraMan Mode** to temporarily walk through walls for a few seconds
5. Beat the maze before the **time runs out**
6. The entire game is rendered in **text mode using direct access to video memory (0xB800)**

---

# ⚙️ Technical Highlights

## 🖥 Low-Level Rendering (Video Memory)

- Direct writing to **text-mode video memory (0xB800)**
- Each screen element is written as a **character + attribute word**
- Custom borders, maze walls, paths, UI panels, score, and timer
- **No graphics libraries used**

---

## 🧱 Multi-Level Maze System

- Five different **20×20 maze levels**
- Each level stored as a **structured word array**

Maze elements encoded symbolically:

- `#` → Walls  
- ` ` → Open path  
- `S` → Start  
- `E` → Exit  
- `♥` → Points  
- `☠` → Enemy  
- `⚡` → SupraMan key  

A **custom maze renderer** converts array data into visual output row by row.

---

# ⌨️ Input Handling (Keyboard Interrupt)

Implemented a custom **Keyboard Interrupt Service Routine (INT 09h)**.

Captures raw scan codes for:

- ⬆ Up  
- ⬇ Down  
- ⬅ Left  
- ➡ Right  

Features:

- Smooth real-time movement  
- All movement passes through collision validation logic  

---

# 🧠 Collision Detection Logic

Each movement is validated before execution:

1. Walls block movement
2. Enemies reduce score
3. Hearts increase score
4. Power-ups activate special modes
5. Exit triggers game completion

Collision logic ensures correct behavior even during power-up states.

---

# ⚡ SupraMan Mode (Special Feature)

SupraMan Mode is a **time-limited power-up** designed at the assembly level.

### Features

- Activated by collecting a **special key**
- Allows the player to **walk through walls**
- Overrides normal collision rules
- Visually indicated in the UI

### Implementation

Controlled via:

- `supermanmode` flag  
- `supermantimer` counter  

Automatically deactivates after timer expiration.

Timing is synchronized using the **system timer interrupt**.

---

# ⏱ Timer System (INT 08h)

Uses **hardware timer ticks (20 ticks = 1 second)**.

Tracks:

1. Game duration
2. SupraMan countdown
3. Triggers **Game Over** when time expires
4. Stops incrementing time after winning

All timing logic is **interrupt-driven and precise**.

---

# 🏆 Scoring System

- **+200 points** for collecting hearts ❤️  
- **−100 points** when hitting enemies ☠  
- Score is updated dynamically on screen  
- Manual **integer-to-ASCII conversion** for display  
- No library functions are used for number formatting  

---

# 🎯 Game States

## 🥇 Win Condition
- Reach the exit **(E)**
- Displays a congratulatory message
- Stops timer and finalizes score

## 💀 Game Over
- Triggered when the time limit is exceeded
- Displays an **“Out of Time”** message
- Ends program execution cleanly

