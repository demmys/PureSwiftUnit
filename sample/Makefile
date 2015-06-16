COMPILER = $(shell xcrun -f swiftc)

SRCS = *.swift
TARGET = sample

INCLUDES = $(shell cd ..; make includes)
LIBS = $(shell cd ..; make libs)

.PHONY: test clean

test: $(TARGET)
	@./$(TARGET)

$(TARGET): $(SRCS)
	$(COMPILER) $(INCLUDES) $(LIBS) -o $@ $^

clean:
	rm $(TARGET)
