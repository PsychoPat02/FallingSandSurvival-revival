CXX := g++
CXXFLAGS := -I./include/ -I./include/SDL/ -I./include/SDL_config
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

SDL_gpu: dirs
	@-if [ ! -d sdl-gpu/build ]; then mkdir sdl-gpu/build; fi;
	cmake -S sdl-gpu -B sdl-gpu/build
	cmake --build sdl-gpu/build --parallel `nproc`

	cp sdl-gpu/build/SDL_gpu/include/* $(INCDIR) -r

SDL: dirs
	@-if [ ! -d SDL/build ]; then mkdir SDL/build; fi;
	cmake -S SDL -B SDL/build
	cmake --build SDL/build --parallel `nproc`

	@-if [ ! -d $(INCDIR)/SDL ]; then mkdir $(INCDIR)/SDL; fi;
	@-if [ ! -d $(INCDIR)/SDL_config ]; then mkdir $(INCDIR)/SDL_config; fi;
	cp SDL/build/include/SDL2/* $(INCDIR)/SDL/ -r
	cp SDL/build/include-config-/SDL2/* $(INCDIR)/SDL_config/ -r

easy: dirs
	@-if [ ! -d easy_profiler/buid ]; then mkdir easy_profiler/build; fi;
	cmake -S easy_profiler -B easy_profiler/build
	cmake --build easy_profiler/build --parallel `nproc`

	@-if [ ! -d $(INCDIR)/easy ]; then mkdir $(INCDIR)/easy; fi;
	cp easy_profiler/easy_profiler_core/include/easy/* $(INCDIR)/easy/ -r

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
	@-rm SDL/build -rf
	@-rm easy_profiler/build -rf
