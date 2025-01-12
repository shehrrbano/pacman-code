include Irvine32.inc
includelib winmm.lib
.386
.model flat, stdcall
.stack 4096
buffer_size = 1000
ExitProcess PROTO, dwExitCode:DWORD
GetStdHandle PROTO, a1:DWORD 


PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

.data
SND_FILENAME DWORD 00020000h
SND_LOOP DWORD  00000008h
SND_ASYNC DWORD 00000001h
allahhafiz BYTE "Allah Hafiz!", 0
file4 BYTE "chime.wav" , 0
file BYTE "pacmanmusic.wav" , 0
file2 BYTE "music.wav",0
file3 BYTE "dies.wav",0
      ground BYTE   "------------------------------------------------------------------------------------------------------------------------",0
      ground1 BYTE  "|",0ah,0
      ground2 BYTE  "|",0
      player BYTE   0ah,0ah,"                          INPUT YOUR NAME : ",0ah,0
      input1 db     "                          ______________________________________________",0ah,
                    "                         |                                              |",0ah,0
      input2 db     "                         |______________________________________________|",0
      instscreen db "                         _           _                   _   _                    ",0ah,
                    "                        (_)         | |                 | | (_)                   ",0ah,
                    "                         _ _ __  ___| |_ _ __ _   _  ___| |_ _  ___  _ __  ___   ",0ah,0
      instscreen2 db"                        | | '_ \/ __| __| '__| | | |/ __| __| |/ _ \| '_ \/ __|  ",0ah,
                    "                        | | | | \__ \ |_| |  | |_| | (__| |_| | (_) | | | \__ \ ", 0ah,
                    "                        |_|_| |_|___/\__|_|   \__,_|\___|\__|_|\___/|_| |_|___/ ",0ah,0
     
      well db    "   _______    ______    ______   __       __   ______   __    __         ______    ______   __       __  ________ ",0ah,            
                 "  |       \  /      \  /      \ |  \     /  \ /      \ |  \  |  \       /      \  /      \ |  \     /  \|        \ ",0ah,           
                 "  | $$$$$$$\|  $$$$$$\|  $$$$$$\| $$\   /  $$|  $$$$$$\| $$\ | $$      |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$$ ",0ah, 0          
      well2  db  "  | $$_/ $$|  $$__| $$| $$   \$$| $$$\ /  $$$| $$__| $$| $$$\| $$      | $$ __\$$| $$__| $$| $$$\ /  $$$| $$_     ",0ah,           
                 "  | $$    $$| $$    $$| $$      | $$$$\  $$$$| $$    $$| $$$$\ $$      | $$|    \| $$    $$| $$$$\  $$$$| $$  \    ",0ah,           
                 "  | $$$$$$$ | $$$$$$$$| $$   __ | $$\$$ $$ $$| $$$$$$$$| $$\$$ $$      | $$ \$$$$| $$$$$$$$| $$\$$ $$ $$| $$$$$   ",0ah ,  0        
      well3 db   "  | $$      | $$  | $$| $$_/  \ | $$ \$$$| $$| $$  | $$| $$ \$$$$      | $$__| $$| $$  | $$| $$ \$$$| $$| $$____ ",0ah,            
                 "  | $$      | $$  | $$ \$$    $$| $$  \$ | $$| $$  | $$| $$  \$$$       \$$    $$| $$  | $$| $$  \$ | $$| $$     \ ",0ah,            
                 "   \$$       \$$   \$$  \$$$$$$  \$$      \$$ \$$   \$$ \$$   \$$        \$$$$$$  \$$   \$$ \$$      \$$ \$$$$$$$$  ",0ah,0

      well4 db   "                                             ________________________________",0ah
            db   "                                            |       L o a d i n g......      |",0ah
            db   "                                            |________________________________| ",0


      areen db   "                                    G A M E   B Y   A N I L A   Y O U N A S   &   S H E H R   B A N O   ",0ah,0
      menu3 db   "                                      1. START GAME ",0ah,0ah,"                                      2. LEVELS",0ah,0ah,"                                      3. Scores",0ah,0ah,"                                      4. Instructions",0ah,0ah,"                                      5. Exit",0ah,0ah,"                                      Enter your choice : ",0ah,0
      menu db    "                                   __  __ ______ _   _ _    _ ",0ah,
                 "                                  |  \/  |  ____| \ | | |  | | ",0ah,
                 "                                  | \  / | |__  |  \| | |  | |",0ah, 
                 "                                  | |\/| |  __| | . ` | |  | |",0ah,0  
      menu2 db   "                                  | |  | | |____| |\  | |__| | ",0ah, 
                 "                                  |_|  |_|______|_| \_|\____/  ",0ah,0 

      strScore BYTE "Your score is: ",0
      help1 db     "                                      > Press 'a' for left movement ",0ah,0ah,
                   "                                      > Press 'd' for right movement",0ah,0ah,0
      help22 db    "                                      > Press 'w' for upward movement",0ah,0ah,
                   "                                      > Press 's' for downward movement",0ah,0ah,0
      help2 db     "                                      > Press 'x' to end the game  ",0ah,0ah,
                   "                                      > Press 'p' to see the pause screen ",0
      lvl   db     "                                   _      ________      ________ _       _____ ",0ah, 
                   "                                  | |    |  ____\ \    / /  ____| |     / ____|",0ah,
                   "                                  | |    | |__   \ \  / /| |__  | |    | (___  ",0ah,0
      lvl2   db    "                                  | |    |  __|   \ \/ / |  __| | |     \___ \ ",0ah,
                   "                                  | |____| |____   \  /  | |____| |____ ____) |",0ah,
                   "                                  |______|______|   \/   |______|______|_____/ ",0ah,0

      leveldisp db "                                      > Press '1' for easy level",0ah,0ah,
                   "                                      > Press '2' for medium level",0ah,0ah,
                   "                                      > Press '3' for hard level",0

      scoore  db  "                                     ______________  ________  _____",0ah,
                  "                                    / ___/ ___/ __ \/ ___/ _ \/ ___/",0ah,
                  "                                   (__  ) /__/ /_/ / /  /  __(__  )",0ah, 
                  "                                  /____/\___/\____/_/   \___/____/ ",0

      naam   db   "                                  ____  ____ _____ ___  ___ ",0ah,
                  "                                 / __ \/ __ `/ __ `__ \/ _ \",0ah,
                  "                                / / / / /_/ / / / / / /  __/",0ah,
                  "                               /_/ /_/\__,_/_/ /_/ /_/\___/ ",0
       
       pause1 db  "            _____       _    _  _____ ______      _____  _____ _____  ______ ______ _   _ ",0ah
              db  "           |  __ \ /\  | |  | |/ ____|  ____|    / ____|/ ____|  __ \|  ____|  ____| \ | | ",0ah
              db  "           | |__) /  \ | |  | | (___ | |__ _____| (___ | |    | |__) | |__  | |__  |  \| | ",0ah
              db  "           |  ___/ /\ \| |  | |\___ \|  __|______\___ \| |    |  _  /|  __| |  __| | . ` | ",0ah
              db  "           | |  / ____ \ |__| |____) | |____     ____) | |____| | \ \| |____| |____| |\  | ",0ah
              db  "           |_| /_/    \_\____/|_____/|______|   |_____/ \_____|_|  \_\______|______|_| \_|",0ah,0

     pause2   db  "                               ____________________________________ ",0ah
              db  "                              |                                   | ",0ah
              db  "                              |           1. RESUME GAME          | ",0ah
              db  "                              |                                   | ",0ah
              db  "                              |           2. MENU                 | ",0ah
              db  "                              |                                   | ",0ah
              db  "                              |           3. EXIT                 | ",0ah
              db  "                              |                                   | ",0ah
              db  "                              |___________________________________|  ",0


      goodbye db  "                              _____  ____   ____  _____  ______     ________ ",0ah,
                  "                             / ____|/ __ \ / __ \|  __ \|  _ \ \   / /  ____| ",0ah,
                  "                            | |  __| |  | | |  | | |  | | |_) \ \_/ /| |__    ",0ah,0
      goodbye2 db "                            | | |_ | |  | | |  | | |  | |  _ < \   / |  __|  ",0ah, 
                  "                            | |__| | |__| | |__| | |__| | |_) | | |  | |____ ",0ah, 
                  "                             \_____|\____/ \____/|_____/|____/  |_|  |______|" ,0ah,0

     goodbye3  db "                                EXITING ....",0

     existhojao1 db "               ________  __    __  ______   ______  ________  ______  __    __   ______  ",0ah
                 db "              |        \|  \  |  \|      \ /      \|        \|      \|  \  |  \ /      \  ",0ah
                 db "              | $$$$$$$$| $$  | $$ \$$$$$$|  $$$$$$\\$$$$$$$$ \$$$$$$| $$\ | $$|  $$$$$$\  ",0ah,0
     existhojao2 db "              | $$__     \$$\/  $$  | $$  | $$___\$$  | $$     | $$  | $$$\| $$| $$ __\$$  ",0ah
                 db "              | $$  \     >$$  $$   | $$   \$$    \   | $$     | $$  | $$$$\ $$| $$|    \  ",0ah
                 db "              | $$$$$    /  $$$$\   | $$   _\$$$$$$\  | $$     | $$  | $$\$$ $$| $$ \$$$$  ",0ah,0
     existhojao3 db "              | $$_____ |  $$ \$$\ _| $$_ |  \__| $$  | $$    _| $$_ | $$ \$$$$| $$__| $$  ",0ah
                 db "              | $$     \| $$  | $$|   $$ \ \$$    $$  | $$   |   $$ \| $$  \$$$ \$$    $$  ",0ah
                 db "               \$$$$$$$$ \$$   \$$ \$$$$$$  \$$$$$$    \$$    \$$$$$$ \$$   \$$  \$$$$$$  ",0ah,0

     complete22 db "  .____                      .__                                .__          __             .___ ",0ah
                db "  |    |    _______  __ ____ |  |     ____  ____   _____ ______ |  |   _____/  |_  ____   __| _/ ",0ah
                db "  |    |  _/ __ \  \/ // __ \|  |   _/ ___\/  _ \ /     \\____ \|  | _/ __ \   __\/ __ \ / __ |  ",0ah
                db "  |    |__\  ___/\   /\  ___/|  |__ \  \__(  <_> )  Y Y  \  |_> >  |_\  ___/|  | \  ___// /_/ |  ",0ah
                db "  |_______ \___  >\_/  \___  >____/  \___  >____/|__|_|  /   __/|____/\___  >__|  \___  >____ |  ",0ah
                db "          \/   \/          \/            \/            \/|__|             \/          \/     \/  ",0
     MUBARAK   db  "        __     ______  _    _  __          ______  _   _  __     __  __     ____     __  __    ",0ah
               db  "        \ \   / / __ \| |  | | \ \        / / __ \| \ | | \ \   / //\\ \   / /\ \   / /  \ \   ",0ah
               db  "         \ \_/ / |  | | |  | |  \ \  /\  / / |  | |  \| |  \ \_/ //  \\ \_/ /  \ \_/ /  (_) |  ",0ah
               db  "          \   /| |  | | |  | |   \ \/  \/ /| |  | | . ` |   \   // /\ \\   /    \   /     | |  ",0ah
               db  "           | | | |__| | |__| |    \  /\  / | |__| | |\  |    | |/ ____ \| |      | |     _| |  ",0ah
               db  "           |_|  \____/ \____/      \/  \/   \____/|_| \_|    |_/_/    \_\_|      |_|    (_) |  ",0ah
               db  "                                                                                         /_/ ",0

 
    ;level1 
      m1    db       "------------------------------------------------------------------------------------------------------------------------",0ah
            db       "|. . . . . . . . .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  |",0ah  
            db       "|. . .  -------------------------------------------------------------------------------------------------------   . . .|",0ah 
            db       "|. . . . . . . . .  . GET 200 SCORES TO REACH NEXT LEVEL .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  ..|",0ah
            db       "|. .   ------------------------------------ .  .  .   . ___   .  .  .  ------------------------------------------- .  .|",0ah
            db       "|. .  |. . . .  .  .  . .  .  .  .  .  . .  .  .  .   . | |   .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  | .  .|",0ah     
            db       "|. .  |. . . . ____________________________ .  .  .   . | |   .  .  .  . _______________________________   .  .  | .  .|",0ah
            db       "|. .  |. . . .|  ________________________ | .  . |---------------|  .  .| ____________________________ |.  .  .  | .  .|",0ah 
            db       "|. .  |. . . .| |.  .  . .  .  .  .  .  | | .  .  .   . . .   .  .  .  .| |  .  .  .  .  .  .   .  . | |.  .  .  | .  .|",0ah 
            db       "|. .  |. . . .|_|.  .  | .  .  .  .| .  | | .  .  .   . . .   .  .  .  .| | .  .  . | .  .  .  . | . |_|.  .  .  | .  .|",0ah  
            db       "|. .  |. . . .   .  .  | .  .  .  .| .  | | .  .  __| . . . |___ .  .  .| | .  .  . | .  .  .  . | . .  .  .  .  | .  .|",0ah  
            db       "|. .  |. . . .   .  .  | .  .  .  .| .  | | .  . |.  .  .   .  .|.  .  .| | .  .  . | .  .  .  . | . .  .  .  .  | .  .|",0ah  
            db       "|. .  |. . . .   .  .  | .  .||.  .| .  | | .  . |.  .  .   .  .|.  .  .| | .  .  . | .  .||.  . | . .  .  .  .  | .  .|",0ah  
            db       "|. .  |_______   .  .  | .  .||.  .| .  | | .  . |.  .  .   .  .|.  .  .| | .  .  . | .  .||.  . | . .   ________| .  .|",0ah  
            db       "|. .  |______|   .  .  | .  .||.  .| .  | | .  . |.  bonus 10 . |.  .  .| | .  .  . | .  .||.  . | . .  .|_______| .  .|",0ah  
            db       "|. .  |. . . .   .  .  | .  .||.  .| .  | | .  .  -------------- .  .  .| | .  .  . | .  .||.  . | . .  .  .  .  | .  .|",0ah  
            db       "|. .  |. . . .   .  .  | .  .  .  .| .  | | .  .  .  .  .   .  .  . .  .| |bonus 10 | .  .  .  . | . .  .  .  .  | .  .|",0ah 
            db       "|. .  |. . . .   _  .  | .  .  .  .| .  | | .  .  .  .  .   .  .  . .  .| | .  .  . |            | .  ._ .   .  .| .  .|",0ah  
            db       "|. .  |. . . .  | | .   -----------  .  | | .  .  _______________   .  .| | .  .  .  -------------    | | .  .  .| .  .|",0ah  
            db       "|. .  |. . . .  | | .  . .  .  .  .  .  | | .  . |_______________|  .  .| | .  .  .  .  .  . .  .  .  | | .  .  .| .  .|",0ah  
            db       "|. .  |. . . .  | |_____________________| | .  .  .   . | |   .  .  .  .| |___________________________| | .  .  .| .  .|",0ah  
            db       "|. .  |. . . .  |_________________________| .  .  .   . | |   .  .  .   |_______________________________| .  .  .| .  .|",0ah  
            db       "|. .  |. . . .  .  .  . .  .  .  .  .  . .  .  .  .   . | |   .  .  .  .   .  .  .  .  .  .  .  .  .  .   .  .  .| .  .|",0ah  
            db       "|. .  |. . . .  .  .  . .  .  .  .  .  . .  .  .  .   . |_|.  .  .  .  .   .  .  .  .  .  .  .  .  .  .   .  .  .| .  .|",0ah  
            db       "|. .  --------------------------------------   .  .   .    .  .  .  .  . ----------------------------------------- .  .|",0ah  
            db       "|. . . . . . . . .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . .  .|",0ah 
            db       "------------------------------------------------------------------------------------------------------------------------",0
 
