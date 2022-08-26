all: DN2_information_architecture.png DN2_information_architecture.svg platform_business_chart.png platform_business_chart.svg platform_services.png platform_services.svg

DN2_information_architecture.png: DN2_information_architecture.gv
	cat DN2_information_architecture.gv | unflatten -l 3 -f -c 5 | dot -Tpng > $@

DN2_information_architecture.svg: DN2_information_architecture.gv
	cat DN2_information_architecture.gv | unflatten -l 3 -f -c 5 | dot -Tsvg > $@

platform_business_chart.png: platform_business_chart.gv
	cat platform_business_chart.gv | unflatten -l 3 -f -c 5 | dot -Tpng > $@

platform_business_chart.svg: platform_business_chart.gv
	cat platform_business_chart.gv | unflatten -l 3 -f -c 5 | dot -Tsvg > $@

platform_services.png: platform_services.gv
	cat platform_services.gv | unflatten -l 3 -f -c 5 | dot -Tpng > $@

platform_services.svg: platform_services.gv
	cat platform_services.gv | unflatten -l 3 -f -c 5 | dot -Tsvg > $@
