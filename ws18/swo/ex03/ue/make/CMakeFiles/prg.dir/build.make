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
CMAKE_SOURCE_DIR = /home/khp/git/fh-hgb/ws18/swo/ex03/ue

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/khp/git/fh-hgb/ws18/swo/ex03/ue

# Include any dependencies generated for this target.
include CMakeFiles/prg.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/prg.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/prg.dir/flags.make

CMakeFiles/prg.dir/geo/geo.c.o: CMakeFiles/prg.dir/flags.make
CMakeFiles/prg.dir/geo/geo.c.o: geo/geo.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/khp/git/fh-hgb/ws18/swo/ex03/ue/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/prg.dir/geo/geo.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/prg.dir/geo/geo.c.o   -c /home/khp/git/fh-hgb/ws18/swo/ex03/ue/geo/geo.c

CMakeFiles/prg.dir/geo/geo.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/prg.dir/geo/geo.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/khp/git/fh-hgb/ws18/swo/ex03/ue/geo/geo.c > CMakeFiles/prg.dir/geo/geo.c.i

CMakeFiles/prg.dir/geo/geo.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/prg.dir/geo/geo.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/khp/git/fh-hgb/ws18/swo/ex03/ue/geo/geo.c -o CMakeFiles/prg.dir/geo/geo.c.s

CMakeFiles/prg.dir/geo/geo.c.o.requires:

.PHONY : CMakeFiles/prg.dir/geo/geo.c.o.requires

CMakeFiles/prg.dir/geo/geo.c.o.provides: CMakeFiles/prg.dir/geo/geo.c.o.requires
	$(MAKE) -f CMakeFiles/prg.dir/build.make CMakeFiles/prg.dir/geo/geo.c.o.provides.build
.PHONY : CMakeFiles/prg.dir/geo/geo.c.o.provides

CMakeFiles/prg.dir/geo/geo.c.o.provides.build: CMakeFiles/prg.dir/geo/geo.c.o


CMakeFiles/prg.dir/geo/prg.c.o: CMakeFiles/prg.dir/flags.make
CMakeFiles/prg.dir/geo/prg.c.o: geo/prg.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/khp/git/fh-hgb/ws18/swo/ex03/ue/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/prg.dir/geo/prg.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/prg.dir/geo/prg.c.o   -c /home/khp/git/fh-hgb/ws18/swo/ex03/ue/geo/prg.c

CMakeFiles/prg.dir/geo/prg.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/prg.dir/geo/prg.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/khp/git/fh-hgb/ws18/swo/ex03/ue/geo/prg.c > CMakeFiles/prg.dir/geo/prg.c.i

CMakeFiles/prg.dir/geo/prg.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/prg.dir/geo/prg.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/khp/git/fh-hgb/ws18/swo/ex03/ue/geo/prg.c -o CMakeFiles/prg.dir/geo/prg.c.s

CMakeFiles/prg.dir/geo/prg.c.o.requires:

.PHONY : CMakeFiles/prg.dir/geo/prg.c.o.requires

CMakeFiles/prg.dir/geo/prg.c.o.provides: CMakeFiles/prg.dir/geo/prg.c.o.requires
	$(MAKE) -f CMakeFiles/prg.dir/build.make CMakeFiles/prg.dir/geo/prg.c.o.provides.build
.PHONY : CMakeFiles/prg.dir/geo/prg.c.o.provides

CMakeFiles/prg.dir/geo/prg.c.o.provides.build: CMakeFiles/prg.dir/geo/prg.c.o


CMakeFiles/prg.dir/geo/weight.c.o: CMakeFiles/prg.dir/flags.make
CMakeFiles/prg.dir/geo/weight.c.o: geo/weight.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/khp/git/fh-hgb/ws18/swo/ex03/ue/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/prg.dir/geo/weight.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/prg.dir/geo/weight.c.o   -c /home/khp/git/fh-hgb/ws18/swo/ex03/ue/geo/weight.c

CMakeFiles/prg.dir/geo/weight.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/prg.dir/geo/weight.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/khp/git/fh-hgb/ws18/swo/ex03/ue/geo/weight.c > CMakeFiles/prg.dir/geo/weight.c.i

CMakeFiles/prg.dir/geo/weight.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/prg.dir/geo/weight.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/khp/git/fh-hgb/ws18/swo/ex03/ue/geo/weight.c -o CMakeFiles/prg.dir/geo/weight.c.s

CMakeFiles/prg.dir/geo/weight.c.o.requires:

.PHONY : CMakeFiles/prg.dir/geo/weight.c.o.requires

CMakeFiles/prg.dir/geo/weight.c.o.provides: CMakeFiles/prg.dir/geo/weight.c.o.requires
	$(MAKE) -f CMakeFiles/prg.dir/build.make CMakeFiles/prg.dir/geo/weight.c.o.provides.build
.PHONY : CMakeFiles/prg.dir/geo/weight.c.o.provides

CMakeFiles/prg.dir/geo/weight.c.o.provides.build: CMakeFiles/prg.dir/geo/weight.c.o


# Object files for target prg
prg_OBJECTS = \
"CMakeFiles/prg.dir/geo/geo.c.o" \
"CMakeFiles/prg.dir/geo/prg.c.o" \
"CMakeFiles/prg.dir/geo/weight.c.o"

# External object files for target prg
prg_EXTERNAL_OBJECTS =

prg: CMakeFiles/prg.dir/geo/geo.c.o
prg: CMakeFiles/prg.dir/geo/prg.c.o
prg: CMakeFiles/prg.dir/geo/weight.c.o
prg: CMakeFiles/prg.dir/build.make
prg: CMakeFiles/prg.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/khp/git/fh-hgb/ws18/swo/ex03/ue/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking C executable prg"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/prg.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/prg.dir/build: prg

.PHONY : CMakeFiles/prg.dir/build

CMakeFiles/prg.dir/requires: CMakeFiles/prg.dir/geo/geo.c.o.requires
CMakeFiles/prg.dir/requires: CMakeFiles/prg.dir/geo/prg.c.o.requires
CMakeFiles/prg.dir/requires: CMakeFiles/prg.dir/geo/weight.c.o.requires

.PHONY : CMakeFiles/prg.dir/requires

CMakeFiles/prg.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/prg.dir/cmake_clean.cmake
.PHONY : CMakeFiles/prg.dir/clean

CMakeFiles/prg.dir/depend:
	cd /home/khp/git/fh-hgb/ws18/swo/ex03/ue && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/khp/git/fh-hgb/ws18/swo/ex03/ue /home/khp/git/fh-hgb/ws18/swo/ex03/ue /home/khp/git/fh-hgb/ws18/swo/ex03/ue /home/khp/git/fh-hgb/ws18/swo/ex03/ue /home/khp/git/fh-hgb/ws18/swo/ex03/ue/CMakeFiles/prg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/prg.dir/depend

