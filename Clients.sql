CREATE TABLE clients(
client_id INT UNSIGNED AUTO_INCREMENT,
nom VARCHAR(30),
cognom1 VARCHAR(30),
sexe CHAR(1),
data_naixement DATE,
pais_origen_id INT UNSIGNED,
reserva_id INT UNSIGNED,
CONSTRAINT PK_clients PRIMARY KEY (client_id),
CONSTRAINT FK_clients_paisos FOREIGN KEY (pais_origen_id)
REFERENCES paisos (pais_id),
CONSTRAINT FK_clients_reserves FOREIGN KEY (reserva_id)
REFERENCES reserves (reserva_id)
);