# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.12

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/khp/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/183.4284.104/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/khp/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/183.4284.104/bin/cmake/linux/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/khp/git/fh-hgb/ws18/swo/ex07/ue

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/khp/git/fh-hgb/ws18/swo/ex07/ue/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/ue.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/ue.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ue.dir/flags.make

CMakeFiles/ue.dir/main.cpp.o: CMakeFiles/ue.dir/flags.make
CMakeFiles/ue.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/khp/git/fh-hgb/ws18/swo/ex07/ue/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/ue.dir/main.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/ue.dir/main.cpp.o -c /home/khp/git/fh-hgb/ws18/swo/ex07/ue/main.cpp

CMakeFiles/ue.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ue.dir/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/khp/git/fh-hgb/ws18/swo/ex07/ue/main.cpp > CMakeFiles/ue.dir/main.cpp.i

CMakeFiles/ue.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ue.dir/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/khp/git/fh-hgb/ws18/swo/ex07/ue/main.cpp -o CMakeFiles/ue.dir/main.cpp.s

# Object files for target ue
ue_OBJECTS = \
"CMakeFiles/ue.dir/main.cpp.o"

# External object files for target ue
ue_EXTERNAL_OBJECTS =

ue: CMakeFiles/ue.dir/main.cpp.o
ue: CMakeFiles/ue.dir/build.make
ue: CMakeFiles/ue.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/khp/git/fh-hgb/ws18/swo/ex07/ue/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ue"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ue.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/ue.dir/build: ue

.PHONY : CMakeFiles/ue.dir/build

CMakeFiles/ue.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ue.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ue.dir/clean

CMakeFiles/ue.dir/depend:
	cd /home/khp/git/fh-hgb/ws18/swo/ex07/ue/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/khp/git/fh-hgb/ws18/swo/ex07/ue /home/khp/git/fh-hgb/ws18/swo/ex07/ue /home/khp/git/fh-hgb/ws18/swo/ex07/ue/cmake-build-debug /home/khp/git/fh-hgb/ws18/swo/ex07/ue/cmake-build-debug /home/khp/git/fh-hgb/ws18/swo/ex07/ue/cmake-build-debug/CMakeFiles/ue.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ue.dir/depend

