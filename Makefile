all: DN2_information_architecture.png DN2_information_architecture.svg platform_business_chart.png platform_business_chart.svg platform_services.png platform_services.svg tiering.png tiering.svg

%.svg: %.gv
	cat $< | unflatten -l 3 -f -c 5 | dot -Tsvg > $@

%.png: %.gv
	cat $< | unflatten -l 3 -f -c 5 | dot -Tpng > $@