;level 2
        m2  db       "------------------------------------------------------------------------------------------------------------------------",0ah  
            db       "|. . . . . . . . .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . .  .|",0ah  
            db       "|. . . _ . .  ________________  .  .|_|  .  . __________________________ .  .  | |.  .  . _______________ .  .  _  .  .|",0ah 
            db       "|. . .| |. . |_____________  |  .  .|_|  .  . |________________________|  . .  | |.  .   |  _____________| .  .| |     |",0ah
            db       "|. . .| |. . . . .  .  .  .| |  .  .|_|  .  .  .  .  .  |_|.  . .  .  .  .  .  | |.  .  .| |  .  .  .  .  .  . | | .  .|",0ah
            db       "|. . .| |. . . . .  .  .  .| |  .  .|_|  .  .  _________|_|___________   .  .  | |.  .  .| |  .  .  .  .  .  . | | .  .|",0ah     
            db       "|. . .| |______  .  .  .  .|_|  .  .|_|  .  . | |400 score for next | |  .  .  |_|.  .  .|_|  .  .  .  .  _____| | .  .|",0ah
            db       "|. . .| |______| .  .  .  .  .  .  .  .  .  . | |___________________| |  .  .  .  .  .  .  .  .  .  .  . |_____| | .  .|",0ah 
            db       "|. . .| |. . . . .  .  .  .  .  .  .  .  .    |_______________________|  .  .  .  .  .  .  .  .  .  .  .  .  . | | .  .|",0ah 
            db       "|. . .| |. . . . .  .  .  .  .  .  . _   .  .  .  .  .     .  . .  .  .  .  .   _ .  .  .  .  .  .  .  .  .  . | | .  .|",0ah  
            db       "|. . .|_|. . . . .  .  .  .  .  .  .| |  .  .  . ______       ______  .  .  .  | |.  .  .  .  .  .  .  .  .  . |_| .  .|",0ah  
            db       "|. .   . . .   .  . .  .  .  .  .  .| |  .  .  .||bonus  .  .  . . || .  .  .  | |.  .  .  .  .  .  .  .  .  .  .  .  .|",0ah  
            db       "|. .   . . . .    .  . .  .  .  .  .| |  .  .  .|| 10    .  .  . . || .  .  .  | |            .  .  ____  .  ____  .  .|",0ah  
            db       "|. .   _______   .  ._______________| | .   .  .||_________________|| .  .  .  | |__________  .  .  |  .  .  .  |  .  .|",0ah  
            db       "|. .   | . . .   .  |_________________| .   .  .||_________________|| .  .  .  |____________| .  .  |  .  .  .  |  .  .|",0ah  
            db       "|. .   | . . .   .  .  . .  .  .  .  .  .   .  .  .  . . . .  .  . .  .  .  .  .  .  .  .  .  .  .  |___________|  .  .|",0ah  
            db       "|. .   |______   .  .  . .  .  .  .  .  .   .  .  .  . .  _   .  . .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .|",0ah 
            db       "|. .   . . . .   .  .  . .  .  .  .  .  .   _  .  .      | |     . .  .   _ .  .  .  .  .  .  .  .  .  .  .  .  .  .  .|",0ah  
            db       "|. .    ______________ . .  .  .  .  .  .  | | .  .  ____|_|____ . .  .  | |.  .  .  .  .  .  . ________________.  .  .|",0ah  
            db       "|. .   |____________  |. .  .  . _.  .  .  | | .  . |___________|. .  .  | |.  .  . _   .  .  .|  _____________|.  .  .|",0ah  
            db       "|. .   . . . .   .  | |.  .  .  |_|.  .  . | | .  .  .  .  .  .  . .  .  | |.  .  .|_|  .  .  .| |  .  .  .  .  .  .  .|",0ah  
            db       "|. .   _ . . .   .  | |.  .  .  |_|.  .  . | | .  .  __________  . .  .  | |.  .  .|_|  .  .  .| |  .  .  .  .  _  .  .|",0ah  
            db       "|. .  | |. . .   .  |_|.  .  ___|_|____  . | | .  . |__________| . .  .  | |.   ___|_|____ .  .|_|  .  .  .  . | | .  .|",0ah  
            db       "|. .  | |. . .   .     .  . |__________| . | | .  .  .  |_|.  .  . .  .  | |.  |__________|.  .  .  .  .  .  . | | .  .|",0ah  
            db       "|. .  | |_____________ .  .  .  .  .  .  . | |_____  .  |_|.  .   _______| |.  .  .  .  .  .  .   _____________| | .  .|",0ah  
            db       "|. . .|_______________|.  .  bonus 5  .  . |_______| .  |_|.  .  |_________| . .  .  .  .  .  .  |_______________| .  .|",0ah 
            db       "| . . . . . .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .       .|",0ah  
            db       "------------------------------------------------------------------------------------------------------------------------",0 

