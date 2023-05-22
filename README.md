# MDP-SQL-POSTGRES-DOCKER

## Modélisation BDD 

![Capture d’écran 2023-05-22 à 23 32 47](https://github.com/Benedct-Laurain/MDP-SQL-POSTGRES/assets/92828220/5b2e7df7-c54f-49bb-8c87-4d5ae852de1f)

## Postgres avec Docker 

```
docker pull postgres

docker run --name postgres -p 5455:5432 -e POSTGRES_PASSWORD=PASSWORD -d postgres

docker exec -it postgres psql -U postgres
```

Commandes utiles psql:
- `\c` : database connection
- `\l` : List of databases
- `\dn+`: List of schemas
- `\dt job_board.*`:  détail schema
- `exit`

## Script SQL pour la création des tables et l'insertion des données 



## Exercices

***Écris les requêtes SQL permettant d'obtenir les données suivantes :***

- Toutes les offres d'emploi
```
SELECT * FROM job_board.job_offer;
```
| job_offer_id | uuid | title | description | city | recruiter_id |
| ------------ | ---- | ----- | ------------ | --- | ------- |
| 1 | 2232 aaf9 -9 fb6 -45 dc -803 a -1 aabdb88b132 | job 1 | Je suis le job 1 | Paris | 17 f6f1c9 - d44d -42 d5 - bc9a - b103164e1346 |
| 2 | 060 af6bf -8 ae8 -4 b92 -9499 -99 a09b39e5c1 | job 2 | Je suis le job 2 | Paris | 17 f6f1c9 - d44d -42 d5 - bc9a - b103164e1346 |
|3 | 709 a31c6 - a7ce -4838 - a3a0 - c027c4ce7925 | job 3 | Je suis le job 3 | Tours | 17 f6f1c9 - d44d -42 d5 - bc9a - b103164e1346 |
|4 | 0 ef722ba - dc88 -4 baa - be9d - b9b4b8b4d17a | job 4 | Je suis le job 4 | Tours | cd5c84d6 -2494 -42 d5 - bcfb -4 a1d99dfdf6a |
|5 | 592 cf3fa -8 b6b -4 a1e - b3b1 -608 f5ab0d3c0 | job 5 | Je suis le job 5 | Nice | cd5c84d6 -2494 -42 d5 - bcfb -4 a1d99dfdf6a |
|6 | 5 b6fcf56 -940 c -4 a19 -9962 -04763839 a180 | job 6 | Je suis le job 6 | Lyon | c171233e -049 b -4 ebd - bd8e - df18621eb596 |
|7 | b56fd465 -90 b8 -4 f30 - ab07 -5 d1fb0154956 | job 7 | Je suis le job 7 | Bordeaux | c171233e -049 b -4 ebd - bd8e - df18621eb596 |
(7 rows) 

- Toutes les offres d'emploi d'une ville (Paris)
```
SELECT *
FROM job_board.job_offer
WHERE city = 'Paris';
```
|job_offer_id | uuid | title | description | city | recruiter_id |
| ----------- | ---- | --- | -------- | ----- | ---------- |
| 1 | 2232 aaf9 -9 fb6 -45 dc -803 a -1 aabdb88b132 | job 1 | Je suis le job 1 | Paris | 17 f6f1c9 - d44d -42 d5 - bc9a - b103164e1346 |
| 2 | 060 af6bf -8 ae8 -4 b92 -9499 -99 a09b39e5c1 | job 2 | Je suis le job 2 | Paris | 17 f6f1c9 - d44d -42 d5 - bc9a - b103164e1346 |
(2 rows)

- Les informations de tous candidats qui ont postulé à une offre précise
```
SELECT jo.title, c.*
FROM candidate c
    JOIN candidate_has_job_offer cj ON c.uuid = cj.candidate_id
    JOIN job_offer jo ON jo.uuid = cj.job_offer_id
WHERE jo.title = 'job 1';
```
| title | candidate_id | uuid | firstname | lastname | email | phone | presentation | disabled |
| ---- | --- | --- | ---- | ---- | ---- | ---- | ----- | ---- |
| job 1 | 1 | 4649605 c -6 cfb -4829 - a033 - ce1a7fa06e45 | candidate1 | lastname1 | candidate1 @gmail.com | 0606060606 | Je suis le candidat 1 | f|
| job 1 | 2 | c09e93c0 -1980 -4 a13 -9797 -581539 f33d96 | candidate2 | lastname2 | candidate2 @gmail.com | 0606060606 | Je suis le candidat 2 | f |
|job 1 | 3 | 97142 cea - c071 -4 c7d - a979 -7075 f7e3459e | candidate3 | lastname3 | candidate3 @gmail.com | 0606060606 | Je suis le candidat 3 | f |
(3 rows)

- Les informations de tous les candidats qui ont postulé aux offres d'une entreprise
```
SELECT jo.title, c.*
FROM candidate c
    JOIN candidate_has_job_offer cj ON c.uuid = cj.candidate_id
    JOIN job_offer jo ON jo.uuid = cj.job_offer_id
    JOIN recruiter r ON r.uuid = jo.recruiter_id
WHERE
    r.company_name = 'company1';
```
ou
```
SELECT jo.title, c.*
FROM candidate c
    JOIN candidate_has_job_offer cj ON c.uuid = cj.candidate_id
    JOIN job_offer jo ON jo.uuid = cj.job_offer_id
WHERE
    jo.recruiter_id = '17f6f1c9-d44d-42d5-bc9a-b103164e1346';
```

| title | candidate_id | uuid | firstname | lastname | email | phone | presentation | disabled |
| --- | --- | ---- | ---- | --- | ---- | ---- | ---- | ---- |
| job 1 | 1 | 4649605 c -6 cfb -4829 - a033 - ce1a7fa06e45 | candidate1 | lastname1 | candidate1 @gmail.com | 0606060606 | Je suis le candidat 1 | f |
| job 1 | 3 | 97142 cea - c071 -4 c7d - a979 -7075 f7e3459e | candidate3 | lastname3 | candidate3 @gmail.com | 0606060606 | Je suis le candidat 3 | f |
| job 1 | 2 | c09e93c0 -1980 -4 a13 -9797 -581539 f33d96 | candidate2 | lastname2 | candidate2 @gmail.com | 0606060606 | Je suis le candidat 2 | f |
| job 3 | 3 | 97142 cea - c071 -4 c7d - a979 -7075 f7e3459e | candidate3 | lastname3 | candidate3 @gmail.com | 0606060606 | Je suis le candidat 3 | f |
(4 rows) 

- Modifier le numéro de téléphone et le texte de présentation d'un candidat
```
UPDATE candidate
SET
    phone = '0707070707',
    presentation = 'présentation modifiée!'
WHERE
    uuid = '4649605c-6cfb-4829-a033-ce1a7fa06e45';
    
SELECT * FROM candidate;
```
| candidate_id |                 uuid                 | firstname  | lastname  |        email         |   phone    |      presentation      | disabled |
| ------------ | ------------------------------------ | ---------- | --------- |-------------------  | -------- | --------------------- | -------- |
 |           2 | c09e93c0-1980-4a13-9797-581539f33d96 | candidate2 | lastname2 | candidate2@gmail.com | 0606060606 | Je suis le candidat 2  | f |
  |          3 | 97142cea-c071-4c7d-a979-7075f7e3459e | candidate3 | lastname3 | candidate3@gmail.com | 0606060606 | Je suis le candidat 3  | f |
   |         1 | 4649605c-6cfb-4829-a033-ce1a7fa06e45 | candidate1 | lastname1 | candidate1@gmail.com | 0707070707 | présentation modifiée! | f |
(3 rows)


- Supprimer toutes les offres d'une entreprise
```
DELETE FROM job_offer
WHERE recruiter_id = '17f6f1c9-d44d-42d5-bc9a-b103164e1346';

SELECT * FROM job_offer;
```
| job_offer_id |                 uuid                 | title |   description    |   city   |             recruiter_id             |
| ------------ | ----------------------------------- | ----- | --------------- | ------- | -----------------------------------|
|          4 | 0ef722ba-dc88-4baa-be9d-b9b4b8b4d17a | job 4 | Je suis le job 4 | Tours    | cd5c84d6-2494-42d5-bcfb-4a1d99dfdf6a |
|        5 | 592cf3fa-8b6b-4a1e-b3b1-608f5ab0d3c0 | job 5 | Je suis le job 5 | Nice     | cd5c84d6-2494-42d5-bcfb-4a1d99dfdf6a |
|       6 | 5b6fcf56-940c-4a19-9962-04763839a180 | job 6 | Je suis le job 6 | Lyon     | c171233e-049b-4ebd-bd8e-df18621eb596 |
|      7 | b56fd465-90b8-4f30-ab07-5d1fb0154956 | job 7 | Je suis le job 7 | Bordeaux | c171233e-049b-4ebd-bd8e-df18621eb596 |
(4 rows)
