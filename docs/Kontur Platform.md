Kontur Platform is a software stack that Kontur uses and supports. PostGIS is used for data storage and processing, Java and Python for business logic. All components are open sourced. All the components can be customized to the organization’s style.

We chose on-premise k8s to make sure the platform can be made available if the internet is out. We haven’t tried it yet but we were developing this to support mobile command center use cases. We need an implementation partner for that to get the field feedback on how the system operates and what are the need.

Hardware: 4 nodes of AMD EPYC 7502 32-Core Processor, 512 Gb RAM, 8 x 4Tb = 32Tb NVME drives.
Tiers: dev, test, prod.

Key Components:

- Kontur platform frontend and gateway (disaster-ninja-*) uses React, MapLibre, MVT, Reatom, Typescript, golang, Java. Supports login, welcome page, data quality reports, Event Feed display, shows layers from LayersDB, analytics based on Insights Engine, GPS and Inertial sensors data collection. Is multi tenant, can handle multiple domains in one installation. Can power geoportals and dashboards.

- LayersDB (layers-*) is enabling the Data Catalog. Has all layers from OSM editor-layer-index and Kontur’s datasets. Developed in SQL, PostGIS, Make, k8s, python. Compliant with OGC API Features. Supports collecting GPS and accelerometer data from moving vehicles. Current database size: ~1 Tb x 2xHA setup x 3 Tiers ~= 6Tb.

- Geocint (geocint-*) is a geodata pipeline designed for easy maintenance and high single node throughput. The technology stack includes Bash, GNU Make, Postgres, PostGIS, and aws-cli. Daily refreshes the datasets available on Disaster Ninja. Can handle raster, vector and H3 data sources. Requires less coding training than other solutions, only SQL that is already taught to GIS professionals. Current database size: ~10 Tb x 2 Tiers (dev, prod) ~= 20Tb.

- Insights Engine (insights-*) allows correlating multiple datasets in the region of interest, using bivariate maps, MCDA (multi-criteria decision analysis) and zonal statistics. Technology stack is Postgres, PostGIS, Java, Python, OpenAI, Redis, Bash, Make, Graphql. Has more than 200 H3 based layers to support analysis even if the user did not bring any own data to the platform. Layers are population, OpenStreetMap based extracts and statistics, DEM, NDVI, Climate, buildings, Foursquare, MapSwipe, PDC Global RVA, Probable Futures, Night Lights intensity, powerlines, solar, GDP and others. Integrates using Geocint pipeline. Can process planet-scale datasets. Current database size: ~10 Tb x 2xHA setup x 3 Tiers ~= 60Tb.

- Event Feed. (event-api) Technology stack is Postgres, PostGIS, Java. An event refers to a specific disaster with a time frame, footprint, etc. Each event consists of episodes – snapshots of the state of the event. They show how events are evolving during the time. Kontur provides event footprint polygons, intensity, and severity gathered and selected from all available sources. This data can be combined with Kontur Population and utilized in various scenarios across humanitarian, governmental, insurance verticals. Event Feed contains real-time data and we also maintain extensive historical data to perform analytics. Has a lot of public datasets like GDACS and some exclusive ones, like PDC disaster feed and global NASA flood outlines. The data is updated live as soon as the source providers publish it. Uses Insights Engine to process the events. Current database size: ~5 Tb x 2xHA setup x 3 Tiers ~= 30Tb.

- Basemap - Kontur has OpenStreetMap based basemaps for data visualizations: light (Konur Lines) and dark (Kontur Zmrok). Basemaps are used in Disaster Ninja. Available in Foursquare Studio. MapCSS for map styling. Support multiple languages. Current database size: ~1 Tb x 2xHA setup x 3 Tiers ~= 6Tb.

- OpenAerialMap mosaic - stitches global map of community-provided global drone mosaic. Current disk usage: ~1 Tb (1 copy, no replication).

- Kontur Population is the ultimate population density dataset based on the highest resolution available public ones. H3 hexagons of resolution 8 (400m edge length). We release a new version every year.

- Kontur Boundaries is the dataset of Boundaries. We built it to enable migration of PDC from using GADM to more precise OpenStreetMap data. Has HASC codes based on Wikidata.

- Isochrone engine powers City Split Tool, an app that can help find catchment areas for the multiple points serving one goal and analyze which of them has highest performance and which could be closed. Helps optimize shelters, or pizza delivery.

Kontur Platform utilizes Keycloak as the IAM solution to manage access permissions and authentication.

Kontur is developing the core of the PostGIS extension, there were committers on the team and Darafei Praliaskouski is a member of the PostGIS Project Steering Committee. This expertise helps low-level maintenance of larger databases.

Projects executed:

Disaster Ninja is a situational awareness dashboard for HOT that helps execute mapping activations faster. Features analytics on the quality of OpenStreetMap in every region, map of active contributors to OSM to reach out to in case of disaster, Slack notifications about disasters happening. Highlights most populated regions. Based on testimony of Russell Deffner, HOT activation lead, Disaster Ninja cuts the activation time in half. Less activations happened and they became more focused on resilience rather than response.

Dispatcher 112 - software for the Minsk Fire Service call center dispatch. Helps process calls faster - features city-wide typo-proof search, custom routing engine that lets emergency vehicles plan route better, and data on all the buildings in the city, including address, levels and use.

OpenAerialMap - Kontur conducted big UX research on how the next generation of OAM can look like and is ready to build it based on Kontur Platform.  A prototype was created and is ready for personal demos. We built a live updated global mosaic of the imagery available on OpenAerialMap that enables much better user experience browsing the collection, and suggest to implement better filtering tools like the timeline. 