;level3
        m3  db       "--------------------------------------------------------|| .  ||--------------------------------------------------------",0ah  
            db       "|. . .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .     .     .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .   . . .|",0ah 
            db       "|. . . ____________________________________________        .     .   ______________________________________________    |",0ah
            db       "|. .  |__________________________________________  |  . . ._. .  .  |  ____________________________________________|   |",0ah
            db       "|. .   . . . . . . .  .  .  . .  .  .  .  . .  . | |  . . | | .  .  | |.  .  .  .  .  .  .  .  .  .  .  .  .  .   . . .|",0ah     
            db       "|. .  |.|. . _____________________ . . ||   .  . | |  . . | | .  .  | |   .  .  . ||     ____________________    | |  .|",0ah
            db       "|. .  |.|. . |__________________ |.  . ||______. |_|  . __|_|___ .  |_| .  .  ____||.  .| __________________|  . | |  .|",0ah 
            db       "|. .  |.|. . . . . .  .  .  . .| |.  . ||_____|       .|________|            |____||    | | .  .  .  .  .  .  .  | |  .|",0ah 
            db       "|. .  |.|. . . . .  ||.  .  . .|_|.  .  .   .  .  .   . . .   .  .  .  . . .  .  .  . . | | .  .  _. .  _________| |  .|",0ah  
            db       "|. .  | |. . . . .  ||. . . .  .  . ______________________   .  __________________  . . | | .  . | | . |___________|  .|",0ah  
            db       "---.  | |_____ . .  ||. . . .  .  .| _____________________|    |_________________ | . . |_| .  . | | .  .  . .  .  . ---",0ah  
            db       " . .   . . . .   .  ||. . . .  .  .| |live+ .  .  .  .  .  .  .  .  .  . .  .  . ||. .  .  .   . | |_______ . . . .  .  ",0ah 
            db       "___   ________   .  ||. .  . _   . | |____________________     __________________||.  .  _ .   . |_|_______|  . .  . ---",0ah
            db       "|.   .| _____| .  . ||. . . | |. . |______________________|   |__________________||.  . | |. . .  .  .  .  .  . .  .  .|",0ah    
            db       "|. .  | | . . .   . ||. . . | |. . | |  .   .  .  .  .  .  .  .  .  .  . . .  . .||.  . | |.  ._____________    . _   .|",0ah 
            db       "|. .  | |. . . . .  .  . . .| |. . | |____________________     __________________||.  . | |.  .|___________ |.  .| |  .|",0ah  
            db       "|. .  | |. . __________     | |. . |______________________|   |___________________|.  . | |. .  .  .  .  .| |.  .| |  .|",0ah  
            db       "|. .  | |. .|__________| .  | |.  .  .  .   .  .  .  .  .  .  .  .  .  .    .  .  .  .  | |. .  .  .  .  .|_|.  .| |  .|",0ah  
            db       "|. .  | |. . . . .  .  . . .| |.  ___________  . _   .  .  .  .     _  .  ________. .  .| |bonus 10+  . . .  .  .| |  .|",0ah  
            db       "|. .  | |. . .  ____________| |. | _________|  .| |  . ________  . | | . |______  | .  .| |________________  .  .| |  .|",0ah  
            db       "|. .  | |. . . |______________| .|_|  .  .  .  .| |  .|________| . | | .   .  . |_| .   |__________________| .  .| |  .|",0ah  
            db       "|. .  | | .  .   .  .  .  .  .  .  .  .  .  .  .| |  .  .| |  .  . | |  .  .  .  .  .  .  .  .  .  .  . . .  .  .| |  .|",0ah  
            db       "|. .  | |_______________________________________| |  .  .| |  .  . | |___________________________________________| |  .|",0ah  
            db       "|. . .|___________________________________________|   ___| |___ .  |_____________________________________________|_|  .|",0ah 
            db       "|. . . .  .  bonus 5   .  .  .  .  .  .  .  .  .  .  .|________| .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . .  .|",0ah  
            db       "|. . . .  .  .   .  .  .  .  .  .  .  .  .  .  .  .  .           .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . .  .|",0ah
            db       "|. . . .  .  .   .  .  .  .  .  .  .  .  .  .  .  .  .           .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . .  .|",0ah
            db       "--------------------------------------------------------||    ||--------------------------------------------------------",0 
       p1 byte "Player's Name:  ",0
       p2 byte "Your score is:  ",0
      fruitx byte 14
      fruity byte 60
      mazeWidth DWORD 10
      lvldisp db "Level 1",0
      lvl2disp db "Level 2",0
      lvl3disp db "Level 3",0
      livesshow db "Lives: ",0
      liveno    dd 3
      symbol db "O ",0
      mazeHeight DWORD 5
      dot db ".",0
      score dw 0
      temp byte ?
      levelno db 1
      xPos BYTE 10
      yPos BYTE 10
      xGos BYTE  1
      YGos BYTE  27
      ghostX  db 1
      ghostY  db 27
      xGos1 BYTE  1
      yGos1 Byte  3
      xGos2 BYTE 59
      yGos2 BYTE 10
      xGos3 BYTE 111
      yGos3 BYTE 12
      x1 BYTE 1
      y1 BYTE 3
      x2 BYTE 59
      y2 BYTE 10
      x3 BYTE 111
      y3 BYTE 12
      xCoinPos BYTE 32
      yCoinPos BYTE 3
      inputChar BYTE ?
      ;  playerName dd 30 DUP(?)
      choice db ?
      pname dd 100 dup(?)
      stringLength DWORD ?
      filename2 BYTE "scores.txt" , 0
      filename BYTE "output.txt",0
      filehandle DWORD ?
      filehandle2 DWORD ?
      fileinput dd 100 dup(?)
      fileoutput dd 120 dup(?)
      names DWORD ?
      byemsg db "Press any key to exit",0ah,0
