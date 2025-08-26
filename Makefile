CXX := g++
CXXFLAGS :=
LDLIBS :=

SRCDIR := FallingSandSurvival
OBJDIR := obj
BINDIR := bin
INCDIR := include
LIBDIR := lib

SRC := $(notdir $(wildcard $(SRCDIR)/*.cpp))
OBJ := $(SRC:.cpp=.o)
BIN := fss

all: dirs $(BIN)

$(BIN): $(OBJ)
	$(CXX) -o $@ $(addprefix $(OBJDIR)/, $^) $(LDLIBS)

%.o: $(SRCDIR)/%.cpp
	$(CXX) -Wall -o $(OBJDIR)/$@ -c $< $(CXXFLAGS)

SDL_gpu:
	@-if [ ! -d sdl-gpu/build ]; then mkdir sdl-gpu/build; fi;
	cmake -S sdl-gpu -B sdl-gpu/build
	cmake --build sdl-gpu/build --parallel `nproc`

dirs:
	@-if [ ! -d $(BINDIR) ]; then mkdir $(BINDIR); fi;
	@-if [ ! -d $(OBJDIR) ]; then mkdir $(OBJDIR); fi;
	@-if [ ! -d $(LIBDIR) ]; then mkdir $(LIBDIR); fi;
	@-if [ ! -d $(INCDIR) ]; then mkdir $(INCDIR); fi;

clean:
	@-rm $(BINDIR) -rf
	@-rm $(OBJDIR) -rf
	@-rm $(LIBDIR) -rf
	@-rm $(INCDIR) -rf
	@-rm sdl-gpu/build -rf
