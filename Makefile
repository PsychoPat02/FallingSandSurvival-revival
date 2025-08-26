CXX := g++
CXXFLAGS :=
LDLIBS :=

SRCDIR := FallingSandSurvival
OBJDIR := obj
BINDIR := bin

SRC := $(notdir $(wildcard $(SRCDIR)/*.cpp))
OBJ := $(SRC:.cpp=.o)
BIN := fss

all: dirs $(BIN)

$(BIN): $(OBJ)
	$(CXX) -o $@ $(addprefix $(OBJDIR)/, $^) $(LDLIBS)

%.o: $(SRCDIR)/%.cpp
	$(CXX) -Wall -o $(OBJDIR)/$@ -c $< $(CXXFLAGS)

dirs:
	@-if [ ! -d $(BINDIR) ]; then mkdir $(BINDIR); fi;
	@-if [ ! -d $(OBJDIR) ]; then mkdir $(OBJDIR); fi;

clean:
	@-rm $(BINDIR) -rf
	@-rm $(OBJDIR) -rf