.code
main PROC
    mov eax, SND_FILENAME  ;; pszSound is a file name
    or eax, SND_LOOP       ;; Play in a loop
    or eax, SND_ASYNC      ;; Play in the background
    invoke PlaySound, addr file, 0, eax
     call  WelcomeScreen
     call clrscr
     shuru:
         call clrscr
         call GameMenu
         call clrscr
         ;start the game 
         cmp eax, 1
         je agaychalo  

         ;show the levels screen
         cmp eax,2
         je level1

         ;show scores screen
         cmp eax, 3
         je scores
     
         ;show instruction screen
         cmp eax,4
         je instructions

         ;end the game
         cmp eax, 5
         je khatam

     level1:
         call levels
         cmp eax, 1
         je agaychalo    ;level1
         cmp eax, 2
         je agaybarho
         cmp eax,3
         je chupkaro

     scores:
         call displayscore
         call clrscr
         jmp shuru

     instructions:
         call displayinst
         call clrscr
         jmp shuru

     agaychalo:
    ;invoke PlaySound, addr file2, 0, eax

         call clrscr     
         call startGame 
         call drawGhost 
         mov levelno,1

         mov eax,green
         call settextcolor
         mov dl, 57
         mov dh, 14
         call gotoxy
         mov al, 'O'
         call writechar
         mov dl, 80
         mov dh, 17
         call gotoxy
         mov al, 'O'
         call writechar
         gameLoop1:

            cmp xpos, 57
            je yess1
             jmp noo1
            yess1:
            cmp ypos, 14
            jne noo1
            inc score
            inc score
            inc score 
            inc score
            inc score
            inc score
            inc score
            inc score 
            inc score
            inc score
            noo1:
            cmp xpos, 80
            je yess2
             jmp noo2
            yess2:
            cmp ypos, 17
            jne noo2
            inc score
            inc score
            inc score 
            inc score
            inc score
            inc score
            inc score
            inc score 
            inc score
            inc score
            noo2:
        mov eax,white (black * 16)
        call SetTextColor
        mov dl,0
        mov dh,0
        call Gotoxy
        ;scores on screen
        mov edx,OFFSET strScore
        call WriteString
        mov ax,score
        call Writedec
        ;level on screen
        mov dl, 50
        mov dh,0
        call Gotoxy
        mov edx,OFFSET lvldisp
        call WriteString
        ;lives on screen
        mov dl, 90
        mov dh,0
        call Gotoxy
        mov edx,OFFSET livesshow
        call WriteString

        mov eax, liveno
        call writedec
        
        cmp score, 200
        je khamoosh

        mov al, xPos
        cmp xGos, al
        je nextjao    ;compare if ghost ki x position is equal to player
        jmp jaaaariraho
        nextjao:
        mov bl,yPos   ;compare if ghost ki y position is equal to player
        cmp yGos, bl
        jne jaaaariraho
        cmp liveno,1
        jg jaojao
        jmp khatam   ;khatam kro game
        jaojao:
        dec liveno    ;decrement kro lives 
        mov xPos,10
        mov yPos,10
        jaaaariraho:


        mov al, xPos
        cmp xGos1, al
        je hi1    ;compare if ghost ki x position is equal to player
        jmp hi2
        hi1:
        mov bl,yPos   ;compare if ghost ki y position is equal to player
        cmp yGos1, bl
        jne hi2
        cmp liveno,1
        jg hi3
        jmp khatam   ;khatam kro game
        hi3:
        dec liveno    ;decrement kro lives
        mov xPos,10
        mov yPos,10
        hi2:
        ; Ghost movement
        cmp ghostX,117
        jg onGround
        call DrawGhost
        mov al, xGos
        mov ghostX,al
        mov eax, 60
        call delay
        call moveGhostL
        jmp next
        onGround:
        cmp xGos,2
        jl nextt
        call DrawGhost
        mov eax,60
        call delay
        call moveGhostR

        jmp next
        nextt:
         mov al, xGos
         mov ghostX,al
         jmp gameloop1
        next:
        ;/////////////////////
        ;khatam ghost1
        ; Ghost movement
        cmp x1,117
        jg okayy
        call DrawGhost2
        mov al, xGos1
        mov x1,al
        mov eax, 50
        call delay
        call moveGhostL2
        jmp ok6
        okayy:
        cmp xGos1,2
        jl ok5
        call DrawGhost2
        mov eax,50
        call delay
        call moveGhostR2

        jmp ok6
        ok5:
         mov al, xGos1
         mov x1,al
         jmp gameloop1
        ok6:

        call readkey
        mov inputChar,al
        cmp inputChar,"x"
        je khatam

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight
        
        cmp  inputChar, "p"
        je pausekaro

        jmp gameloop1
        moveDown:                 ;down movement 
        call UpdatePlayer
        call CheckDot
        call checkwallsD
        cmp al,0
        je dafaho4
        inc yPos
        dafaho4:
        call DrawPlayer
        call CheckDot
        jmp gameLoop1

        moveUp:                       ;up movement 

            call UpdatePlayer
            call CheckDot
            call checkwallsU
            cmp al, 0
            je dafaho3 
            dec yPos
            dafaho3:
            call DrawPlayer
            call CheckDot
        jmp gameLoop1

        moveLeft:               ;left movement

        call UpdatePlayer
        call CheckDot
        call checkwallsL
        cmp al, 0
        je dafaho 
        dec xPos
        dafaho:
        call DrawPlayer
        call CheckDot
        jmp gameLoop1

        moveRight:              ;right movement 
        call UpdatePlayer
        call CheckDot
        call CheckDot
        call checkwallsR
        cmp al,0
        je dafaho2
        inc xPos
        dafaho2:
        call DrawPlayer
        call CheckDot
        jmp gameLoop1

     pausekaro:
       mov edx,offset m1
       call clrscr
       call pausescreen
       cmp eax, 1
       je agaychalo
       cmp eax, 2
       je shuru
       cmp eax, 3
       je khatam
     jmp gameLoop1
     ;////////////////////////////////////////////////////////////
     ;////////////////////////////////////////////////////////////

     agaybarho:
         ;mov score,0
         mov xPos,10
         mov yPos, 10
         call clrscr
         call level2disp
         call CreateRandomCoin
         call DrawCoin
         call Randomize
         mov levelno,2
         mov yGos,3
         mov yGos1,28
         mov liveno, 3
         call drawGhost 
         mov eax,green
         call settextcolor
         mov dl, 60
         mov dh, 14
         call gotoxy
         mov al, 'O'
         call writechar
         gameLoop2:

            cmp xpos, 60
            je yess
             jmp noo
            yess:
            cmp ypos, 14
            jne noo
            inc score
            inc score
            inc score 
            inc score
            inc score
            inc score
            inc score
            inc score 
            inc score
            inc score
            noo:
            ; getting points:
            mov bl,xPos
            cmp bl,xCoinPos
            jne notCollecting
            mov bl,yPos
            cmp bl,yCoinPos
            jne notCollecting
            ; player is intersecting coin:
            inc score
            inc score
            inc score 
            inc score
            inc score
            call CreateRandomCoin
            call DrawCoin
            notCollecting:

            mov eax,white (black * 16)
            call SetTextColor

            ; draw score:
            mov dl,0
            mov dh,0
            call Gotoxy
            mov edx,OFFSET strScore
            call WriteString
            mov ax,score
            call writedec
      
            mov dl, 50
            mov dh,0
            call Gotoxy
            mov edx,OFFSET lvl2disp
            call WriteString
         
            mov dl, 90
            mov dh,0
            call Gotoxy
            mov edx,OFFSET livesshow
            call WriteString
  
            mov eax, liveno
            call writedec
        
        
            cmp score, 400
            je khamoosh2

            mov al, xPos
            cmp xGos, al
            je nextjao1
            jmp jaaaariraho1
            nextjao1:
            mov bl,yPos
            cmp yGos, bl
            jne jaaaariraho1
            cmp liveno,1
            jg jaojao1
            jmp khatam
            jaojao1:
            dec liveno
                mov xPos,10
                mov yPos,10
            jaaaariraho1:

            ;second ghost
            mov al, xPos
            cmp xGos1, al
            je hehe    ;compare if ghost ki x position is equal to player
            jmp he1
            hehe:
            mov bl,yPos   ;compare if ghost ki y position is equal to player
            cmp yGos1, bl
            jne he1
            cmp liveno,1
            jg hehehe
            jmp khatam   ;khatam kro game
            hehehe:
            dec liveno    ;decrement kro lives 
                mov xPos,10
                mov yPos,10
            he1:

            cmp ghostX,117
            jg onGround1
            call DrawGhost
            mov al, xGos
            mov ghostX,al
            mov eax, 60
            call delay
            call moveGhostL
            jmp next2
            onGround1:
            cmp xGos,2
            jl nextt1
            call DrawGhost
            mov eax, 60
            call delay
            call moveGhostR
            jmp next2
            nextt1:
             mov al, xGos
             mov ghostX,al

            next2:
            ;/////////////////////
            cmp x1,117
            jg khekhe
            call DrawGhost2
            mov al, xGos1
            mov x1,al
            mov eax, 50
            call delay
            call moveGhostL3
            jmp khe
            khekhe:
            cmp xGos1,2
            jl yep
            call DrawGhost2
            mov eax,50
            call delay
            call moveGhostR3
            jmp khe
            yep:
             mov al, xGos1
             mov x1,al
             jmp gameloop2
            khe:
            call readkey
            mov inputChar,al
            cmp inputChar,"x"
            je khatam

            cmp inputChar,"w"
            je moveUp2

            cmp inputChar,"s"
            je moveDown2

            cmp inputChar,"a"
            je moveLeft2

            cmp inputChar,"d"
            je moveRight2
        
            cmp  inputChar, "p"
            je pausekaro2
            jmp gameloop2
            moveUp2:                       ;up movement 

                call UpdatePlayer
                call checkwallsU2
                cmp al, 0
                je dafaho5
                dec yPos
                dafaho5:
                call DrawPlayer
                call CheckDot2
            jmp gameLoop2

            moveDown2:                 ;down movement 
            call UpdatePlayer
            call CheckDot2
            call checkwallsD2
            cmp al,0
            je dafaho6
            inc yPos
            dafaho6:
            call DrawPlayer
            call CheckDot2
            jmp gameLoop2

            moveLeft2:               ;left movement

            call UpdatePlayer
            call CheckDot2
            call checkwallsL2
            cmp al, 0
            je dafaho7 
            dec xPos
            dafaho7:
            call DrawPlayer
            call CheckDot2
            jmp gameLoop2

            moveRight2:              ;right movement 
            call UpdatePlayer
            call CheckDot2
            call CheckDot2
            call checkwallsR2
            cmp al,0
            je dafaho8
            inc xPos
            dafaho8:
            call DrawPlayer
            call CheckDot2
            jmp gameLoop2


       pausekaro2:
       mov edx,offset m1
       call clrscr
       call pausescreen
       cmp eax, 1
       je agaybarho
       cmp eax, 2
       je shuru
       cmp eax, 3
       je khatam
       jmp gameLoop2

      ;//////////////////////////////////////////////////////
      ;/////////////////////////////////////////////////////
      chupkaro:
   ; invoke PlaySound, addr file2, 0, eax
         ;mov score,0
         mov xPos,10
         mov yPos, 10
         mov liveno,3
         call clrscr
         call level3disp
         call CreateRandomCoin
         call DrawCoin
        ; call drawghost
         call Randomize
         mov levelno,3
         mov yGos,27
         mov eax,green
         call settextcolor
         mov dl, 50
         mov dh, 13
         call gotoxy
         mov al, 'L'
         call writechar
         mov eax,cyan
         call settextcolor
         mov dl, 30
         mov dh, 13
         call gotoxy
         mov al, 'b'
         call writechar
         mov dl, 100
         mov dh, 18
         call gotoxy
         mov al, 'b'
         call writechar
      gameLoop3:
           ;bonus
            cmp xpos, 50
            je yess3
             jmp noo3
            yess3:
            cmp ypos, 13
            jne noo3
            inc liveno
            noo3:
            cmp xpos, 30
            je yess4
             jmp noo4
            yess4:
            cmp ypos, 13
            jne noo4
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            noo4:
            cmp xpos, 100
            je yess5
            jmp noo5
            yess5:
            cmp ypos, 18
            jne noo5
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            inc score
            noo5:
       ;-------horizontal teleport
             cmp yPos, 13
             je teleport
             jmp matkro
      teleport:
              cmp xPos,0
              je telekro
              cmp xPos,119
              je telekro2
               jmp matkro
      telekro:
              mov xPos,119
              mov dl, 0
              mov dh, 13
              call gotoxy
              mov al,' '
              call writechar
              jmp matkro
      telekro2:
              mov xPos, 0
              mov dl,119
              mov dh, 13
              call gotoxy
              mov al,' '
              call writechar
      ;-----vertical teleport
      matkro:
             cmp xPos, 59
             je teleport2
             jmp matkro2
      teleport2:
              cmp yPos,2
              je telekro3
              cmp yPos,29
              je telekro4
              jmp matkro2
      telekro3:
              mov yPos,29
              mov dl, 59
              mov dh, 2
              call gotoxy
              mov al,' '
              call writechar
              jmp matkro2
      telekro4:
              mov yPos, 2
              mov dl, 59
               mov dh, 29
               call gotoxy
               mov al,' '
               call writechar
      matkro2:
             ; getting points:
             mov bl,xPos
             cmp bl,xCoinPos
             jne notCollecting3
             mov bl,yPos
             cmp bl,yCoinPos
             jne notCollecting3
             ; player is intersecting coin:
             inc score
             inc score
             inc score 
             inc score
             inc score
                call CreateRandomCoin
                call DrawCoin
                notCollecting3:
                mov eax,white 
                call SetTextColor

                ; draw score:
                mov dl,0
                mov dh,0
                call Gotoxy
                mov edx,OFFSET strScore
                call WriteString
                mov ax,score
                call writedec
      
                mov dl, 50
                mov dh,0
                call Gotoxy
                mov edx,OFFSET lvl3disp
                call WriteString
         
                mov dl, 90
                mov dh,0
                call Gotoxy
                mov edx,OFFSET livesshow
                call WriteString

                mov eax, liveno
                call writedec
                    
                cmp score, 800
                je khamoosh3
                ;ghost 1 lives effect
                mov al, xPos
                cmp xGos, al
                je nextjao2
                jmp jaaaariraho2
                nextjao2:
                mov bl,yPos
                cmp yGos, bl
                jne jaaaariraho2
                cmp liveno,1
                jg jaojao2
                jmp khatam
                jaojao2:
                dec liveno
                mov xPos,10
                mov yPos,10
                jaaaariraho2:
                ;ghost 2 lives effect
                mov al, xPos
                cmp xGos1, al
                je hehe3    
                jmp he3
                hehe3:
                mov bl,yPos   
                cmp yGos1, bl
                jne he3
                cmp liveno,1
                jg hehehe3
                jmp khatam  
                hehehe3:
                dec liveno   
                mov xPos,10
                mov yPos,10
                he3:
                ;ghost 3 lives effect
                mov al, xPos
                cmp xGos2, al
                je hehe8    
                jmp he8
                hehe8:
                mov bl,yPos   
                cmp yGos2, bl
                jne he8
                cmp liveno,1
                jg hehehe8
                jmp khatam  
                hehehe8:
                dec liveno   
                mov xPos,10
                mov yPos,10
                he8:

                ;ghost 4 lives effect
                mov al, xPos
                cmp xGos3, al
                je hehe7    
                jmp he7
                hehe7:
                mov bl,yPos   
                cmp yGos3, bl
                jne he7
                cmp liveno,1
                jg hehehe7
                jmp khatam  
                hehehe7:
                dec liveno  
                mov xPos,10
                mov yPos,10
                he7:
                ;ghost movement 
                cmp ghostX,117
                jg onGround2
                call DrawGhost
                mov al, xGos
                mov ghostX,al
                mov eax, 30
                call delay
                call moveGhostL
                jmp next3
                onGround2:
                cmp xGos,2
                jl nextt2
                call DrawGhost
                mov eax, 30
                call delay
                call moveGhostR
                jmp next3
                nextt2:
                mov al, xGos
                mov ghostX,al
                jmp gameloop3
                next3:
        
                ;ghost 2
                mov yGos1,3
                cmp x1,117
                jg khekhe2
                call DrawGhost2
                mov al, xGos1
                mov x1,al
                mov eax, 30
                call delay
                call moveGhostL3
                jmp khe2
                khekhe2:
                cmp xGos1,2
                jl yep2
                call DrawGhost2
                mov eax,30
                call delay
                call moveGhostR3
                jmp khe2
                yep2:
                 mov al, xGos1
                 mov x1,al
                 jmp gameloop3
                khe2:
                ;--------ghost 3

                cmp y2,18
                jg khekhe9
                call DrawGhost3
                mov al, yGos2
                mov y2,al
                mov eax, 30
                call delay
                call MoveGhostD
                jmp khe9
                khekhe9:
                cmp yGos2,11
                jl yep9
                call DrawGhost3
                mov eax,30
                call delay
                call MoveGhostU
                jmp khe9
                yep9:
                 mov al, yGos2
                 mov y2,al
                 jmp gameloop3
                khe9:

                ;--------ghost 4

                cmp y2,18
                jg khekhe7
                call DrawGhost4
                mov al, yGos3
                mov y3,al
                mov eax, 30
                call delay
                call MoveGhostD2
                jmp khe7
                khekhe7:
                cmp yGos2,13
                jl yep7
                call DrawGhost4
                mov eax,30
                call delay
                call MoveGhostU2
                jmp khe7
                yep7:
                 mov al, yGos3
                 mov y3,al
                 jmp gameloop3
                khe7:
                call readkey
                mov inputChar,al

                cmp inputChar,"x"
                je khatam

                cmp inputChar,"w"
                je moveUp3

                cmp inputChar,"s"
                je moveDown3

                cmp inputChar,"a"
                je moveLeft3

                cmp inputChar,"d"
                je moveRight3
        
                cmp  inputChar, "p"
                je pausekaro3
                jmp gameloop3
         moveUp3:                       ;up movement 
                call UpdatePlayer
                call checkwallsU3
                cmp al, 0
                je dafaho9
                dec yPos
                dafaho9:
                call DrawPlayer
                call CheckDot3
                jmp gameLoop3

         moveDown3:                 ;down movement 
                call UpdatePlayer
                call CheckDot3
                call checkwallsD3
                cmp al,0
                je dafaho0
                inc yPos
                dafaho0:
                call DrawPlayer
                call CheckDot3
                jmp gameLoop3

        moveLeft3:               ;left movement

                call UpdatePlayer
                call CheckDot3
                call checkwallsL3
                cmp al, 0
                je dafaho1 
                dec xPos
                dafaho1:
                call DrawPlayer
                call CheckDot3
                jmp gameLoop3

        moveRight3:              ;right movement 
                call UpdatePlayer
                call CheckDot3
                call checkwallsR3
                cmp al,0
                je dafahoo
                inc xPos
                dafahoo:
                call DrawPlayer
                call CheckDot3
                jmp gameLoop3
       pausekaro3:
           mov edx,offset m3
           call clrscr
           call pausescreen
           cmp eax, 1
           je chupkaro
           cmp eax, 2
           je shuru
           cmp eax, 3
           je khatam
    jmp gameLoop3

        khamoosh:
             call clrscr
             call nextlevel
             jmp agaybarho
        khamoosh2:
             call clrscr
             call nextlevel
             jmp chupkaro
        khamoosh3:
             call clrscr
             call jeet
             jmp khatam
        exitGame:
        call clrscr
        exit
        khatam:
        call clrscr
        invoke PlaySound, addr file3, 0, eax
        call endgame
        ret

        invoke ExitProcess, 0

