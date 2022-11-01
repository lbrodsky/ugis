# PostgreSQL / PostGIS and QGIS installation

### 1. Install PostgreSQL on Windows 

[PostgreSQL](https://www.postgresql.org/) 

Download -> Windows -> Download the installer (e.g. version 15.0) 

Run PostgreSQL installer potgresql-*-windows-x64.exe -> Yes for all defualt settings
-> set password for the server -> Port 5432 -> Default Locale 


Stack Builder is not needed! 

Run PgAdmin to test PostgreSQL server (type password) -> klick Servers (again password for logging to the server)

postgres is defualt database (windo SQL shows the script to create the default database)

Disconnect from database: 'right click' on PostgreSQL -> Disconnect -> Exit 


### 2. Install PostGIS extension within PostgreSQL 

[PostGIS extension](https://postgis.net)

Download installer for respective PostgreSQL server from https://postgis.net/windows_downloads/ 

e.g. http://download.osgeo.org/postgis/windows/pg15/postgis-bundle-pg15x64-setup-3.3.1-2.exe  

Run installer, say Yes for setting the environmental variables. 


#### 2.1 Create DB for your work 

Open PgAmin enter your selected password for the DB. 

Right click on icon Databases and select Create - Database 

Fill-in DB name: e.g. natural_earth and create this DB under user postgres 

Right-click on natural_earth - Extensions - Create - Extension 

Name: PostGIS - Save 


### 3. Install QGIS 

[QGIS](https://qgis.org)

Download now -> run installer 

#### 3.1 Create connection to PostGIS database in QGIS 

Open QGIS and find menu/icon PostGIS (icon with elefant) 

Right-click PostGIS icon and select New connection 

Fill-in: 
- Name: Natural Earth 
- Host: localhost
- Port: 5432
- Database: natural_earth

Ok

- User: postgres
- Password: ***** (your selected password) 

Connection to PostGIS shall exists with default schema public. 

#### 3.2 Import spatial data to PostGIS 

Open menu Databases - DB manager 

Open Icon PostGIS - Natural Earth 

Use icon Import layer / file to import test data 

Select file: e.g. ne_10m_admin_0_countries.shp 

Fill-in: 
Schema: public: 
Name:  ne_10m_admin_0_countrie

Tick: 
Primaery key: id
Geometry: geom
Source SRID: 4326
Target SRID: 4326 
Coding: UTF-8 
Create spatial index: x 

Ok

Test your data: drag the  ne_10m_admin_0_countrie layer and drop it in QGIS Layers. The data shall be viewed in the Map window. 

