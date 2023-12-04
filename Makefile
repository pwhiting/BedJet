# Makefile to convert .scad files to .stl using OpenSCAD
# pete
# Define the OpenSCAD command
OPENSCAD = /Applications/OpenSCAD.app/Contents/MacOS/OpenScad

# These are used by the other scad files
INCLUDES = Constants.scad Library.scad
# Find all .scad files in the current directory
SCAD_FILES := $(wildcard *.scad)
SCAD_FILES := $(filter-out $(INCLUDES),$(SCAD_FILES))
#SCAD_FILES = $(wildcard P*.scad)

# Replace the file extension from .scad to .stl for all filenames
STL_FILES := $(SCAD_FILES:.scad=.stl)

# Default target
all: $(STL_FILES)

# Generic rule for converting .scad to .stl
%.stl: %.scad $(INCLUDES) 
	$(OPENSCAD) -o $@ $<

# Clean target to remove all .stl files
clean:
	rm $(wildcard *.stl) 

# Phony targets
.PHONY: all clean
