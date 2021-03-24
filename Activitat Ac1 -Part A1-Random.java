package com.company;
import java.sql.*;

import static java.sql.DriverManager.getConnection;


public class A12 {
    public static void main(String[] args) {
        Connection connection = null;

        try {

            //Conectem a la base de dades
            connection = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/db_hotels?serverTimezone=UTC", "perepi", "pastanaga");
            // Quan acaba el bucle amb totes les reserves i tanquem la conexió fa commit automàticament
            connection.setAutoCommit(true);
            //Fem un bucle per cada reserva que tenim, fins a 26990
            for (int i =1; i <26990 ; i++) {

                int min_idClient = 10001;
                int max_idClient = 27944;
                //Update al client_id de la taula reserves en els camps on hi hagi la reserva_id del bucle d'adalt i el client_id sigui NULL
                String query = "UPDATE reserves " +
                        "SET client_id = ? " +
                        "WHERE reserva_id = ? AND client_id  IS NULL;";
                PreparedStatement statement = connection.prepareStatement(query);

                // Random del client_id per ficar-lo a continuació a la següent reserva_id
                statement.setInt(1, (int) Math.floor(Math.random() * (max_idClient - min_idClient + 1) + min_idClient));
                //La posició del bucle on estem(i) es la reserva actual on ficarem el random del client_id
                statement.setInt(2, i);
                statement.execute();
            }
            //Tanquem la connexió amb la BDD
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
