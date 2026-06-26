package com.profile.model;

import java.io.Serializable;

public class Profile implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String studentId;
    private String fullName;
    private String academicProgram;
    private String email;
    private String hobbies;
    private String bio;

    // Constructor
    public Profile() {}

    // Getters and Setters
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getAcademicProgram() { return academicProgram; }
    public void setAcademicProgram(String academicProgram) { this.academicProgram = academicProgram; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getHobbies() { return hobbies; }
    public void setHobbies(String hobbies) { this.hobbies = hobbies; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }
    
    private String imageUrl;

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}