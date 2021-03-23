package com.company;
import java.sql.*;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class conexion {

    public static void main(String[] args) {
        // Fem la connexió a la base de dades
        String jdbcURL = "jdbc:mysql://192.168.56.102:3306/db_hotels?serverTimezone=UTC";
        String user = "perepi";
        String password = "pastanaga";
        String csvpath = "dades_clients-tab.csv";
        int batchSize = 20;
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(jdbcURL, user, password);
            connection.setAutoCommit(false);
            //Inserim les dades del fitxer csv amb una consulta sql
            String sql = "INSERT INTO clients(client_id,nom,cognom1,sexe,data_naix,pais_origen_id) VALUES (?,?,?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);

            BufferedReader lineReader = new BufferedReader(new FileReader(csvpath));
            String lineText = null;

            int count = 0;

            lineReader.readLine();

            while ((lineText = lineReader.readLine()) != null) {
                //Agafem el string de totes les dades i el separem, a continuació fiquem cada informació a una casella
                String[] data = lineText.split("\t");
                String client_id = data[0];
                String nom = data[1];
                String cognom1 = data[2];
                String sexe = data[3];
                String data_naixement= data[4];
                String pais_origen_id = data[5];
                statement.setInt(1, Integer.parseInt(client_id));
                statement.setString(2, nom);
                statement.setString(3, cognom1);
                statement.setString(4, sexe);
                //Parsejem la data per coincidir amb la de el sql
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                Date parsed = format.parse(data_naixement);
                java.sql.Date sqldate = new java.sql.Date(parsed.getTime());
                statement.setDate(5, sqldate);
                statement.setInt(6, Integer.parseInt(pais_origen_id));
                statement.addBatch();
                if (count % batchSize == 0) {
                    statement.executeBatch();
                }
            }
            lineReader.close();
            statement.executeBatch();

            connection.commit();
            connection.close();

        } catch (IOException ex) {
            System.err.println(ex);
        } catch (SQLException ex) {
            ex.printStackTrace();

            try {
                connection.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
