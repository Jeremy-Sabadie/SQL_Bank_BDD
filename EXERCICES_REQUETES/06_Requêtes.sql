
-- Affecter à chaque compte comme date d'ouverture, la date de sa première opération

-- opération la plus vielle pour le compte 'LI00000003'
SELECT MIN(dateOpe)
FROM OPERATION
WHERE OPERATION.numCpt = 'LI00000003';


-- opération la plus vielle pour le compte 'CC00000001'
--=====================================================================================================
SELECT MIN(dateOpe)
FROM OPERATION
WHERE OPERATION.numCpt = 'CC00000001';
--=====================================================================================================

UPDATE COMPTE
SET COMPTE.dateOuvCpt = (
							SELECT MIN(dateOpe)
							FROM OPERATION
							WHERE OPERATION.numCpt = 'CC00000001'
						)
WHERE COMPTE.numCpt = 'CC00000001';
--=====================================================================================================



-- Mise à jour date ouverture de tous les comptes
UPDATE COMPTE
SET COMPTE.dateOuvCpt = (
							SELECT MIN(dateOpe)
							FROM OPERATION
							WHERE OPERATION.numCpt = COMPTE.numCpt 
						);
-- WHERE COMPTE.numCpt = 'CC00000001';


							
SELECT *, (SELECT MIN(dateOpe) FROM OPERATION WHERE OPERATION.numCpt = COMPTE.numCpt) as datePremiereOperation
FROM COMPTE;

UPDATE COMPTE
SET COMPTE.dateOuvCpt = (SELECT MIN(dateOpe) FROM OPERATION WHERE OPERATION.numCpt = COMPTE.numCpt);


-- Corriger erreurs des montants sur les dépots: ils sont négatifs il faut les passer en positif
UPDATE OPERATION
SET montantOpe = montantOpe * -1
WHERE codeTypeOpe = 'DEP';
--=====================================================================================================


-- Calculer et affecter à chaque compte son solde 
UPDATE COMPTE
SET soldeCpt= 
(SELECT 
SUM(montantOpe)
FROM OPERATION  
WHERE COMPTE.numCpt=OPERATION.numCpt);
--=====================================================================================================


-- Quel compte a le plus grand nombre d'opérations
SELECT numCpt,count(*)
FROM OPERATION
GROUP BY numCpt
HAVINGcount(*)=
(SELECT count (*)
FROM OPERATION
GROUP BY numCpt
ORDER BY count(*) DESC
	LIMIT 1);
--=====================================================================================================


-- Afficher le solde de tous les comptes au 31/01/2021
SELECT numCpt ,SUM(montantOpe), '31-01-2021' ,'2021-01-31'
FROM OPERATION 
GROUP BY numCpt; 
--=====================================================================================================


-- Afficher tous les mouvements entre le 01/03/2020 et le 30/06/2020
SELECT *
FROM OPERATION
WHERE dateOpe BETWEEN '2020-03-01' AND '2020-06-30'
ORDER BY dateOpe;
--=====================================================================================================


-- Quel(s) client(s) ont le plus gros solde au 31/01/2021
SELECT TITULAIRE.numTit , TITULAIRE.nomTit , SUM(montantOpe)
FROM OPERATION
INNER JOIN COMPTE ON OPERATION.numCpt = COMPTE.numCpt
INNER JOIN TITULAIRE ON COMPTE.numTit = TITULAIRE.numTit
WHERE dateOpe < '2021-02-01'
GROUP BY TITULAIRE.numTit , TITULAIRE.nomTit
ORDER BY SUM(montantOpe) DESC
LIMIT 1;


--=====================================================================================================


-- Enregistrer un dépôt de 1000 sur le compte courant du titulaire n° '00001'
-- 	* recherche du compte courant du titulaire 00001
	SELECT * 
	FROM COMPTE
	WHERE numTit = '00001' AND codeTypeCpt = 'COC';

-- * enregistrement du dépot : opération de dépôt sur le compte
	
-- IL n'est pas autorisé par MYSQL dans une requête de lire une table qui sera modifiée par le trigger
-- On a donc dû utiliser une table temporaire pour stocker le résultat à utiliser

	CREATE TEMPORARY TABLE IF NOT EXISTS TempTableNumCPT AS (SELECT numCpt FROM COMPTE WHERE numTit = '00001' AND codeTypeCpt = 'COC');
	
    SELECT * FROM 	TempTableNumCPT;

	INSERT
	INTO OPERATION
	(description, montantOpe , numCpt, codeTypeOpe)
	VALUES ('Dépôt 1000€ sur le comte', 1000, (SELECT numCpt FROM TempTableNumCPT), 'DEP')
	;

	DROP TABLE TempTableNumCPT;
--=====================================================================================================

-- Enregistrer un virement de 333 du compte CO00000008 vers le compte CO00000002
--=====================================================================================================

-- Le client 00002 quite la banque, il vient fermer tous ses comptes. il faut donc le supprimer de notre Bdd lui et tous ses comptes
--=====================================================================================================







