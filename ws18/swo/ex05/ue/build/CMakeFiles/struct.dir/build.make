# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

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
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/khp/git/khp-hgb/ws18/swo/ex05/ue

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/khp/git/khp-hgb/ws18/swo/ex05/ue/build

# Include any dependencies generated for this target.
include CMakeFiles/struct.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/struct.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/struct.dir/flags.make

CMakeFiles/struct.dir/struct/struct_test.c.o: CMakeFiles/struct.dir/flags.make
CMakeFiles/struct.dir/struct/struct_test.c.o: ../struct/struct_test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/khp/git/khp-hgb/ws18/swo/ex05/ue/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/struct.dir/struct/struct_test.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/struct.dir/struct/struct_test.c.o   -c /home/khp/git/khp-hgb/ws18/swo/ex05/ue/struct/struct_test.c

CMakeFiles/struct.dir/struct/struct_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/struct.dir/struct/struct_test.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/khp/git/khp-hgb/ws18/swo/ex05/ue/struct/struct_test.c > CMakeFiles/struct.dir/struct/struct_test.c.i

CMakeFiles/struct.dir/struct/struct_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/struct.dir/struct/struct_test.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/khp/git/khp-hgb/ws18/swo/ex05/ue/struct/struct_test.c -o CMakeFiles/struct.dir/struct/struct_test.c.s

CMakeFiles/struct.dir/struct/struct_test.c.o.requires:

.PHONY : CMakeFiles/struct.dir/struct/struct_test.c.o.requires

CMakeFiles/struct.dir/struct/struct_test.c.o.provides: CMakeFiles/struct.dir/struct/struct_test.c.o.requires
	$(MAKE) -f CMakeFiles/struct.dir/build.make CMakeFiles/struct.dir/struct/struct_test.c.o.provides.build
.PHONY : CMakeFiles/struct.dir/struct/struct_test.c.o.provides

CMakeFiles/struct.dir/struct/struct_test.c.o.provides.build: CMakeFiles/struct.dir/struct/struct_test.c.o


# Object files for target struct
struct_OBJECTS = \
"CMakeFiles/struct.dir/struct/struct_test.c.o"

# External object files for target struct
struct_EXTERNAL_OBJECTS =

struct: CMakeFiles/struct.dir/struct/struct_test.c.o
struct: CMakeFiles/struct.dir/build.make
struct: CMakeFiles/struct.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/khp/git/khp-hgb/ws18/swo/ex05/ue/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable struct"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/struct.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/struct.dir/build: struct

.PHONY : CMakeFiles/struct.dir/build

CMakeFiles/struct.dir/requires: CMakeFiles/struct.dir/struct/struct_test.c.o.requires

.PHONY : CMakeFiles/struct.dir/requires

CMakeFiles/struct.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/struct.dir/cmake_clean.cmake
.PHONY : CMakeFiles/struct.dir/clean

CMakeFiles/struct.dir/depend:
	cd /home/khp/git/khp-hgb/ws18/swo/ex05/ue/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/khp/git/khp-hgb/ws18/swo/ex05/ue /home/khp/git/khp-hgb/ws18/swo/ex05/ue /home/khp/git/khp-hgb/ws18/swo/ex05/ue/build /home/khp/git/khp-hgb/ws18/swo/ex05/ue/build /home/khp/git/khp-hgb/ws18/swo/ex05/ue/build/CMakeFiles/struct.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/struct.dir/depend

