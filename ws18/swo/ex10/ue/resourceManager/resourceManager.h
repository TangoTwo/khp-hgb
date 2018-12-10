//
// Created by khp on 10.12.18.
//

#ifndef PROJECT_RESOURCEMANAGER_H
#define PROJECT_RESOURCEMANAGER_H

#include <string>

class resourceManager {
public:
    resourceManager() = delete;
    resourceManager(const std::string data) : _data{data}, _allocated{true} {
        std::cout << "acquired resource " << _data << std::endl;
    }

    resourceManager(const resourceManager &rhs) = delete;
    resourceManager &operator=(const resourceManager &rhs) = delete;

    resourceManager(resourceManager &&rhs) : _data{std::move(rhs._data)}, _allocated{true} {
        rhs._allocated = false;
        std::cout << "moved resource " << _data << std::endl;
    }

    void use() {
        if (_allocated)
            std:: cout << "using resource " << _data << std::endl;
    }

    ~resourceManager() {
        (_allocated ? std::cout << "released resource " << _data : std::cout << "released empty resourceManager") << std::endl;
    }
private:
    std::string _data {};
    bool _allocated{false};
};
#endif //PROJECT_RESOURCEMANAGER_H