main ENDP


;////////////////////////////////////////////
;///////////////////////////////////////////
;///////////////////////////////////////////

WelcomeScreen PROC
    mov eax,blue;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground   ;floor line
    call WriteString

    call crlf
    call crlf
    call crlf
    call crlf

    mov eax, blue
    call SetTextColor
    mov edx, OFFSET well   ;welcome message
    call writestring
    
    mov eax , 60
    call delay

    mov eax, cyan
    call SetTextColor
    mov edx, OFFSET well2   ;welcome message
    call writestring
    
    mov eax , 50
    call delay

    mov eax, yellow
    call SetTextColor
    mov edx, OFFSET well3  ;welcome message
    call writestring
    mov eax, white
    call SetTextColor
    call crlf
    call crlf
    call crlf
    call crlf
    call crlf
    mov edx,OFFSET well4      ;loading box
    call WriteString

    mov eax, blue
    call SetTextColor
    mov dl,0
    mov dh,26            ;2nd last line
    call Gotoxy
    mov edx,OFFSET ground  
    call WriteString
   
    call crlf
    mov eax, white
    call SetTextColor
    mov edx, OFFSET areen  
    call writestring

    mov ecx,3
    call readstring

 
    call clrscr
    mov eax,blue;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground   ;floor line
    call WriteString
    call crlf
    call crlf
    mov eax, blue
    call SetTextColor
    mov edx, Offset naam      ;input name
    call writestring
    mov dl,3
    mov dh,9
    call gotoxy 
    mov eax,white
    call SetTextColor
    mov edx, OFFSET player  
    call WriteString
    mov edx, OFFSET input1     ;printing box
    call WriteString
    mov edx, OFFSET input2
    call WriteString
    mov eax,cyan
    call SetTextColor
    mov dl,28
    mov dh,13
    call gotoxy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;-----input name
    mov eax,0
    mov ecx,25
    mov edx,OFFSET pname
    call ReadString     

    ret
