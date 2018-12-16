//
// Created by khp on 06.12.18.
//

#include <iostream>
#include <cstring>
#include "gamemodes.h"

bool UTF_8 = false;
bool CLEAR_CONSOLE = false;

int main(int argc, char *argv[]) {
    // parse cmd arguments
    for (int j = 1; j < argc; ++j) {
        char *argument = argv[j];
        if (std::strncmp(argument, "-u", 2) == 0) {
            std::cout << "UTF-8 Mode enabled!" << std::endl;
            UTF_8 = true;
        } else if (std::strncmp(argument, "-c", 2) == 0) {
            std::cout << "Clear Mode enabled!" << std::endl;
            CLEAR_CONSOLE = true;
        } else {
            std::cout << "Usage: " << argv[0] << " [options]" << std::endl;
            std::cout << "Options:" << std::endl;
            std::cout << "  -u   Enable UTF-8 mode." << std::endl;
            std::cout << "  -c   Clear console after move (Linux only)." << std::endl;
            return EXIT_FAILURE;
        }
    }

    bool exit = false;
    while (!exit) {
        clearCmd();
        char tChoice;
        std::cout << "Welcome to chess v1.0" << std::endl;
        std::cout << "Copyright 2018 by Konstantin Papesh" << std::endl << std::endl;
        std::cout << "Please select game mode:" << std::endl;
        std::cout << "  (M) - Multiplayer" << std::endl;
        std::cout << "  (S) - Simulated" << std::endl;
        std::cout << "  (E) - Exit" << std::endl;
        std::cin >> tChoice;
        if (std::toupper(tChoice) == 'M')
            multiplayerGame();
        else if (std::toupper(tChoice) == 'S')
            simulatedGame();
        else if (std::toupper(tChoice) == 'E') {
            exit = true;
        }
    }
    return 0;
}