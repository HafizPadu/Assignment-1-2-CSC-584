package com.profile.dao;

import com.profile.model.Profile;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfileDAO {
    // Port 3306 is standard for MySQL. Update your password here:
    private String jdbcURL = "jdbc:mysql://localhost:3306/studentdb?useSSL=false&allowPublicKeyRetrieval=true";
    private String jdbcUsername = "root";
    private String jdbcPassword = ""; 

    protected Connection getConnection() {
        Connection connection = null;
        try {
            // Explicitly load the MySQL JDBC Driver class for Jakarta/Tomcat
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found in project libraries!");
            e.printStackTrace();
        }
        return connection;
    }

    // Insert or update a profile record (including image URL mapping)
    public boolean saveProfile(Profile profile) {
        String INSERT_SQL = "INSERT INTO student (studentId, fullName, academicProgram, email, hobbies, bio, imageUrl) VALUES (?, ?, ?, ?, ?, ?, ?) "
                + "ON DUPLICATE KEY UPDATE fullName=?, academicProgram=?, email=?, hobbies=?, bio=?, imageUrl=?;";
        boolean rowSaved = false;
        
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SQL)) {
            
            // Core INSERT parameters (1 - 7)
            preparedStatement.setString(1, profile.getStudentId());
            preparedStatement.setString(2, profile.getFullName());
            preparedStatement.setString(3, profile.getAcademicProgram());
            preparedStatement.setString(4, profile.getEmail());
            preparedStatement.setString(5, profile.getHobbies());
            preparedStatement.setString(6, profile.getBio());
            preparedStatement.setString(7, profile.getImageUrl());
            
            // ON DUPLICATE KEY UPDATE parameters (8 - 13)
            preparedStatement.setString(8, profile.getFullName());
            preparedStatement.setString(9, profile.getAcademicProgram());
            preparedStatement.setString(10, profile.getEmail());
            preparedStatement.setString(11, profile.getHobbies());
            preparedStatement.setString(12, profile.getBio());
            preparedStatement.setString(13, profile.getImageUrl());

            rowSaved = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowSaved;
    }

    // Retrieve all profiles from the database (including image URLs)
    public List<Profile> getAllProfiles() {
        List<Profile> profiles = new ArrayList<>();
        String SELECT_ALL = "SELECT * FROM student";
        
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
             ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                Profile profile = new Profile();
                profile.setStudentId(rs.getString("studentId"));
                profile.setFullName(rs.getString("fullName"));
                profile.setAcademicProgram(rs.getString("academicProgram"));
                profile.setEmail(rs.getString("email"));
                profile.setHobbies(rs.getString("hobbies"));
                profile.setBio(rs.getString("bio"));
                profile.setImageUrl(rs.getString("imageUrl")); // Fetches image string from database
                profiles.add(profile);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return profiles;
    }
}