WelcomeScreen ENDP



;////////////////////////////////////////////
;/////////////////////////////////////////////
;///////////////////////////////////////////
GameMenu PROC
    mov eax,blue;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,28
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString 
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground   ;upper line
    call WriteString
    call crlf
    mov eax, blue
    call SetTextColor
    mov edx, OFFSET menu   ;menu logo 
    call writestring
    mov eax, blue
    call SetTextColor
    mov edx, OFFSET menu2   ;menu logo 
    call writestring
    call crlf
    call crlf
    call crlf
    mov eax, white 
    call SetTextColor
    mov eax,0
    mov edx, OFFSET menu3   ;options
    call WriteString


    mov eax,cyan
    call SetTextColor
    mov dl,59
    mov dh,20
    call gotoxy
    call readint

    ret
GameMenu ENDP

startGame PROC
    mov esi, OFFSET m1                    ;stores the offset of the map
    mov dl,0
    mov dh,2
    call gotoxy                          ;sets the starting position of the map (0, 2)
    printer:
        cmp BYTE PTR [esi], '.'         ;if character in map is a dot, then print it white
        jne normal_blue
        mov eax, white
        call settextcolor
        mov al, BYTE PTR [esi]
        call writechar
        jmp agay

        normal_blue:                    ;else, any other character must be printed in blue
        mov eax, blue
        call settextcolor
        mov al, BYTE PTR [esi]
        call writechar
    
        agay:
        cmp BYTE PTR [esi], 0           ;loops until [esi] is 0
        je bahir
        inc esi
        jmp printer

    ;outside this loop lol lmfao xD
    bahir:

    mov eax,blue ;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground   ;upper line
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString

    mov ecx,27
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1  ;left side wall
    call WriteString
    inc temp
    loop l1

    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2   ;right side wall
    call WriteString
    inc temp
    loop l2

    call DrawPlayer
    
ret
startGame ENDP

level2disp PROC
    mov esi, OFFSET m2                    ;stores the offset of the map
    mov dl,0
    mov dh,2
    call gotoxy                          ;sets the starting position of the map (0, 2)
    printer:
        cmp BYTE PTR [esi], '.'         ;if character in map is a dot, then print it white
        jne normal_blue
        mov eax, white
        call settextcolor
        mov al, BYTE PTR [esi]
        call writechar
        jmp agay

        normal_blue:                    ;else, any other character must be printed in blue
        mov eax, brown
        call settextcolor
        mov al, BYTE PTR [esi]
        call writechar
    
        agay:
        cmp BYTE PTR [esi], 0           ;loops until [esi] is 0
        je bahir
        inc esi
        jmp printer

    ;outside this loop lol lmfao xD
    bahir:

    mov eax,brown ;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground   ;upper line
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString

    mov ecx,27
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1  ;left side wall
    call WriteString
    inc temp
    loop l1

    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2   ;right side wall
    call WriteString
    inc temp
    loop l2

    call DrawPlayer
ret
level2disp ENDP

