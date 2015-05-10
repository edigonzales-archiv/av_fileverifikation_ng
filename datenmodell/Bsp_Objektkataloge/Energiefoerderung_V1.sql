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
COMMENT ON TABLE _dev_energiefoerderung.Massnahme IS 'Massnahmen, welche von Bund und/oder Kantonen gefördert werden, sind vielfältig und in unterschiedlichen Bereichen anwendbar. Die Massnahmen sind also nicht zwingend mit einem Gebäude verknüpft. Sie sind aber entweder mit einem Gebäude oder einer Person/Verein/Institution verbunden.
Die Massnahmen enthalten nebst ihren Namen (z.B. ?MINERGIE-P-ECO Wohnbauten?) weitere Attribute. Dazu gehören die Höhe des Förderbeitrags mit allfälligem Beitragsfaktor, das Datum der Erteilung und Auszahlung des Beitrags, die CO2-Einsparung (in Tonnen) der Massnahme und eine Codierung der Massnahme. Die Codierungen bestehen aus einem BFE-Code (Bundesamt für Energie, z.B. ?WP1a?) oder aus einem kantonalen Code, welcher aus der Gesuchsnummer (z.B. ?B-14023?) hervorgeht. Für einige Massnahmen wurden in der Vergangenheit Gesuchsnummern auf kantonaler Ebene verteilt. Diese sind bereits in den Tabellen innerhalb dieses Kapitels eingetragen. Weitere förderberechtigte Massnahmen, welche noch keine Gesuchsnummer erhalten haben, bekommen den Platzhalter ?GesuchsNr?. Massnahmen, die kantonal nicht unterstützt werden wie beispielsweise der GEAK-Light, erhalten keine Gesuchsnummer, der Wert bleibt einfach leer. Es ist auch möglich, dass einer Massnahme ein BFE-Code und ein kantonaler Code zugeteilt sind. Zusätzliche Massnahmen sind in Zukunft denkbar. Die Massnahmen sind nur übersichtshalber aggregiert und in Unterkapitel aufgeteilt.
Eine Auflistung aller Massnahmen ist in der Modelldokumentation in Kap. 4.3.1/4.3.2. beschrieben.
@iliname Energiefoerderung_V1.Energiefoerderung.Massnahme';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahme.BeitragIndividuell IS 'Individueller Beitrag (bei indirekten Massnahmen)';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahme.DatumZusicherung IS 'Datum der Zusicherung des Förderbeitrags';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahme.DatumAuszahlung IS 'Datum der Auszahlung des Förderbeitrags';
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
COMMENT ON TABLE _dev_energiefoerderung.Gebaeude IS 'Der grosse Teil des Massnahmenkatalogs hat einen Bezug zu einem Gebäude und nicht zu einer Person. Diese gebäudeverknüpften Massnahmen haben einen direkten Nutzen. Dazu gehören beispielsweise Gebäudesanierungen, Verbesserungen an Einzelbauteilen oder Massnahmen an Anlagen zur Energie- und Wärmeerzeugung. Zugehörig sind Attribute zur eindeutigen Lokalisierung und zu den Eigenheiten des Gebäudes. Dargestellt werden die Gebäude als Fläche (Gebäudeumrisse).
@iliname Energiefoerderung_V1.Energiefoerderung.Gebaeude';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.EGID IS 'Eidgenössischer Gebäudeidentifikator - Die EGID-Nummer ist eine 6- bis 9-stellige Zahl, die in der ganzen Schweiz eindeutig ist. Neu vergebene EGID sind 9-stellig.';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.BaujahrGeb IS 'Baujahr des Gebäudes';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.AnzWohneinheiten IS 'Anzahl Wohneinheiten im Gebäude';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.Heizsystem IS 'Heizsystem/Energieträger im Gebäude, z.B. Öl, Holz etc.; bei zahlreichen Massnahmen keine geforderte Angabe';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.Heizleistung IS 'Heizleistung des Systems in KiloWatt (kW); bei zahlreichen Massnahmen keine geforderte Angabe';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.EBF IS 'Energiebezugsfläche (EBF) in m2 ; bei zahlreichen Massnahmen keine geforderte Angabe';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeude.Geometrie IS 'Gebäudefläche aus der amtlichen Vermessung';
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
COMMENT ON TABLE _dev_energiefoerderung.Gebaeudekategorie IS 'Katalog der Gebäudekategorien
@iliname Energiefoerderung_V1.Energiefoerderung_Kataloge.Gebaeudekategorie';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeudekategorie.Kategorie IS 'Nummer der Gebäudekategorie';
COMMENT ON COLUMN _dev_energiefoerderung.Gebaeudekategorie.Name IS 'Bezeichnung der Gebäudekategorie';
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
COMMENT ON TABLE _dev_energiefoerderung.Massnahmenkatalog IS 'Katalog der Massnahmen. «KantCode OR BFECode» muss definiert sein.
@iliname Energiefoerderung_V1.Energiefoerderung_Kataloge.Massnahmenkatalog';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog."Name" IS 'Name/Bezeichnung der Massnahme im Katalog';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.KantCode IS 'Kantonaler Code wird anhand der Gesuchsnummer vergeben, z.B. «B-14023» für Beleuchtung 2014 mit Laufnummer 23';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.BFECode IS 'Code vergeben durch das Bundesamt für Energie (BFE), z.B. «WP1a» für Wärmepumpen einer bestimmten Kategorie';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.Beitrag IS 'Höhe des Förderbeitrages in Schweizer Franken';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.BeitragFaktor IS 'Faktor zum Grundförderbeitrag';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.Jahr IS 'Bezugsjahr für die Beiträge der Massnahme. Die Beiträge der entsprechenden Massnahme gelten jeweils ab 1. Januar';
COMMENT ON COLUMN _dev_energiefoerderung.Massnahmenkatalog.Kategorie IS 'Kategorisierung der Massnahme: Gebäudebezogen oder Personen/Verein/Institutionsbezogen';
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
COMMENT ON TABLE _dev_energiefoerderung.MassnahmeRef IS 'Referenzierungsstruktur für die Zuweisung der Gebäudekategorie zu den Gebäuden
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
COMMENT ON TABLE _dev_energiefoerderung.Person_Verein_Institution IS 'Massnahmen, welche nicht mit einem Gebäude verknüpft sind, sind zwingend mit einer Person, einem Verein oder einer Institution verbunden. Dazu gehören Massnahmen mit einem indirekten Nutzen (z.B. Förderbeiträge für eine Weiterbildung oder eine Machbarkeitsstudie) und Massnahmen im Bereich der Mobilität (Fördergelder für Elektrobikes). Als Attribute dienen hier der Name (bei Personen der Vor- und Nachname), sowie der Wohnsitz der Person/Verein/Institution (Strasse, Hausnummer, PLZ, Ort). Es darf vorkommen, dass eine Person/Verein/Institution von mehreren unterschiedlichen Massnahmen profitiert.
@iliname Energiefoerderung_V1.Energiefoerderung.Person_Verein_Institution';
COMMENT ON COLUMN _dev_energiefoerderung.Person_Verein_Institution.Name IS 'Bei «Person» der Familienname, bei anderen der Name des Vereins bzw. der Institution';
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
COMMENT ON TABLE _dev_energiefoerderung.GebaeudekategorieRef IS 'Referenzierungsstruktur für die Zuweisung der Gebäudekategorie zu den Gebäuden
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
