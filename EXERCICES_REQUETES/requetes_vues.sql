-- OAI – Vues:

-- Q1 - Créer une vue appelée EMP_VU comprenant le numéro d’employé, le nom, le numéro de département de la table EMP. Afficher le contenu de cette vue.
--Création de la vue:
CREATE  OR REPLACE VIEW EMP_VU
as
SELECT empno,Ename,DEPTNO
FROM EMP;
-- ================================Affichage de la vue:
SELECT *
FROM EMP_VU;
--================================================================================================================================

-- Q2 - En utilisant la vue EMP_VU, créer une requête pour afficher les noms et les numéros de département de tous les employés.
SELECT ENAME,DEPTNO
FROM EMP_VU;
--=======================================================================================================================
-- Q3 - Créer une vue DEPT_VU montrant tous les départements avec le numéro de département, le nom du département, le nombre d’employés du département. Afficher le contenu de cette vue.
CREATE  OR REPLACE VIEW DEPT_VU
as
SELECT d.DNAME,d.DEPTNO, COUNT(*) 
FROM DEPT d  INNER JOIN EMP e ON d.DEPTNO =e.DEPTNO
GROUP BY DEPTNO;
SELECT *
FROM DEPT_VU; 
--=======================================================================================================================
-- Q4 - Créer une vue SALGRADE_VU montrant tous les employés avec leur numéro, leur nom, leur salaire, leur poste et leur grade. En utilisant la vue SALGRADE_VU, compter le nombre d’employés par grade.
CREATE or REPLACE VIEW SALGRADE_VU as    
select EMPNO , ENAME , SAL , JOB , GRADE
    FROM EMP e
    JOIN SALGRADE ON e.SAL BETWEEN LOSAL AND HISAL;
 -- aFFICHAGE:  
SELECT GRADE, COUNT(EMPNO)
from SALGRADE_VU
group by GRADE;
--=======================================================================================================================
-- Q5 – Créer une vue DEPT20_VU qui contiendra le numéro, le nom et le numéro de département de tous les employés du département 20.Interdire de modifier la colonne numéro de département à partir de cette vue. Afficher le contenu de la vue DEPT20_VU. Tenter de modifier le numéro de département de l‘employé SMITH (nouvelle valeur 30).
CREATE OR REPLACE VIEW DEPT20_VU AS
	SELECT EMPNO, ENAME, DEPTNO
	FROM EMP
	WHERE DEPTNO = 20;

-- version interdisant de modifier le numéro de département
CREATE OR REPLACE VIEW DEPT20_VU AS
	SELECT EMPNO, ENAME, DEPTNO
	FROM EMP
	WHERE DEPTNO = 20
	WITH CHECK OPTION;

SELECT * FROM DEPT20_VU;

UPDATE DEPT20_VU 
SET DEPTNO = 30;
--=======================================================================================================================