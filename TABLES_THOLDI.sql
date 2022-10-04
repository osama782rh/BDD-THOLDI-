CREATE TABLE pays(
codePays char(2) NOT NULL,
nomPays char (30),
CONSTRAINT pk_codeP PRIMARY KEY (CodePays)
)
engine = innodb;


CREATE TABLE utilisateur (
code smallint(6) NOT NULL AUTO_INCREMENT,
role varchar (10) NOT NULL,
raisonSociale char(50) NOT NULL,
adresse char(80) NOT NULL,
cp char (5) NOT NULL,
ville char (40) NOT NULL,
adrMel char (100) NOT NULL,
telephone char (15) NOT NULL,
contact  char (50) NOT NULL,
login char (10) NOT NULL,
mdp char (10) NOT NULL,
codePays char (2) NOT NULL,
CONSTRAINT pk_code PRIMARY KEY (code),
CONSTRAINT fk_codeP FOREIGN KEY (codePays) REFERENCES pays (codePays)
)
engine = innodb;


CREATE TABLE ville(
codeVille INT(6) NOT NULL AUTO_INCREMENT,
nomVille char (30) NOT NULL,
codePays char (4) NOT NULL,
CONSTRAINT pk_codeV PRIMARY KEY (codeVille),
CONSTRAINT fk_codePa FOREIGN KEY (codePays) REFERENCES pays (codePays)
)
engine = innodb;


CREATE TABLE duree (
codeD varchar (20) NOT NULL,
nbJours int (6) NOT NULL,
CONSTRAINT pk_Dure PRIMARY KEY(codeD)
)
engine = innodb;


CREATE TABLE typeContainer(
numTypeContainer INT(6) NOT NULL AUTO_INCREMENT,
codeTypeContainer char (4) NOT NULL,
libelleTypeContainer char (50) NOT NULL,
longueurCont decimal (5) NOT NULL,
largeurCont decimal (5) NOT NULL,
hauteurCont decimal (4) NOT NULL,
poidsCont decimal (5),
tare decimal (4),
capaciteDeCharge decimal (8,2),
CONSTRAINT pk_Type PRIMARY KEY(numTypeContainer)
)
engine = innodb;


CREATE TABLE tarificationContainer (
codeDuree varchar (20) NOT NULL,
numTypeContainer int(6) NOT NULL,
tarif decimal (10,2),
CONSTRAINT pk_Reserv PRIMARY KEY(codeDuree, numTypeContainer),
CONSTRAINT fk_Type FOREIGN KEY(numTypeContainer)REFERENCES typeContainer (numTypeContainer),
CONSTRAINT fk_Dure FOREIGN KEY (codeDuree)REFERENCES duree(codeD)
)
engine = innodb;


CREATE TABLE devis(
codeDevis int(9) NOT NULL AUTO_INCREMENT,
dateDevis varchar(20),
montantDevis decimal(6,2),
volume int(4),
nbcontainers int(11),
valider smallint(1) NOT NULL ,
CONSTRAINT pk_Devi PRIMARY KEY(codeDevis)
)
engine = innodb;


CREATE TABLE reservation(
codeReservation int (15) NOT NULL AUTO_INCREMENT,
dateDebutReservation varchar(20),
datefinReservation varchar(20),
dateReservation datetime NULL DEFAULT CURRENT_TIMESTAMP,
volumeEstime decimal(4),
codeDevis int(9),
codeVilleMiseDisposition int (6) NOT NULL,
codeVilleRendre int (6) NOT NULL,
codeUtilisateur smallint (6) NOT NULL,
numeroDeReservation int (11),
etat char (10),
CONSTRAINT pk_Rese PRIMARY KEY(codeReservation),
CONSTRAINT fk_Devi FOREIGN KEY(codeDevis) REFERENCES devis(codeDevis),
CONSTRAINT fk_Vill FOREIGN KEY(codeVilleMiseDisposition) REFERENCES ville(codeVille),
CONSTRAINT fk_Vill1 FOREIGN KEY(codeVilleRendre) REFERENCES ville(CodeVille),
CONSTRAINT fk_codeU FOREIGN KEY(codeUtilisateur) REFERENCES utilisateur(code)
)
engine = innodb;


create table reserver(
codeReservation int (15) NOT NULL,
numTypeContainer int(6) NOT NULL,
qteReserverint(100),
CONSTRAINT pk_Reserv PRIMARY KEY(codeReservation, numTypeContainer),
CONSTRAINT fk_Rese FOREIGN KEY(codeReservation)REFERENCES reservation (codeReservation),
CONSTRAINT fk_Typei FOREIGN KEY(numTypeContainer)REFERENCES typeContainer(numTypeContainer)
)
engine = innodb;