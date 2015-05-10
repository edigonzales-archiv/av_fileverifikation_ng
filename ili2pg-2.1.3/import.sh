java -jar ili2pg.jar --schemaimport --dbhost localhost --dbport 5432 --dbdatabase xanadu --dbschema av_file_verification --dbusr stefan --dbpwd ziegler12  --models File_Verification_V1 --modeldir . --createGeomIdx --nameByTopic --strokeArcs 



***************




java -jar ili2pg.jar --import --dbhost localhost --dbport 5432 --dbdatabase xanadu --dbschema zdatso10_ngoesg --dbusr stefan --dbpwd ziegler12 --modeldir http://www.catais.org/models --models Zonendaten_SO_10 --createGeomIdx --createEnumTxtCol --nameByTopic --strokeArcs /home/stefan/Dropbox/Projects/MGDM/nplso/Zonendaten_SO_09/daten/niedergoesgen/Daten_Niedergoe_030912_v10.ITF

java -jar ili2pg.jar --import --dbhost localhost --dbport 5432 --dbdatabase xanadu --dbschema zdatso10_bruegglen--dbusr stefan --dbpwd ziegler12 --modeldir http://www.catais.org/models --models Zonendaten_SO_10 --createGeomIdx --createEnumTxtCol --nameByTopic --strokeArcs /home/stefan/Dropbox/Projects/MGDM/nplso/Zonendaten_SO_09/daten/bruegglen/brue20060807_v10.itf

java -jar ili2pg.jar --import --dbhost localhost --dbport 5432 --dbdatabase xanadu --dbschema zdatso10_kappel --dbusr stefan --dbpwd ziegler12 --modeldir http://www.catais.org/models --models Zonendaten_SO_10 --createGeomIdx --createEnumTxtCol --nameByTopic --strokeArcs /home/stefan/Dropbox/Projects/MGDM/nplso/Zonendaten_SO_09/daten/kappel/kappel.itf


java -jar ili2pg.jar --schemaimport --dbhost localhost --dbport 5432 --dbdatabase xanadu --dbschema nplch_kappel --dbusr stefan --dbpwd ziegler12 --models Nutzungsplanung_V1 --createGeomIdx --nameByTopic --strokeArcs 






















