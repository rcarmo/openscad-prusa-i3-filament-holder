SRCS = holder.scad feeder.scad
STLS = $(SRCS:.scad=.stl)
IMGS = $(SRCS:.scad=.png)

all: images models 

models: $(STLS)

images: $(IMGS)

%.stl : %.scad
	openscad $< --export-format binstl -o stl/$@ 
	python3 canonicalize.py stl/$@

%.png : %.scad
	openscad $< --viewall --autocenter --imgsize=640,480 -o img/$@ 

clean:
	-rm stl/*.stl img/*.png