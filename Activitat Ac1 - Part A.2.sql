use db_hotels;
-- 1
-- Obtenir el nom de les poblacions que comencen per vocal.
--   No tinguis en compte les poblacions amb accents.
--   Cal mostrar aquelles poblacions que la vocal estigui en majúcules o minúsucles
--   Ordena el resultat per nom de població de forma ascendent.

SELECT *
FROM poblacions
WHERE nom REGEXP '^(A|E|I|O|U)'
ORDER BY nom;

-- 2
-- Quines poblacions segueixen el patró de tenir la lletra ‘p’ després d’una vocal?
-- Ordena el resultat per nom de població de forma ascendent.

SELECT nom as poblacio
FROM poblacions
WHERE nom REGEXP '(a|e|i|o|u|A|E|I|O|U)\p'
ORDER BY nom;

-- 3
-- Quines poblacions  segueixen el patró de tenir tres vocals seguides en el seu nom?
-- Ordena el resultat per nom de població de forma ascendent.

SELECT nom as poblacio
FROM poblacions
WHERE nom REGEXP '%(a|e|i|o|u|A|E|I|O|U)%(a|e|i|o|u|A|E|I|O|U)%'
ORDER BY nom;

-- 4
-- Hi ha alguna reserva incorrecte? Quines reserves tenim incorrectes si entenem per incorrecte aquella reserva que la seva data_fi sigui igual o inferior a la d'inici.
-- Mostra el camp reserva_id i orderna le resultat per aquest camp de forma ascendent.

SELECT reserva_id
FROM reserves
WHERE data_fi <= data_inici
ORDER BY reserva_id;

-- 5
-- Obtenir el nom i l’adreça dels hotels de 4 estrelles.
-- Ordena el resultat per hotel_id

SELECT nom, adreca
FROM hotels
WHERE categoria RLIKE 4
ORDER BY hotel_id;

-- 6

SELECT MONTH(r.data_inici) AS mes, AVG(*) as nits
FROM reserves r
INNER JOIN 

-- 7
-- Volem saber la densitat d'hotels per població. Per això ens cal saber quina quantitat d'hotels hi ha a cada població. Mostra la quantiat d'hotels per població.
-- Ordena el resultat per nom de població

SELECT p.nom ,count(h.nom)
FROM poblacions p 
INNER JOIN hotels h ON p.poblacio_id = h.poblacio_id
GROUP BY p.poblacio_id
Order by p.nom;

-- 8
-- Suposant que el camp habitacions de la taula hotels NO és correcte. Digues el nom dels hotels de 4 estrelles que tinguin menys de 20 habitacions.
-- Orderna per número d'habitacions de tal manera que primer es mostrin aquells hotels amb menys habitacions.

SELECT h.hotel_id, h.nom, h.categoria, h.habitacions AS qt_hab
    FROM hotels h
    INNER JOIN habitacions h1 ON h1.hotel_id = h.hotel_id
    WHERE h.categoria = 4
    GROUP BY h.hotel_id
    HAVING COUNT(h1.hab_id) < 20
ORDER BY h.habitacions ASC;

-- 9
-- Realitza un rànquing de quanitat d'hotels per població.
-- Ordena el resultat per la quanitat d'hotels de més a menys. Si hi ha poblacions amb el mateix número d'hotels ordena per nom de la població de forma ASC.

SELECT p.nom ,count(h.nom)
FROM poblacions p 
INNER JOIN hotels h ON p.poblacio_id = h.poblacio_id
GROUP BY p.poblacio_id
Order by p.nom;

-- 10
-- Mostra el codi client, el nom i el primer cognom dels clients que han realitzat menys de 3 reserves durant l'any 2016
-- Una reserva pertany a l'any si la seva data d'inici hi pertany.
-- Ordena el resultat per codi client.

SELECT c.client_id, c.nom,c.cognom1, count(r.reserva_id) AS num_reserves
FROM reserves r
LEFT JOIN clients c ON c.client_id = r.client_id
GROUP BY c.client_id
ORDER BY c.client_id;

-- 11
-- De l'Hotel 'Catalonia Ramblas' de Barcelona mostra la quantitat de nits disponibles (teòriques) que tindria l'hotel per cada mes de l'any 2016
-- Ordena per número de mes de forma ascendent

SELECT MONTH(data_inici) AS mes, COUNT(*) as nits
FROM reserves r 
INNER JOIN habitacions h ON h.hab_id = r.hab_id
INNER JOIN hotels ho ON ho.hotel_id = h.hotel_id
WHERE YEAR(data_inici)= '2016' AND ho.nom = 'Catalonia Ramblas'
GROUP BY MONTH(data_inici)
ORDER BY MONTH(data_inici);

-- 12




 -- 13
-- Quants hotels de 4 estrelles tenen el mateix número d'habitacions.
-- Utilitza el camp "habitacions" de la taula hotels.

 SELECT COUNT(h.hotel_id) AS 'quantitat'
    FROM hotels h
    WHERE h.categoria = 4 AND h.habitacions IN (SELECT h1.habitacions
                                                FROM hotels h1 
                                                WHERE h1.categoria = 4);