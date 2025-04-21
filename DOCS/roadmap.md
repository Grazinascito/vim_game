# Proposed Roadmap for vim_game (MVP Focused)

## Phase 1: Foundation & Basic Structure

1.  **Initial Project Setup:**
    *   Create the Flutter project.
    *   Enable Desktop support (macOS, Windows, Linux).
    *   Set up version control (Git).
2.  **Initial Folder Structure:**
    *   Define and create the basic folder structure (e.g., `lib/features`, `lib/core`, `lib/presentation/widgets`, `lib/domain/models`).
3.  **Theme & Main Layout:**
    *   Implement the basic dark theme (colors based on Catppuccin or similar).
    *   Create the main `Scaffold` with `AppBar` (static title for now) and placeholders for Score and Target Area.
4.  **Navigation Drawer (Structure Only):**
    *   Implement the `Drawer` widget with items for the modes ("Vim Navigation", "Essential Commands").
    *   *At this stage, clicking items doesn't need to switch the mode yet, just close the Drawer.*

## Phase 2: Core Mechanics & First Mode (Navigation) - Using `setState`

5.  **Keyboard Input Capture:**
    *   Implement `RawKeyboardListener` to capture keyboard events globally within the window.
6.  **Basic State Management (`setState`):**
    *   Use `StatefulWidget` and `setState` for managing the game's state initially (current mode, score, target sequence).
    *   Implement basic logic to switch modes based on Drawer selection (updating the state).
7.  **Navigation Mode Logic:**
    *   Implement the logic to generate `h`, `j`, `k`, `l` targets when Navigation mode is active.
    *   Implement the logic to validate keyboard input for this mode.
8.  **Sequence Display & Progression:**
    *   Implement the logic to display the sequence of N targets based on the current state.
    *   Implement the logic to remove/shift/add targets in the sequence after a correct hit (updating state via `setState`).
9.  **Target Widget (Navigation Version):**
    *   Create a reusable widget for the target "card".
    *   Style the card for Navigation mode (key + optional icon).
    *   Implement the visual highlight for the current target.
10. **Basic Visual Feedback:**
    *   Implement the color/border change (green/red) on the current target card as correct/incorrect feedback.
11. **Basic Scoring System:**
    *   Implement the scoring logic (increment on hit, reset on miss, updating state via `setState`).
    *   Display the score in the UI based on the current state.

**(Checkpoint: At this point, we should have a functional game for the Navigation mode using `setState`!)**

## Phase 3: Second Mode (Essential Commands) & MVP Polish - Using `setState`

12. **Essential Commands Mode Logic:**
    *   Define the *final* list of essential Vim commands for the MVP (based on PRD Section 4.4).
    *   Implement the logic to generate targets with the defined commands when Essential Commands mode is active.
    *   Implement the input validation logic for this mode, including handling **multi-key** commands and **simplified Ex commands** (as per PRD Section 7), updating state via `setState`.
13. **Target Widget (Adaptation):**
    *   Adjust the target widget to correctly display the Vim command text (without icons) when in Essential Commands mode.
14. **Polishing:**
    *   Refine feedback and sequence progression animations.
    *   Adjust visual styling (colors, fonts, spacing) for better clarity and aesthetics.

**(Checkpoint: MVP Complete! The game works with the two main modes using `setState`, ready for personal use.)**

## Phase 4: Post-MVP / Future Enhancements

15. **Refactor State Management:**
    *   Refactor the state management from `setState` to **Cubit** for better structure and scalability. *(This is a key learning step)*.
16. **Implement Advanced Navigation:**
    *   Introduce a **Navigation Library** (e.g., GoRouter, AutoRoute, or the one used at work).
    *   Implement navigation between the main game screen and new screens.
17. **Add New Screens/Features:**
    *   Implement **Settings Screen** (e.g., for sound options, theme selection).
    *   Implement **Login/Cadastro Screens** (if needed for sharing/online features).
18. **Address Open Questions / Future Considerations from PRD:**
    *   Implement High Score persistence.
    *   Explore alternative scoring logic.
    *   Add optional sound feedback.
    *   Etc.
19. **Implement New Game Modes:**
    *   Add more advanced modes (as per PRD Section 4.5).
20. **Improve Distribution/Installation.**

---
