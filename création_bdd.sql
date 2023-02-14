CREATE DATABASE IF NOT EXISTS BANQUE; 
USE BANQUE;

DROP TABLE if exists TYPE_COMPTE;
DROP TABLE if exists COMPTE;
DROP TABLE if exists TITULAIRE;
DROP TABLE if exists OPERATION;
DROP TABLE if exists TYPE_OPERATION;

-- ============================================================
--   Table :TYPE_COMPTE                                       
-- ============================================================
create table TYPE_COMPTE
(   LIBELLE_CPT varchar(30),   
    CODE_TYPE_CPT   VARCHAR(3),
    primary key(CODE_TYPE_CPT)
);
    
-- ============================================================
--   Table :COMPTE                                       
-- ============================================================
create table COMPTE
(  NUMERO_CPT varchar(10),
   DATE_OUVERTURE_CPT date,
   CODE_TYPE_CPT VARCHAR(3),
   SOLDE_CPT decimal(7,2),
   NUM_TIT varchar(5),
   primary key(NUMERO_CPT)
);
   
-- ============================================================
--   Table :TITULAIRE                                       
-- ============================================================
create table TITULAIRE
(  NUM_TIT varchar(5),
   NOM_TIT varchar(40),
   ADRESSE_TIT varchar(60),
   primary key (NUM_TIT)
);

-- ============================================================
--   Table :OPERATION                                       
-- ============================================================
create table OPERATION
(  NUM_OP int,
   DATE_OP datetime,
   MONTANT_OP decimal(7,2),
   NUMERO_CPT varchar(10),
   CODE_TYPE_OP varchar(3),
   primary key(NUM_OP)
   
);

-- ============================================================
--   Table :TYPE_OPERATION                                       
-- ============================================================
create table TYPE_OPERATION
(  LIBELLE_TYPE_OP varchar(30),
   CODE_TYPE_OP varchar(3),
   primary key(CODE_TYPE_OP)
);


alter table COMPTE
add constraint CODE_TYPE_CPT  foreign key(CODE_TYPE_CPT) references TYPE_COMPTE(CODE_TYPE_CPT);

alter table COMPTE
add constraint NUM_TIT  foreign key(NUM_TIT) references TITULAIRE(NUM_TIT);

alter table OPERATION
add constraint CODE_TYPE_OP  foreign key(CODE_TYPE_OP) references TYPE_OPERATION(CODE_TYPE_OP);

alter table OPERATION
add constraint NUMERO_CPT  foreign key(NUMERO_CPT) references COMPTE(NUMERO_CPT);
