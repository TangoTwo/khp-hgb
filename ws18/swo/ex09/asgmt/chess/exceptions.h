//
// Created by khp on 15.12.18.
//

#ifndef CHESS_EXCEPTIONS_H
#define CHESS_EXCEPTIONS_H

#include <exception>
#include <iostream>

class GameOverException : public std::exception {
    virtual const char *what() const throw() {
        return "Game over!";
    }
};

class NoChessmanException : public std::exception {
    virtual const char *what() const throw() {
        return "No chessman to pick up!";
    }
};

class ChessboardTooSmallException : public std::exception {
    virtual const char *what() const throw() {
        return "Board size too small!";
    }
};

#endif //CHESS_EXCEPTIONS_H
