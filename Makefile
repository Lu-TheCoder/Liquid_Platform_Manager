# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

APP_NAME := LiquidApp
BUILD_DIR := build

SRC_FILES_C := $(call rwildcard,src/,*.c)
SRC_FILES_M := $(call rwildcard,src/,*.m)

#MAC_OS
COMPILER_FLAGS := -g -framework Cocoa -framework Foundation -framework QuartzCore -framework AppKit -framework IOKit
LINKER_FLAGS :=
INCLUDE_FLAGS := -Isrc 
DEFINES := 

.PHONY: scaffold build run

scaffold:
	[ -d $(BUILD_DIR) ] || mkdir -p $(BUILD_DIR)


build:
	gcc $(SRC_FILES_C)$(SRC_FILES_M) $(COMPILER_FLAGS) -o $(BUILD_DIR)/$(APP_NAME) $(DEFINES) $(INCLUDE_FLAGS) $(LINKER_FLAGS)

run:
	./build/LiquidApp