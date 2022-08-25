all: DN2_information_architecture.png DN2_information_architecture.svg

DN2_information_architecture.png: DN2_information_architecture.gv
	cat DN2_information_architecture.gv | unflatten -l 3 -f -c 5 | dot -Tpng > $@


DN2_information_architecture.svg: DN2_information_architecture.gv
	cat DN2_information_architecture.gv | unflatten -l 3 -f -c 5 | dot -Tsvg > $@


	