level3disp PROC
    mov esi, OFFSET m3                   ;stores the offset of the map
    mov dl,0
    mov dh,2
    call gotoxy                          ;sets the starting position of the map (0, 2)
    printer:
        cmp BYTE PTR [esi], '.'         ;if character in map is a dot, then print it white
        jne normal_blue
        mov eax, white
        call settextcolor
        mov al, BYTE PTR [esi]
        call writechar
        jmp agay

        normal_blue:                    ;else, any other character must be printed in blue
        mov eax, lightmagenta
        call settextcolor
        mov al, BYTE PTR [esi]
        call writechar
    
        agay:
        cmp BYTE PTR [esi], 0           ;loops until [esi] is 0
        je bahir
        inc esi
        jmp printer

    ;outside this loop lol lmfao xD
    bahir:

    call DrawPlayer
ret
level3disp ENDP

levels PROC
    mov eax,blue 
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground   ;floor line
    call WriteString

    call crlf
    mov dl,0
    mov dh,2
    call Gotoxy
    mov eax, blue
    call SetTextColor
    mov edx, OFFSET lvl   ;level print
    call writestring
    mov edx, OFFSET lvl2   ;level print
    call writestring
    mov dl,0
    mov dh, 10
    call gotoxy
    mov eax, white 
    call SetTextColor
    mov eax,0
    call crlf 
    call crlf
    mov edx, OFFSET leveldisp
    call WriteString
    mov dl,50
    mov dh, 17
    call gotoxy
    call readint
ret
levels ENDP
    
checkwallsL PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    mov esi, offset m1  
    imul eax, 121        
    add eax, edx 
    dec eax
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsL ENDP

checkwallsL2 PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    mov esi, offset m2 
    imul eax, 121        
    add eax, edx 
    dec eax
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsL2 ENDP

checkwallsL3 PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    mov esi, offset m3 
    imul eax, 121        
    add eax, edx 
    dec eax
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsL3 ENDP

checkwallsR PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    mov esi, offset m1  
    imul eax, 121        
    add eax, edx 
    inc eax
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsR ENDP

checkwallsR2 PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    mov esi, offset m2 
    imul eax, 121        
    add eax, edx 
    inc eax
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsR2 ENDP

checkwallsR3 PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    mov esi, offset m3
    imul eax, 121        
    add eax, edx 
    inc eax
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsR3 ENDP

checkwallsU PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    dec eax
    mov esi, offset m1  
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsU ENDP

checkwallsU2 PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    dec eax
    mov esi, offset m2 
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsU2 ENDP

checkwallsU3 PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    dec eax
    mov esi, offset m3
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsU3 ENDP

checkwallsD PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    inc eax
    mov esi, offset m1  
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsD ENDP

checkwallsD2 PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    inc eax
    mov esi, offset m2  
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsD2 ENDP

checkwallsD3 PROC
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    inc eax
    mov esi, offset m3 
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onDot
    mov al, 0
    ret 
    onDot:
    mov al,1
ret
checkwallsD3 ENDP

CheckDot PROC
    ; Check if the player is on a dot ('.'). If yes, update the score.
    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    mov esi, offset m1
    
    imul eax, 120                     ; Multiply the row number by 120 (width of screen)
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    jne notOnDot

    ; If on a dot, update the score and replace the dot with a space
    inc score
    mov BYTE PTR [esi + eax], ' '

    notOnDot:
        ret
CheckDot ENDP

CheckDot2 PROC

    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    mov esi, offset m2
    
    imul eax, 120                    
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    jne notOnDot

    inc score
    mov BYTE PTR [esi + eax], ' '

    notOnDot:
        ret
CheckDot2 ENDP

CheckDot3 PROC

    movzx edx, xPos
    movzx eax, yPos
    sub eax, 2
    mov esi, offset m3
    
    imul eax, 120                    
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    jne notOnDot

    inc score
    mov BYTE PTR [esi + eax], ' '

    notOnDot:
        ret
CheckDot3 ENDP

displayscore PROC
    mov eax,blue
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground   ;floor line
    call WriteString

     call crlf
    mov eax, blue
    call SetTextColor
    mov edx, OFFSET scoore   ;score 
    call writestring

    mov eax, blue
    call SetTextColor
    mov dl,0
    mov dh,8
    call Gotoxy
    mov edx,OFFSET ground  ;middle line
    call WriteString
    mov dl,0
    mov dh,10
    call Gotoxy
    mov eax, white 
    call SetTextColor
    ;  mov edx, OFFSET strScore; scoredisp
    ; call WriteString
    ;mov al,score
    ;call WriteInt

    ;file handling 
    mov edx, offset filename2
    call OpenInputFile
    mov filehandle, eax

    mov eax , filehandle
    mov ecx , 153
    mov edx , offset fileinput
    call readfromfile

    mov edx , offset fileinput
    call writestring

    mov eax , filehandle
    call closefile
    mov al,0ah
    call writechar
    mov edx, offset pname
    call writestring
    mov al, ' '
    call writechar
    mov ax, score
    call writedec
    mov al, ' '
    call writechar
    mov al, levelno
    call writedec

    mov ecx, lengthof fileinput 
    mov esi,0
    loopchalao:
        mov eax, fileinput[esi]
        mov fileoutput[esi],eax
        inc esi
    LOOP loopchalao

        mov ecx, lengthof pname
        mov edx,0
    l1:
        mov eax, pname[edx]
        mov fileoutput[esi],eax
        inc esi
        inc edx

    LOOP l1

            mov edx , offset filename
            call createOutputfile
            mov filehandle2 , eax
        
            mov edx , offset fileoutput 
            mov ecx , sizeof fileoutput
            mov eax , filehandle2
            call writetofile

            mov eax , filehandle
            call closefile
    call readint
ret
displayscore ENDP

pausescreen PROC
    mov eax,blue
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground   ;floor line
    call WriteString
    call crlf
    mov dl,0
    mov dh,3
    call Gotoxy
    mov edx, offset pause1
    call writestring

    mov eax,white
    call SetTextColor
    mov dl,0
    mov dh, 12
    call Gotoxy
    mov edx, offset pause2
    call writestring
    mov dl,42
    mov dh, 19
    call gotoxy
    call readint 
ret
pausescreen ENDP

displayinst PROC
    mov eax,blue
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground   ;floor line
    call WriteString

     call crlf
    mov eax, blue
    call SetTextColor
    mov edx, OFFSET instscreen   
    call writestring
    mov edx, OFFSET instscreen2   
    call writestring

    call crlf
    call crlf
    call crlf
    mov eax, white
    call SetTextColor
    mov eax,0
    mov edx, OFFSET help1
    call WriteString
    mov edx, OFFSET help22
    call WriteString
    mov edx, OFFSET help2
    call WriteString
    call readint

ret
displayinst ENDP

DrawPlayer PROC
    mov eax,brown;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer ENDP

DrawGhost PROC
    mov eax,green +(green*16)
    call SetTextColor
    mov dl,xGos
    mov dh,yGos
    call Gotoxy
    mov al,"K"
    call WriteChar
    ret
DrawGhost ENDP

DrawGhost2 PROC
    mov eax,green  +(green*16)
    call SetTextColor
    mov dl,xGos1
    mov dh,yGos1
    call Gotoxy
    mov al,"E"
    call WriteChar
    ret
DrawGhost2 ENDP

DrawGhost3 PROC
    mov eax,green +(green*16)
    call SetTextColor
    mov dl,xGos2
    mov dh,yGos2
    call Gotoxy
    mov al,"A"
    call WriteChar
    ret
DrawGhost3 ENDP

DrawGhost4 PROC
    mov eax,green +(green*16)
    call SetTextColor
    mov dl,xGos3
    mov dh,yGos3
    call Gotoxy
    mov al,"C"
    call WriteChar
    ret
DrawGhost4 ENDP

MoveGhostL PROC
    mov eax,white;(blue*16)
    call SetTextColor
    movzx edx, xGos
    movzx eax, ygos
    sub eax, 2
    mov esi, offset m1  
    imul eax, 121        
    add eax, edx 
    ;dec eax
    cmp  BYTE PTR [esi + eax+1], '.'   
    je onDot
    cmp BYTE PTR [esi + eax+1], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos
    mov dh,yGos
    call gotoxy
    mov al,'.'
    call writechar
    inc xGos
    jmp bas
    onSpace:
    mov dl,xGos
    mov dh,yGos
    call gotoxy
    mov al,' '
    call writechar
    inc xGos
bas:
    ret
MoveGhostL ENDP

