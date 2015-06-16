COMPILER = $(shell xcrun -f swiftc)
LIBTOOL = $(shell xcrun -f libtool)
LIBS = $(shell xcode-select -p)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx

SRC_DIR = src
INC_DIR = include
OBJ_DIR = obj
BIN_DIR = bin

SRCS = $(shell find $(SRC_DIR) -name '*.swift')
OBJS = $(subst $(SRC_DIR),$(OBJ_DIR),$(SRCS:.swift=.o))

MODULE = PureSwiftUnit

MODFLAGS = -module-name $(MODULE) -emit-module
OBJFLAGS = -module-name $(MODULE) -emit-library -emit-object
BINFLAGS = -lc -L$(LIBS) -dynamic

INCLUDE_FILE = $(INC_DIR)/$(MODULE).swiftmodule
DYLIB_FILE = $(CURDIR)/$(BIN_DIR)/lib$(MODULE).dylib

.PHONY: default all flags clean

default: $(INCLUDE_FILE) $(DYLIB_FILE)

$(INCLUDE_FILE): $(SRCS)
	@[ -d $(INC_DIR) ] || mkdir -p $(INC_DIR)
	cd $(INC_DIR); $(COMPILER) $(MODFLAGS) $(addprefix ../,$^)

$(DYLIB_FILE): $(OBJS)
	@[ -d $(BIN_DIR) ] || mkdir -p $(BIN_DIR)
	$(LIBTOOL) $(BINFLAGS) -o $@ $^

$(OBJS): $(SRCS)
	@[ -d $(OBJ_DIR) ] || mkdir -p $(OBJ_DIR)
	cd $(OBJ_DIR); $(COMPILER) $(OBJFLAGS) $(addprefix ../,$^)

all: clean default

includes: $(INCLUDE_FILE)
	@echo "-I$(CURDIR)/$(INC_DIR)"

libs: $(DYLIB_FILE)
	@echo "-L$(CURDIR)/$(BIN_DIR) -l$(MODULE)"

clean:
	rm -rf $(INC_DIR) $(OBJ_DIR) $(BIN_DIR)
