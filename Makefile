CXX       = g++

# флаги компиляции
CXXFLAGS =
CXXFLAGS += -std=c++11 -O2 -march=native
CXXFLAGS += -g
CXXFLAGS += -DDISABLE_RANDOM_SEED
CXXFLAGS += $(shell pkg-config --cflags blitz)

# флаги сборки (библиотеки)
LDFLAGS = 
LDFLAGS += $(shell pkg-config --libs lapack)
LDFLAGS += $(shell pkg-config --libs blas)
LDFLAGS += $(shell pkg-config --libs blitz)

SOURCES = main.cc
BINARY = autoreg

VISUAL = visual
VISUAL_SOURCES = visual.cc
VISUAL_LDFLAGS = $(shell pkg-config --libs glut) -lGL

$(BINARY): $(SOURCES) Makefile
$(BINARY): autoreg_driver.hh autoreg.hh parallel_mt.hh sysv.hh types.hh voodoo.hh
$(BINARY):
	$(CXX) $(CXXFLAGS) $(SOURCES) $(LDFLAGS) -o $(BINARY)

$(VISUAL): Makefile $(VISUAL_SOURCES)
$(VISUAL): autoreg_driver.hh autoreg.hh parallel_mt.hh sysv.hh types.hh voodoo.hh
$(VISUAL):
	$(CXX) $(CXXFLAGS) $(VISUAL_SOURCES) $(VISUAL_LDFLAGS) -o $(VISUAL)

clean:
	rm -f $(BINARY) $(VISUAL)

profile:
	$(CXX) -pg $(CXXFLAGS) $(SOURCES) $(LDFLAGS) -o pautoreg