MoveGhostL2 PROC
    mov eax,white;(blue*16)
    call SetTextColor
    movzx edx, xGos1
    movzx eax, ygos1
    sub eax, 2
    mov esi, offset m1  
    imul eax, 121        
    add eax, edx 
    ;dec eax
    cmp  BYTE PTR [esi + eax+1], '.'   
    je onDot
    cmp BYTE PTR [esi + eax+1], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos1
    mov dh,yGos1
    call gotoxy
    mov al,'.'
    call writechar
    inc xGos1
    jmp bas
    onSpace:
    mov dl,xGos1
    mov dh,yGos1
    call gotoxy
    mov al,' '
    call writechar
    inc xGos1
bas:
    ret
MoveGhostL2 ENDP

MoveGhostL3 PROC
    mov eax,white;(blue*16)
    call SetTextColor
    movzx edx, xGos1
    movzx eax, ygos1
    sub eax, 2
    mov esi, offset m2  
    imul eax, 121        
    add eax, edx 
    ;dec eax
    cmp  BYTE PTR [esi + eax+1], '.'   
    je onDot
    cmp BYTE PTR [esi + eax+1], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos1
    mov dh,yGos1
    call gotoxy
    mov al,'.'
    call writechar
    inc xGos1
    jmp bas
    onSpace:
    mov dl,xGos1
    mov dh,yGos1
    call gotoxy
    mov al,' '
    call writechar
    inc xGos1
bas:
    ret
MoveGhostL3 ENDP

MoveGhostD PROC
    mov eax,white;(blue*16)
    call SetTextColor
    movzx edx, xGos2
    movzx eax, yGos2
    sub eax, 2
    inc eax
    mov esi, offset m3  
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos2
    mov dh,yGos2
    call gotoxy
    mov al,'.'
    call writechar
    inc yGos2
    jmp bas
    onSpace:
    mov dl,xGos2
    mov dh,yGos2
    call gotoxy
    mov al,' '
    call writechar
    inc yGos2
bas:
    ret
MoveGhostD ENDP


MoveGhostD2 PROC
    mov eax,white;(blue*16)
    call SetTextColor
    movzx edx, xGos3
    movzx eax, yGos3
    sub eax, 2
    inc eax
    mov esi, offset m3  
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos3
    mov dh,yGos3
    call gotoxy
    mov al,'.'
    call writechar
    inc yGos3
    jmp bas
    onSpace:
    mov dl,xGos3
    mov dh,yGos3
    call gotoxy
    mov al,' '
    call writechar
    inc yGos3
bas:
    ret
MoveGhostD2 ENDP

MoveGhostU PROC
    mov eax,white
    call SetTextColor
    movzx edx, xGos2
    movzx eax, yGos2
    sub eax, 2
    dec eax
    mov esi, offset m3  
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos2
    mov dh,yGos2
    call gotoxy
    mov al,'.'
    call writechar
    dec yGos2
    jmp bas
    onSpace:
    mov dl,xGos2
    mov dh,yGos2
    call gotoxy
    mov al,' '
    call writechar
    dec yGos2
bas:
ret
MoveGhostU ENDP

MoveGhostU2 PROC
    mov eax,white
    call SetTextColor
    movzx edx, xGos3
    movzx eax, yGos3
    sub eax, 2
    dec eax
    mov esi, offset m3  
    imul eax, 121 
    add eax, edx 
    cmp  BYTE PTR [esi + eax], '.'   
    je onDot
    cmp BYTE PTR [esi + eax], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos3
    mov dh,yGos3
    call gotoxy
    mov al,'.'
    call writechar
    dec yGos3
    jmp bas
    onSpace:
    mov dl,xGos3
    mov dh,yGos3
    call gotoxy
    mov al,' '
    call writechar
    dec yGos3
bas:
ret
MoveGhostU2 ENDP

MoveGhostR PROC
    mov eax,white;(blue*16)
    call SetTextColor
    movzx edx, xGos
    movzx eax, ygos
    sub eax, 2
    mov esi, offset m1  
    imul eax, 121        
    add eax, edx 
    ;dec eax
    cmp  BYTE PTR [esi + eax-1], '.'   
    je onDot
    cmp BYTE PTR [esi + eax-1], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos
    mov dh,yGos
    call gotoxy
    mov al,'.'
    call writechar
    dec xGos
    jmp bas
    onSpace:
    mov dl,xGos
    mov dh,yGos
    call gotoxy
    mov al,' '
    call writechar
    dec xGos
bas:
    ret
MoveGhostR ENDP

MoveGhostR2 PROC
    mov eax,white;(blue*16)
    call SetTextColor
    movzx edx, xGos1
    movzx eax, ygos1
    sub eax, 2
    mov esi, offset m1  
    imul eax, 121        
    add eax, edx 
    ;dec eax
    cmp  BYTE PTR [esi + eax-1], '.'   
    je onDot
    cmp BYTE PTR [esi + eax-1], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos1
    mov dh,yGos1
    call gotoxy
    mov al,'.'
    call writechar
    dec xGos1
    jmp bas

    onSpace:
    mov dl,xGos1
    mov dh,yGos1
    call gotoxy
    mov al,' '
    call writechar
    dec xGos1
bas:
    ret
MoveGhostR2 ENDP


MoveGhostR3 PROC
    mov eax,white;(blue*16)
    call SetTextColor
    movzx edx, xGos1
    movzx eax, ygos1
    sub eax, 2
    mov esi, offset m2  
    imul eax, 121        
    add eax, edx 
    ;dec eax
    cmp  BYTE PTR [esi + eax-1], '.'   
    je onDot
    cmp BYTE PTR [esi + eax-1], ' '   
    je onSpace

    ret 
    onDot:
    mov dl,xGos1
    mov dh,yGos1
    call gotoxy
    mov al,'.'
    call writechar
    dec xGos1
    jmp bas

    onSpace:
    mov dl,xGos1
    mov dh,yGos1
    call gotoxy
    mov al,' '
    call writechar
    dec xGos1
bas:
    ret
MoveGhostR3 ENDP


UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP

DrawCoin PROC
        mov eax, red
        call SetTextColor      
        mov dl,xCoinPos
        mov dh,yCoinPos
        call Gotoxy
        mov al,"o"
        call WriteChar
 
ret
DrawCoin ENDP

CreateRandomCoin PROC
    mov eax,55
    inc eax
    call RandomRange
    inc al
    mov xCoinPos,al
    mov yCoinPos,28
    ret
CreateRandomCoin ENDP

nextlevel PROC
    mov eax, blue
    call settextcolor
    mov dl, 0
    mov dh, 10
    call gotoxy
    mov edx, offset complete22
    call writestring
    call readint

ret
nextlevel ENDP

jeet PROC
     mov eax, blue
     call settextcolor
     mov dl, 0
     mov dh, 10
     mov edx, offset MUBARAK
     call writestring
     call readint
ret
jeet ENDP
endgame PROC
    call clrscr
    mov eax,blue;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground   ;floor line
    call WriteString
    mov dl,0
    mov dh,2
    call Gotoxy

    mov eax, blue
    call SetTextColor
    mov edx, OFFSET existhojao1   
    call writestring

    mov eax, cyan
    call SetTextColor
    mov edx, OFFSET existhojao2   
    call writestring

    mov eax, yellow
    call SetTextColor
    mov edx, OFFSET existhojao3
    call writestring
    call crlf 
    mov dl,40
    mov dh,15
    call gotoxy
    mov edx, offset p1
    call writestring
    mov edx, offset pname
    call writestring
    mov dl,40
    mov dh,17
    call gotoxy
    mov edx, offset p2
    call writestring
    mov ax, score
    call writedec
    mov dl,40
    mov dh,20
    call gotoxy
    mov edx, offset byemsg
    call writestring
    mov dl,40
    mov dh,21
    call gotoxy
    call readint

    call clrscr
    mov eax,blue;(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground  ;ground line
    call WriteString
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground   ;floor line
    call WriteString

    mov dl, 0
    mov dh,4
    call gotoxy
    mov eax, blue
    call SetTextColor
    mov edx, offset goodbye
    call writestring
    mov eax, cyan
    call SetTextColor
    mov edx, offset goodbye2
    call writestring
    mov dl, 10
    mov dh,13
    call gotoxy
    mov edx, offset goodbye3
    call writestring
    mov dl,0
    mov dh,21
    call Gotoxy
    mov edx,OFFSET ground   ;floor line
    call WriteString
    mov eax, yellow     ;  lightmagenta
    call SetTextColor
    mov dl,10
    mov dh,22         ;2nd last line
    call Gotoxy
    mov edx,OFFSET allahhafiz
    call WriteString

    call readint
 
ret 
endgame ENDP

END main