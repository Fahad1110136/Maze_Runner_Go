# Maze Runner Go
🧩 Maze Runner Game — x86 Assembly (8086)

Maze Runner is a fully interactive maze-based game developed entirely in x86 Assembly Language for the 8086 architecture. The project demonstrates low-level game development concepts by directly interfacing with hardware using BIOS interrupts, manual memory management, and interrupt service routines—without relying on any high-level libraries or game engines.

This project was built to deeply understand:

Computer architecture

Real-time input handling

Memory-mapped I/O

Interrupt-driven programming

🚀 Implemented Features
🔐 User Authentication

Separate registration/login for teachers and students

Session-based authentication

Role-based access control

📖 Interactive Mushaf Viewer

Full Quran display with Arabic text

Personal annotations: Add colored notes to any verse

Verse annotations: Track insights and learning notes

Annotation management (create, read, update, delete)

Dedicated "My Annotations" page

💬 Real-Time Chat

Live communication between users

Instant message updates

Session-based user identification

🎮 Game Overview

Navigate through complex mazes using keyboard arrow keys

Avoid enemies and manage score strategically

Collect points and power-ups

Activate SupraMan Mode to temporarily walk through walls

Beat the maze before time runs out

Entire game rendered in text mode using video memory (0xB800)

⚙️ Technical Highlights
🖥 Low-Level Rendering (Video Memory)

Direct writing to text-mode video memory (0xB800)

Each screen element written as character + attribute word

Custom borders, maze walls, paths, UI panels, score, and timer

No graphics libraries used

🧱 Multi-Level Maze System

Five different 20×20 maze levels

Each level stored as a structured word array

Maze symbols:

# → Walls

→ Open path

S → Start

E → Exit

♥ → Points

☠ → Enemy

⚡ → SupraMan key

A custom maze renderer converts array data into visual output row by row.

⌨️ Input Handling (Keyboard Interrupt)

Implemented a custom Keyboard Interrupt Service Routine (INT 09h).

Captures raw scan codes for:

⬆ Up

⬇ Down

⬅ Left

➡ Right

Features:

Smooth real-time movement

Collision validation before every move

🧠 Collision Detection Logic

Each movement is validated before execution:

Walls block movement

Enemies reduce score

Hearts increase score

Power-ups activate special modes

Exit triggers game completion

⚡ SupraMan Mode (Special Feature)

SupraMan Mode is a time-limited power-up designed at the assembly level.

Features

Activated by collecting a special key

Allows player to walk through walls

Overrides normal collision rules

Visually indicated in the UI

Implementation

Controlled via:

supermanmode flag

supermantimer counter

Automatically deactivates after timer expiration.

Timing synchronized using system timer interrupt.

⏱ Timer System (INT 08h)

Uses hardware timer ticks (20 ticks = 1 second).

Tracks:

Game duration

SupraMan countdown

Game Over when time expires

Stops incrementing time after winning

All timing logic is interrupt-driven and precise.

🏆 Scoring System

+200 points for collecting hearts ❤️

−100 points when hitting enemies ☠

Score updates dynamically on screen

Manual integer-to-ASCII conversion for display

No library functions used for formatting

🎯 Game States
🥇 Win Condition

Reach the exit (E)

Displays congratulatory message

Stops timer and finalizes score

💀 Game Over

Triggered when time limit is exceeded

Displays "Out of Time" message

Program terminates cleanly
