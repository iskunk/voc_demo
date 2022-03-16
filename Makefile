BIN = voc_demo

CFLAGS += -std=c99 -pedantic -O2 -g -Inuklear -Ivoc
CXXFLAGS += -O2 -g -Irtaudio -Ivoc
CONFIG ?=

include $(CONFIG)

OBJ = main.o rtaudio/RtAudio.o audio.o voc/voc.o
UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
CXX=clang++
CXXFLAGS+=-D__MACOSX_CORE__
CFLAGS+=-D__MACOSX_CORE__
LIBS +=-framework CoreAudio -framework CoreMIDI -framework CoreFoundation \
	-framework IOKit -framework Carbon  -framework OpenGL \
	-framework GLUT -framework Foundation \
	-framework AppKit -L/usr/local/lib
LIBS += -lglfw -framework Cocoa -framework CoreVideo -lm
CXXFLAGS += -I/usr/local/include
CFLAGS += -I/usr/local/include

# Header files needed for MacPorts installations
CFLAGS += -I/opt/local/include -L/opt/local/lib
else
CXX=g++

ifeq ($(UNAME), Linux)
CXXFLAGS += -D__LINUX_ALSA__
LIBS += -lasound
else
CXXFLAGS += -D__UNIX_JACK__
LIBS += -ljack
endif

LIBS += -lglfw -lGL -lm -lGLU -lpthread
endif


%.o: %.c
	$(CC) -c $< $(CFLAGS) -o $@

%.o: %.cpp
	$(CXX) -c $< $(CXXFLAGS) -o $@

$(BIN): $(OBJ)
	$(CXX) $(OBJ) $(CXXFLAGS) -o $(BIN) $(LIBS)

clean:
	rm -rf $(BIN)
	rm -rf $(OBJ)
