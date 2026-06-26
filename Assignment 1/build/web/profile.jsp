<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Digital Business Card - ${profile.fullName}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 50%, #311042 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .business-card {
            background: rgba(255, 255, 255, 0.06);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            box-shadow: 0 30px 70px rgba(0, 0, 0, 0.5);
            max-width: 850px;
            width: 100%;
            overflow: hidden;
            animation: slideUp 0.8s cubic-bezier(0.16, 1, 0.3, 1);
            color: #f1f5f9;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-banner {
            background: linear-gradient(90deg, #10b981, #059669);
            color: white;
            padding: 14px;
            text-align: center;
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.5px;
            box-shadow: inset 0 -2px 4px rgba(0,0,0,0.1);
        }

        .card-header {
            background: rgba(255, 255, 255, 0.03);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            padding: 40px;
            text-align: center;
            position: relative;
        }

        .avatar-container {
            width: 130px;
            height: 130px;
            margin: 0 auto 20px;
            border-radius: 50%;
            border: 4px solid #818cf8;
            overflow: hidden;
            background: #1e293b;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            transition: transform 0.4s;
        }
        
        .business-card:hover .avatar-container {
            transform: scale(1.04);
        }

        .avatar-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-emoji {
            font-size: 65px;
        }

        .card-header h1 { 
            font-size: 32px; 
            font-weight: 700;
            background: linear-gradient(135deg, #fff 30%, #c7d2fe 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 8px; 
        }

        .program-badge {
            display: inline-block;
            background: rgba(129, 140, 248, 0.15);
            border: 1px solid rgba(129, 140, 248, 0.3);
            color: #c7d2fe;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        .card-body { padding: 40px; }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 35px;
        }

        .info-card { 
            padding: 20px; 
            background: rgba(255, 255, 255, 0.03); 
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px; 
            transition: all 0.3s ease;
        }

        .info-card:hover { 
            background: rgba(255, 255, 255, 0.06);
            transform: translateY(-3px); 
            border-color: rgba(129, 140, 248, 0.2);
        }

        .info-label { 
            font-size: 11px; 
            text-transform: uppercase; 
            letter-spacing: 1.5px; 
            color: #94a3b8; 
            font-weight: 700; 
            margin-bottom: 8px; 
        }

        .info-value { font-size: 16px; color: #f1f5f9; font-weight: 500; }

        .bio-box { 
            background: rgba(15, 23, 42, 0.4); 
            border: 1px solid rgba(255, 255, 255, 0.05);
            padding: 25px; 
            border-radius: 16px; 
        }

        .bio-box h3 { 
            color: #a78bfa; 
            margin-bottom: 12px; 
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .bio-text { color: #cbd5e1; line-height: 1.7; font-size: 15px; }

        .card-footer { 
            background: rgba(0, 0, 0, 0.2); 
            padding: 25px 40px; 
            text-align: center; 
            border-top: 1px solid rgba(255, 255, 255, 0.08); 
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            color: white;
            text-decoration: none;
            border-radius: 12px;
            transition: all 0.3s;
            font-weight: 600;
            font-size: 14px;
            border: none;
            cursor: pointer;
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
        }

        .btn-primary {
            background: linear-gradient(135deg, #06b6d4 0%, #3b82f6 100%);
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        }
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
        }

        /* 📄 CONFIGURATION FOR PRINT: ACTUAL PREMIUM BUSINESS CARD LOOK */
        @media print {
            /* Configure page margins for standalone card dimensions */
            @page {
                size: 3.5in 2in; /* Exact landscape business card scale dimensions */
                margin: 0;
            }

            html, body {
                background: #0f172a !important; /* Retains dark high-end executive feel on the card background */
                width: 3.5in !important;
                height: 2in !important;
                padding: 0 !important;
                margin: 0 !important;
                overflow: hidden;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }

            .success-banner, .card-footer, .bio-box {
                display: none !important; /* Hides web element components */
            }

            .business-card {
                background: #0f172a !important;
                border: none !important;
                box-shadow: none !important;
                width: 3.5in !important;
                height: 2in !important;
                max-width: 3.5in !important;
                padding: 12px !important;
                margin: 0 !important;
                border-radius: 0 !important;
                display: flex !important;
                flex-direction: row !important; /* Split screen structure layout */
                align-items: center !important;
                justify-content: space-between !important;
                gap: 12px;
            }

            /* Front Left Wing Content details */
            .card-header {
                background: none !important;
                border: none !important;
                padding: 0 !important;
                text-align: left !important;
                width: 45% !important;
                display: flex !important;
                flex-direction: column !important;
                align-items: flex-start !important;
            }

            .avatar-container {
                width: 48px !important;
                height: 48px !important;
                margin: 0 0 6px 0 !important;
                border: 2px solid #818cf8 !important;
                box-shadow: none !important;
            }

            .avatar-emoji { font-size: 26px !important; }

            .card-header h1 {
                font-size: 13px !important;
                font-weight: 700 !important;
                background: none !important;
                -webkit-text-fill-color: #ffffff !important;
                color: #ffffff !important;
                margin-bottom: 2px !important;
                line-height: 1.2;
            }

            .program-badge {
                background: none !important;
                border: none !important;
                color: #94a3b8 !important;
                padding: 0 !important;
                font-size: 8px !important;
                font-weight: 600 !important;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* Front Right Wing Data details Column */
            .card-body {
                padding: 0 !important;
                width: 50% !important;
                height: auto !important;
                display: flex !important;
                align-items: center !important;
            }

            .info-grid {
                display: flex !important;
                flex-direction: column !important;
                gap: 6px !important;
                margin: 0 !important;
                width: 100% !important;
                border-left: 1px solid rgba(255, 255, 255, 0.15);
                padding-left: 10px !important;
            }

            .info-card {
                background: none !important;
                border: none !important;
                border-radius: 0 !important;
                padding: 0 !important;
                margin: 0 !important;
                transform: none !important;
            }

            .info-label {
                font-size: 7px !important;
                color: #64748b !important;
                margin-bottom: 1px !important;
                letter-spacing: 0.5px;
            }

            .info-value {
                font-size: 9px !important;
                color: #cbd5e1 !important;
                font-weight: 500 !important;
            }
        }
    </style>
</head>
<body>
    <div class="business-card">
        <div class="success-banner">✓ Profile successfully saved to database!</div>
        
        <div class="card-header">
            <div class="avatar-container">
                <c:choose>
                    <c:when test="${not empty profile.imageUrl}">
                        <img src="${profile.imageUrl}" class="avatar-img" alt="Profile Image" onerror="this.style.display='none'; document.getElementById('fallback-emoji').style.display='block';">
                        <span id="fallback-emoji" class="avatar-emoji" style="display:none;">👤</span>
                    </c:when>
                    <c:otherwise>
                        <span class="avatar-emoji">👤</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <h1>${profile.fullName}</h1>
            <div class="program-badge">💼 ${profile.academicProgram}</div>
        </div>
        
        <div class="card-body">
            <div class="info-grid">
                <div class="info-card">
                    <div class="info-label">🎓 Student ID</div>
                    <div class="info-value">${profile.studentId}</div>
                </div>
                
                <div class="info-card">
                    <div class="info-label">📧 Email Address</div>
                    <div class="info-value">${profile.email}</div>
                </div>
                
                <div class="info-card">
                    <div class="info-label">🎯 Hobbies & Interests</div>
                    <div class="info-value">${profile.hobbies}</div>
                </div>
            </div>
            
            <div class="bio-box">
                <h3>📝 Professional Background</h3>
                <div class="bio-text">${profile.bio}</div>
            </div>
        </div>
        
        <div class="card-footer">
            <a href="index.jsp" class="btn btn-secondary">← Create Another</a>
            <button onclick="window.print()" class="btn btn-success">📄 Export to PDF Resume</button>
            <a href="ProfileController" class="btn btn-primary">View Directory Dashboard →</a>
        </div>
    </div>
</body>
</html>