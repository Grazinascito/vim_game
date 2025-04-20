# Proposed Roadmap for vim_game (MVP Focused)

## Phase 1: Foundation & Basic Structure

1.  **Initial Project Setup:**
    *   Create the Flutter project.
    *   Enable Desktop support (macOS, Windows, Linux).
    *   Set up version control (Git).
2.  **Initial Folder Structure:**
    *   Define and create the basic folder structure (e.g., `lib/features`, `lib/core`, `lib/presentation/widgets`, `lib/domain/models`). *(We can create a simple ADR for this if we want to formalize it, or just follow a convention).*
3.  **Theme & Main Layout:**
    *   Implement the basic dark theme (colors based on Catppuccin or similar).
    *   Create the main `Scaffold` with `AppBar` (static title for now) and placeholders for Score and Target Area.
4.  **Navigation Drawer:**
    *   Implement the `Drawer` with items for the modes ("Vim Navigation", "Essential Commands").
    *   *At this stage, clicking items doesn't need to switch the mode yet, just close the Drawer.*

## Phase 2: Core Mechanics & First Mode (Navigation)

5.  **Keyboard Input Capture:**
    *   Implement `RawKeyboardListener` to capture keyboard events globally within the window.
6.  **Initial State Management & Mode Logic:**
    *   **ADR-001: Mode Logic Management:** Formalize the decision to use the **Strategy Pattern** (as discussed).
    *   Implement the `GameModeStrategy` interface and the basic structure in the main game widget to use the strategy.
7.  **Navigation Mode Implementation (`NavigationModeStrategy`):**
    *   Create the `NavigationModeStrategy` class.
    *   Implement the logic to generate `h`, `j`, `k`, `l` targets.
    *   Implement the logic to validate keyboard input for this mode.
8.  **Sequence Display & Progression:**
    *   Implement the logic to display the sequence of N targets (using data from the current strategy).
    *   Implement the logic to remove/shift/add targets in the sequence after a correct hit.
9.  **Target Widget (Navigation Version):**
    *   Create a reusable widget for the target "card".
    *   Style the card for Navigation mode (key + optional icon).
    *   Implement the visual highlight for the current target.
10. **Basic Visual Feedback:**
    *   Implement the color/border change (green/red) on the current target card as correct/incorrect feedback.
11. **Basic Scoring System:**
    *   Implement the scoring logic (increment on hit, reset on miss).
    *   Display the score in the UI.
12. **Drawer Functionality:**
    *   Make the mode selection in the Drawer actually switch the active `currentGameModeStrategy` and reset the game state (score, sequence).

**(Checkpoint: At this point, we should have a functional game for the Navigation mode!)**

## Phase 3: Second Mode (Essential Commands) & MVP Polish

13. **Essential Commands Mode Implementation (`EssentialCommandsModeStrategy`):**
    *   **Decision:** Define the *final* list of essential Vim commands for the MVP (based on PRD Section 4.4).
    *   Create the `EssentialCommandsModeStrategy` class.
    *   Implement the logic to generate targets with the defined commands (e.g., "dd", "i", ":w").
    *   Implement the input validation logic, including handling **multi-key** commands and **simplified Ex commands** (as per PRD Section 7).
14. **Target Widget (Adaptation):**
    *   Adjust the target widget to correctly display the Vim command text (without icons) when in Essential Commands mode.
15. **Polishing:**
    *   Refine feedback and sequence progression animations.
    *   Adjust visual styling (colors, fonts, spacing) for better clarity and aesthetics.

**(Checkpoint: MVP Complete! The game works with the two main modes.)**

## Phase 4: Post-MVP / Future

16. **Address Open Questions / Future Considerations from PRD:**
    *   Implement High Score (if decided).
    *   Explore alternative scoring logic.
    *   Add optional sound feedback.
    *   Etc.
17. **Implement New Modes:**
    *   Add more advanced modes (as per PRD Section 4.5).
18. **Add Settings/Customizations.**
19. **Improve Distribution/Installation.**

-
