package com.profile.controller;

import com.profile.dao.ProfileDAO;
import com.profile.model.Profile;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.List;

@WebServlet("/ProfileController")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Limits file upload sizes up to 5MB
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProfileDAO profileDAO = new ProfileDAO();

    // Handle HTTP GET requests (when clicking links or dashboards)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Profile> allProfiles = profileDAO.getAllProfiles();
            request.setAttribute("profiles", allProfiles);
            request.getRequestDispatcher("view-all.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not retrieve the directory profiles: " + e.getMessage());
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    // Handle HTTP POST requests (Handles BOTH creation form and view button action)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String studentId = request.getParameter("studentId");
            String fullName = request.getParameter("fullName");
            String academicProgram = request.getParameter("academicProgram");
            String email = request.getParameter("email");
            String hobbies = request.getParameter("hobbies");
            String bio = request.getParameter("bio");
            
            String base64Image = "";
            String contentType = request.getContentType();

            // 🛠️ SMART CHECK FIX: Only parse files if the request is actually a multipart upload form
            if (contentType != null && contentType.toLowerCase().startsWith("multipart/form-data")) {
                Part filePart = request.getPart("imageFile"); 
                
                if (filePart != null && filePart.getSize() > 0) {
                    InputStream inputStream = filePart.getInputStream();
                    byte[] imageBytes = inputStream.readAllBytes();
                    
                    String base64Encoded = Base64.getEncoder().encodeToString(imageBytes);
                    base64Image = "data:" + filePart.getContentType() + ";base64," + base64Encoded;
                }
            }

            Profile profile = new Profile();
            profile.setStudentId(studentId);
            profile.setFullName(fullName);
            profile.setAcademicProgram(academicProgram);
            profile.setEmail(email);
            profile.setHobbies(hobbies);
            profile.setBio(bio);
            
            // Image handling logic based on whether a new file was provided
            if (!base64Image.isEmpty()) {
                profile.setImageUrl(base64Image);
            } else {
                // If viewing or updating with no new file, preserve what's already in the DB
                List<Profile> allProfiles = profileDAO.getAllProfiles();
                String existingImageUrl = "";
                for (Profile p : allProfiles) {
                    if (p.getStudentId().equals(studentId)) {
                        existingImageUrl = p.getImageUrl();
                        break;
                    }
                }
                profile.setImageUrl(existingImageUrl != null ? existingImageUrl : "");
            }

            // Only run the save operation if we came from the creation form
            // (When clicking "View", the data matches the DB already so this keeps it completely safe)
            boolean saved = profileDAO.saveProfile(profile);

            if (saved) {
                request.setAttribute("profile", profile);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Database error: Could not process saving profile information.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading profile context: " + e.getMessage());
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}