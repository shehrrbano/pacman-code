# 🎮 Assembly Pacman Game Pro
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Assembly](https://img.shields.io/badge/Assembly-x86-blue.svg)](https://docs.microsoft.com/en-us/cpp/assembler/masm/microsoft-macro-assembler-reference)
[![Visual Studio](https://img.shields.io/badge/Visual_Studio-2022-purple.svg)](https://visualstudio.microsoft.com/)

## 📖 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Setup Requirements](#setup-requirements)
- [Installation Guide](#installation-guide)
- [Game Controls](#game-controls)
- [Technical Details](#technical-details)
- [Screenshots](#screenshots)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Acknowledgements](#acknowledgements)
- [Contact](#contact)

## 🌟 Overview
**Assembly Pacman** is an advanced implementation of the classic arcade game Pacman, built using **x86 Assembly**. The game features **multiple maze levels**, **intelligent ghost AI**, **dynamic scoring**, and **audio effects**. It is designed to provide both a nostalgic and challenging experience for players. This project demonstrates advanced assembly programming techniques while delivering an engaging gaming experience.

## ✨ Features

### 🎯 Core Gameplay Features
- **Multi-Level Design**:
  - 3 unique maze layouts with increasing difficulty.
  - Each level has its own set of challenges.
- **Dynamic Scoring System**:
  - Points are collected by eating dots, with bonus rewards for special items.
  - High score tracking for competitive play.
- **Advanced Ghost AI**:
  - Multiple ghosts with unique behaviors and movement patterns.
  - Increasing difficulty as the game progresses.

### 🎵 Audio System
- **Background Music**:
  - Level-specific themes to enhance the immersive experience.
  - Music for menus and level transitions.
- **Sound Effects**:
  - Sounds for dot collection, ghost encounters, and game over scenarios.

### 🎨 User Interface
- **Welcome Screen** with game title and options.
- **Main Menu** for game navigation.
- **Pause Menu** for in-game options.
- **Score Display** showing current score and lives remaining.
- **Lives Counter** to track player’s remaining lives.

## 🛠️ Setup Requirements

### Essential Software
- **MASM (Microsoft Macro Assembler)**: For assembling the game code.
- **Visual Studio 2022**: For creating and managing the project.
- **Irvine32 Library**: Provides convenient functions for assembly programs.
- **DOSBox** (Optional for testing): A DOS emulator if needed for compatibility.

### Required Files
- `masm32/bin/*`
- `Irvine32.inc`
- `Irvine32.lib`
- `kernel32.lib`
- `user32.lib`


## 📥 Installation Guide

### 1. Setting Up the Environment

#### Installing Visual Studio
```bash
1. Download Visual Studio 2022 from the official site.
2. During installation, select:
   - Desktop development with C++
   - Windows 10/11 SDK
```

#### Installing MASM
```bash
1. Download the MASM32 SDK from [MASM32 Website](http://www.masm32.com/).
2. Run the installer and follow the instructions.
3. Set up the environment variables:
   - Add the MASM directory to the system PATH.
   - Set the `ML` environment variable to point to the MASM executable.
```

### 2. Project Setup

#### Method 1: Using Visual Studio
```bash
1. Open **Visual Studio 2022**.
2. Create a new **Assembly Project**:
   - Go to **File -> New -> Project -> Assembly Project**.
3. Configure the project settings:
   - Right-click the project and select **Properties**.
   - Set the **Platform** to **x86**.
   - Set the **Configuration Type** to **.exe** (Executable).
   - Add the **Irvine32 library path** under **Additional Library Directories**.
```

#### Method 2: Using Command Line
```bash
# Compile the assembly file
ml /c /coff /Zi pacman.asm

# Link the object file with necessary libraries
link /subsystem:console /debug pacman.obj Irvine32.lib kernel32.lib user32.lib /ENTRY:main
```

### 3. Running the Game
```bash
# Navigate to the project directory
cd path/to/project

# Run the compiled executable
pacman.exe
```
3. Running the Game
```bash
# Navigate to the project directory
cd path/to/project

# Run the compiled executable
pacman.exe
```

🎮 Game Controls
Main Controls
Key	Action
W	Move Up
S	Move Down
A	Move Left
D	Move Right
P	Pause Game
X	Exit Game

Menu Navigation
1-5 -> Menu Selection
Enter ->	Confirm Selection
Esc	-> Back/Exit

🔧 Technical Details
Core Components
```bash
.386            ; Processor directive
.model flat     ; Memory model
.stack 4096     ; Stack size

includelib winmm.lib     ; Windows multimedia library
include Irvine32.inc     ; Irvine32 library for I/O functions
```

Memory Structure
```bash
.data
    ; Game state variables
    score       DWORD 0
    lives       BYTE 3
    level       BYTE 1
    
    ; Screen buffer to store the game display
    screenBuffer BYTE 120 DUP(?)
```

🎥 Screenshots
Welcome Screen


Gameplay


Level Selection


❗ Troubleshooting
Common Issues
1. Compilation Errors
```bash
Error: Cannot find Irvine32.lib
Solution: Verify that the Irvine32 library path is correctly configured in project settings.
```

2. Runtime Errors
```bash
Error: Sound not playing
Solution: Ensure that `winmm.lib` is properly linked in the project settings.
```

3. Display Issues
```bash
Error: Screen flickering
Solution: Enable double buffering in display settings to reduce flickering.
```

📝 License
MIT License

🙏 Acknowledgements
Pacman original game concept by Namco.
The Assembly Language Community for continued learning and development.
Irvine32 Library for providing essential tools for assembly programming.
📧 Contact
Shehr Bano - sshehrrbano@gmail.com
Anila Younas - anilayounas41@gmail.com

