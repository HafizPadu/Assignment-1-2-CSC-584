<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Digital Business Card Creator</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 50%, #311042 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            padding: 40px;
            max-width: 550px;
            width: 100%;
            box-shadow: 0 30px 70px rgba(0, 0, 0, 0.4);
            animation: fadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            color: #f1f5f9;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            text-align: center;
            font-size: 30px;
            font-weight: 700;
            background: linear-gradient(135deg, #fff 30%, #c7d2fe 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #94a3b8;
            margin-bottom: 35px;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 13px;
            color: #cbd5e1;
            letter-spacing: 0.5px;
        }
        
        .required:after {
            content: " *";
            color: #f43f5e;
        }

        input[type="text"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 12px 16px;
            background: rgba(15, 23, 42, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            font-size: 14px;
            color: #f1f5f9;
            transition: all 0.3s ease;
            outline: none;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        textarea:focus {
            border-color: #6366f1;
            background: rgba(15, 23, 42, 0.8);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.25);
        }

        /* 📸 Custom sleek upload file selector styling */
        input[type="file"] {
            width: 100%;
            padding: 10px;
            background: rgba(15, 23, 42, 0.3);
            border: 1px dashed rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            font-size: 14px;
            color: #94a3b8;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="file"]:hover {
            border-color: #6366f1;
            background: rgba(99, 102, 241, 0.05);
            color: #c7d2fe;
        }

        textarea {
            resize: vertical;
            min-height: 90px;
            line-height: 1.6;
        }

        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.5);
            opacity: 0.95;
        }
        
        button:active {
            transform: translateY(0);
        }

        .error {
            background: rgba(244, 63, 94, 0.1);
            color: #fda4af;
            padding: 14px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 1px solid rgba(244, 63, 94, 0.2);
            font-size: 13px;
            line-height: 1.5;
            word-wrap: break-word;
        }

        ::placeholder {
            color: #475569;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✨ Digital Business Card ✨</h1>
        <div class="subtitle">Create your professional profile layout</div>
        
        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error">⚠️ <%= error %></div>
        <% } %>
        
        <form action="ProfileController" method="POST" enctype="multipart/form-data">
            <div class="form-group">
                <label class="required">Full Name</label>
                <input type="text" name="fullName" placeholder="e.g. John Doe" required>
            </div>
            
            <div class="form-group">
                <label class="required">Student ID</label>
                <input type="text" name="studentId" placeholder="e.g. B200192" required>
            </div>
            
            <div class="form-group">
                <label class="required">Academic Program</label>
                <input type="text" name="academicProgram" placeholder="e.g. Bachelor of Computer Science" required>
            </div>
            
            <div class="form-group">
                <label class="required">Email Address</label>
                <input type="email" name="email" placeholder="e.g. johndoe@example.com" required>
            </div>
            
            <div class="form-group">
                <label>Upload Profile Image</label>
                <input type="file" name="imageFile" accept="image/*">
            </div>
            
            <div class="form-group">
                <label>Hobbies & Interests</label>
                <input type="text" name="hobbies" placeholder="e.g. Coding, Photography, Football">
            </div>
            
            <div class="form-group">
                <label>Professional Bio</label>
                <textarea name="bio" placeholder="Write a short summary about your professional background..."></textarea>
            </div>
            
            <button type="submit">Create Card →</button>
        </form>
    </div>
</body>
</html>