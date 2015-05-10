CREATE TABLE _dev_energiefoerderung.T_ILI2DB_BASKET (
  T_Id integer PRIMARY KEY
  ,dataset integer NULL
  ,topic varchar(200) NOT NULL
  ,T_Ili_Tid varchar(200) NULL
  ,attachmentKey varchar(200) NOT NULL
)
;
-- Energiefoerderung_V1.Energiefoerderung.Massnahme
CREATE TABLE _dev_energiefoerderung.Massnahme (
  T_Id integer PRIMARY KEY
  ,BeitragIndividuell decimal(10,2) NULL
  ,DatumZusicherung date NOT NULL
  ,DatumAuszahlung date NOT NULL
  ,CO2Einsparung decimal(10,3) NULL
  ,Gebaeude integer NULL
  ,Person integer NULL
)
;
COMMENT ON TABLE _dev_energiefoerderung.Massnahme IS 'Massnahmen, welche von Bund und/oder Kantonen gef�rdert werden, sind vielf�ltig und in unterschiedlichen Bereichen anwendbar. Die Massnahmen sind also nicht zwingend mit einem Geb�ude verkn�pft. Sie sind aber entweder mit einem Geb�ude oder einer Person/Verein/Institution verbunden.
Die Massnahmen enthalten nebst ihren Namen (z.B. ?MINERGIE-P-ECO Wohnbauten?) weitere Attribute. Dazu geh�ren die H�he des F�rderbeitrags mit allf�lligem Beitragsfaktor, das Datum der Erteilung und Auszahlung des Beitrags, die CO2-Einsparung (in Tonnen) der Massnahme und eine Codierung der Massnahme. Die Codierungen bestehen aus einem BFE-Code (Bundesamt f�r Energie, z.B. ?WP1a?) oder aus einem kantonalen Code, welcher aus der Gesuchsnummer (z.B. ?B-14023?) hervorgeht. F�r einige Massnahmen wurden in der Vergangenheit Gesuchsnummern auf kantonaler Ebene verteilt. Diese sind bereits in den Tabellen innerhalb dieses Kapitels eingetragen. Weitere f�rderberechtigte Massnahmen, welche noch keine Gesuchsnummer erhalten haben, bekommen den Platzhalter ?GesuchsNr?. Massnahmen, die kantonal nicht unterst�tzt werden wie beispielsweise der GEAK-Light, erhalten keine Gesuchsnummer, der Wert bleibt einfach leer. Es ist auch m�glich, dass einer Massnahme ein BFE-Code und ein kantonaler Code zugeteilt sind. Zus�tzliche Massnahmen sind in Zukunft denkbar. Die Massnahmen sind nur �bersichtshalber aggregiert und in Unterkapitel aufgeteilt.
Eine Auflistung aller Massnahmen ist in der Modelldokumentation in Kap. 4.3.1/4.3.2. beschrieben.
@iliname Energiefoerderung_V1.Energiefoerderung.Massnahme';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahme.BeitragIndividuell IS 'Individueller Beitrag (bei indirekten Massnahmen)';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahme.DatumZusicherung IS 'Datum der Zusicherung des F�rderbeitrags';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahme.DatumAuszahlung IS 'Datum der Auszahlung des F�rderbeitrags';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahme.CO2Einsparung IS 'CO2-Einsparung pro Jahr in Tonnen; Kann nicht bei allen Massnahmen quantifiziert werden, wie beispielsweise die Weiterbildung einer Person.';
CREATE TABLE _dev_energiefoerderung.T_ILI2DB_IMPORT (
  T_Id integer PRIMARY KEY
  ,dataset integer NOT NULL
  ,importDate timestamp NOT NULL
  ,importUser varchar(40) NOT NULL
  ,importFile varchar(200) NOT NULL
)
;
CREATE TABLE _dev_energiefoerderung.T_ILI2DB_CLASSNAME (
  IliName varchar(1024) PRIMARY KEY
  ,SqlName varchar(1024) NOT NULL
)
;
CREATE TABLE _dev_energiefoerderung.T_ILI2DB_IMPORT_OBJECT (
  T_Id integer PRIMARY KEY
  ,import_basket integer NOT NULL
  ,class varchar(200) NOT NULL
  ,objectCount integer NULL
  ,start_t_id integer NULL
  ,end_t_id integer NULL
)
;
-- Energiefoerderung_V1.Energiefoerderung.Gebaeude
CREATE TABLE _dev_energiefoerderung.Gebaeude (
  T_Id integer PRIMARY KEY
  ,EGID integer NOT NULL
  ,BaujahrGeb integer NOT NULL
  ,AnzWohneinheiten integer NOT NULL
  ,Heizsystem varchar(255) NULL
  ,Heizleistung decimal(13,3) NULL
  ,EBF decimal(13,3) NULL
)
;
SELECT AddGeometryColumn('_dev_energiefoerderung','gebaeude','geometrie',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
CREATE INDEX gebaeude_geometrie_idx ON _dev_energiefoerderung.gebaeude USING GIST ( geometrie );
COMMENT ON TABLE _dev_energiefoerderung.Gebaeude IS 'Der grosse Teil des Massnahmenkatalogs hat einen Bezug zu einem Geb�ude und nicht zu einer Person. Diese geb�udeverkn�pften Massnahmen haben einen direkten Nutzen. Dazu geh�ren beispielsweise Geb�udesanierungen, Verbesserungen an Einzelbauteilen oder Massnahmen an Anlagen zur Energie- und W�rmeerzeugung. Zugeh�rig sind Attribute zur eindeutigen Lokalisierung und zu den Eigenheiten des Geb�udes. Dargestellt werden die Geb�ude als Fl�che (Geb�udeumrisse).
@iliname Energiefoerderung_V1.Energiefoerderung.Gebaeude';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.EGID IS 'Eidgen�ssischer Geb�udeidentifikator - Die EGID-Nummer ist eine 6- bis 9-stellige Zahl, die in der ganzen Schweiz eindeutig ist. Neu vergebene EGID sind 9-stellig.';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.BaujahrGeb IS 'Baujahr des Geb�udes';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.AnzWohneinheiten IS 'Anzahl Wohneinheiten im Geb�ude';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.Heizsystem IS 'Heizsystem/Energietr�ger im Geb�ude, z.B. �l, Holz etc.; bei zahlreichen Massnahmen keine geforderte Angabe';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.Heizleistung IS 'Heizleistung des Systems in KiloWatt (kW); bei zahlreichen Massnahmen keine geforderte Angabe';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.EBF IS 'Energiebezugsfl�che (EBF) in m2 ; bei zahlreichen Massnahmen keine geforderte Angabe';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.Geometrie IS 'Geb�udefl�che aus der amtlichen Vermessung';
CREATE TABLE _dev_energiefoerderung.T_ILI2DB_MODEL (
  file varchar(250) NOT NULL
  ,iliversion varchar(3) NOT NULL
  ,modelName text NOT NULL
  ,content text NOT NULL
  ,importDate timestamp NOT NULL
  ,PRIMARY KEY (modelName,iliversion)
)
;
-- Energiefoerderung_V1.Energiefoerderung_Kataloge.Gebaeudekategorie
CREATE TABLE _dev_energiefoerderung.Gebaeudekategorie (
  T_Id integer PRIMARY KEY
  ,Kategorie integer NOT NULL
  ,Name varchar(255) NOT NULL
)
;
COMMENT ON TABLE _dev_energiefoerderung.Gebaeudekategorie IS 'Katalog der Geb�udekategorien
@iliname Energiefoerderung_V1.Energiefoerderung_Kataloge.Gebaeudekategorie';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeudekategorie.Kategorie IS 'Nummer der Geb�udekategorie';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeudekategorie.Name IS 'Bezeichnung der Geb�udekategorie';
-- Energiefoerderung_V1.Energiefoerderung_Kataloge.Massnahmenkatalog
CREATE TABLE _dev_energiefoerderung.Massnahmenkatalog (
  T_Id integer PRIMARY KEY
  ,"Name" varchar(255) NOT NULL
  ,KantCode varchar(20) NULL
  ,BFECode varchar(20) NULL
  ,Beitrag decimal(10,2) NOT NULL
  ,BeitragFaktor decimal(4,2) NOT NULL
  ,Jahr decimal(4,0) NOT NULL
  ,Kategorie integer NOT NULL
  ,Kategorie_txt varchar(255) NOT NULL
)
;
COMMENT ON TABLE _dev_energiefoerderung.Massnahmenkatalog IS 'Katalog der Massnahmen. �KantCode OR BFECode� muss definiert sein.
@iliname Energiefoerderung_V1.Energiefoerderung_Kataloge.Massnahmenkatalog';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog."Name" IS 'Name/Bezeichnung der Massnahme im Katalog';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.KantCode IS 'Kantonaler Code wird anhand der Gesuchsnummer vergeben, z.B. �B-14023� f�r Beleuchtung 2014 mit Laufnummer 23';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.BFECode IS 'Code vergeben durch das Bundesamt f�r Energie (BFE), z.B. �WP1a� f�r W�rmepumpen einer bestimmten Kategorie';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.Beitrag IS 'H�he des F�rderbeitrages in Schweizer Franken';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.BeitragFaktor IS 'Faktor zum Grundf�rderbeitrag';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.Jahr IS 'Bezugsjahr f�r die Beitr�ge der Massnahme. Die Beitr�ge der entsprechenden Massnahme gelten jeweils ab 1. Januar';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.Kategorie IS 'Kategorisierung der Massnahme: Geb�udebezogen oder Personen/Verein/Institutionsbezogen';
CREATE TABLE _dev_energiefoerderung.T_ILI2DB_INHERITANCE (
  thisClass varchar(60) PRIMARY KEY
  ,baseClass varchar(60) NULL
)
;
-- CatalogueObjects_V1.Catalogues.CatalogueReference
CREATE TABLE _dev_energiefoerderung.CatalogueReference (
  T_Id integer PRIMARY KEY
  ,T_Type varchar(60) NOT NULL
  ,T_ParentId integer NOT NULL
  ,T_ParentType varchar(60) NOT NULL
  ,T_ParentAttr varchar(60) NOT NULL
  ,T_Seq integer NOT NULL
  ,Reference integer NULL
)
;
COMMENT ON TABLE _dev_energiefoerderung.CatalogueReference IS '@iliname CatalogueObjects_V1.Catalogues.CatalogueReference';
CREATE TABLE _dev_energiefoerderung.T_ILI2DB_IMPORT_BASKET (
  T_Id integer PRIMARY KEY
  ,import integer NOT NULL
  ,basket integer NOT NULL
  ,objectCount integer NULL
  ,start_t_id integer NULL
  ,end_t_id integer NULL
)
;
-- CatalogueObjects_V1.Catalogues.Item
CREATE TABLE _dev_energiefoerderung.Item (
  T_Id integer PRIMARY KEY
  ,T_Type varchar(60) NOT NULL
)
;
COMMENT ON TABLE _dev_energiefoerderung.Item IS '@iliname CatalogueObjects_V1.Catalogues.Item';
-- Energiefoerderung_V1.Energiefoerderung_Kataloge.MassnahmeRef
CREATE TABLE _dev_energiefoerderung.MassnahmeRef (
  T_Id integer PRIMARY KEY
)
;
COMMENT ON TABLE _dev_energiefoerderung.MassnahmeRef IS 'Referenzierungsstruktur f�r die Zuweisung der Geb�udekategorie zu den Geb�uden
@iliname Energiefoerderung_V1.Energiefoerderung_Kataloge.MassnahmeRef';
-- Energiefoerderung_V1.Energiefoerderung.Person_Verein_Institution
CREATE TABLE _dev_energiefoerderung.Person_Verein_Institution (
  T_Id integer PRIMARY KEY
  ,Name varchar(255) NOT NULL
  ,Vorname varchar(255) NULL
  ,StrasseUndNr varchar(255) NOT NULL
  ,PLZ integer NOT NULL
  ,Ort varchar(255) NOT NULL
  ,TelefonNr varchar(13) NULL
  ,EMail varchar(255) NULL
)
;
COMMENT ON TABLE _dev_energiefoerderung.Person_Verein_Institution IS 'Massnahmen, welche nicht mit einem Geb�ude verkn�pft sind, sind zwingend mit einer Person, einem Verein oder einer Institution verbunden. Dazu geh�ren Massnahmen mit einem indirekten Nutzen (z.B. F�rderbeitr�ge f�r eine Weiterbildung oder eine Machbarkeitsstudie) und Massnahmen im Bereich der Mobilit�t (F�rdergelder f�r Elektrobikes). Als Attribute dienen hier der Name (bei Personen der Vor- und Nachname), sowie der Wohnsitz der Person/Verein/Institution (Strasse, Hausnummer, PLZ, Ort). Es darf vorkommen, dass eine Person/Verein/Institution von mehreren unterschiedlichen Massnahmen profitiert.
@iliname Energiefoerderung_V1.Energiefoerderung.Person_Verein_Institution';
COMMENT ON COLUMN _dev_energiefoerderung.Person_Verein_Institution.Name IS 'Bei �Person� der Familienname, bei anderen der Name des Vereins bzw. der Institution';
COMMENT ON COLUMN _dev_energiefoerderung.Person_Verein_Institution.Vorname IS 'Vorname nur bei Personen erforderlich';
COMMENT ON COLUMN _dev_energiefoerderung.Person_Verein_Institution.StrasseUndNr IS 'Adressteil Strasse und Hausnummer';
COMMENT ON COLUMN _dev_energiefoerderung.Person_Verein_Institution.PLZ IS 'Adressteil Postleitzahl';
COMMENT ON COLUMN _dev_energiefoerderung.Person_Verein_Institution.Ort IS 'Adressteil Ortschaft';
COMMENT ON COLUMN _dev_energiefoerderung.Person_Verein_Institution.TelefonNr IS 'Telefonnummer der Kontaktperson';
COMMENT ON COLUMN _dev_energiefoerderung.Person_Verein_Institution.EMail IS 'E-Mail-Adresse der Kontaktperson';
CREATE TABLE _dev_energiefoerderung.T_ILI2DB_DATASET (
  T_Id integer PRIMARY KEY
)
;
-- Energiefoerderung_V1.Energiefoerderung_Kataloge.GebaeudekategorieRef
CREATE TABLE _dev_energiefoerderung.GebaeudekategorieRef (
  T_Id integer PRIMARY KEY
)
;
COMMENT ON TABLE _dev_energiefoerderung.GebaeudekategorieRef IS 'Referenzierungsstruktur f�r die Zuweisung der Geb�udekategorie zu den Geb�uden
@iliname Energiefoerderung_V1.Energiefoerderung_Kataloge.GebaeudekategorieRef';
CREATE TABLE _dev_energiefoerderung.T_KEY_OBJECT (
  T_Key varchar(30) PRIMARY KEY
  ,T_LastUniqueId integer NOT NULL
  ,T_LastChange timestamp NOT NULL
  ,T_CreateDate timestamp NOT NULL
  ,T_User varchar(40) NOT NULL
)
;
CREATE TABLE _dev_energiefoerderung.T_ILI2DB_SETTINGS (
  tag varchar(60) PRIMARY KEY
  ,setting varchar(60) NULL
)
;
CREATE TABLE _dev_energiefoerderung.T_ILI2DB_ATTRNAME (
  IliName varchar(1024) PRIMARY KEY
  ,SqlName varchar(1024) NOT NULL
)
;
