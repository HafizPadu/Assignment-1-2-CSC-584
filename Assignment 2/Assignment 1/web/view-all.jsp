<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Directory Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 50%, #311042 100%);
            min-height: 100vh;
            padding: 50px 20px;
            color: #f1f5f9;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            animation: fadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }

        h1 {
            font-size: 32px;
            font-weight: 700;
            background: linear-gradient(135deg, #fff 30%, #c7d2fe 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* 🔍 Modern Search Control Box bar layout */
        .search-container {
            width: 100%;
            margin-bottom: 35px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 14px 20px 14px 50px;
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 14px;
            font-size: 15px;
            color: #f1f5f9;
            outline: none;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: #6366f1;
            background: rgba(15, 23, 42, 0.8);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.25);
        }

        .search-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #64748b;
            pointer-events: none;
        }

        .btn-create {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
        }

        .btn-create:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.5);
        }

        /* 🗂️ Grid Layout for Student Cards */
        .directory-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }

        .profile-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .profile-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(129, 140, 248, 0.3);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        .avatar-ring {
            width: 90px;
            height: 90px;
            margin: 0 auto 15px;
            border-radius: 50%;
            border: 3px solid #818cf8;
            overflow: hidden;
            background: #1e293b;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .avatar-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-emoji { font-size: 45px; }

        .profile-name {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #ffffff;
        }

        .profile-program {
            font-size: 13px;
            color: #c7d2fe;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .profile-details {
            text-align: left;
            background: rgba(15, 23, 42, 0.3);
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 20px;
            font-size: 13px;
            flex-grow: 1;
        }

        .detail-row {
            margin-bottom: 8px;
            color: #cbd5e1;
            word-break: break-all;
        }
        .detail-row:last-child { margin-bottom: 0; }

        .detail-label {
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #94a3b8;
            font-weight: 700;
            margin-bottom: 2px;
        }

        .btn-view {
            display: block;
            width: 100%;
            padding: 10px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 13px;
            transition: all 0.2s;
        }

        .btn-view:hover {
            background: #6366f1;
            border-color: #4f46e5;
        }

        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
            background: rgba(255, 255, 255, 0.02);
            border: 2px dashed rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            color: #94a3b8;
        }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <div class="header-actions">
            <h1>📋 Student Profile Directory</h1>
            <a href="index.jsp" class="btn-create">➕ Create New Profile</a>
        </div>

        <div class="search-container">
            <span class="search-icon">🔍</span>
            <input type="text" id="directorySearch" class="search-input" placeholder="Search profiles by name, student ID, or academic program...">
        </div>

        <div class="directory-grid" id="profileGrid">
            <c:choose>
                <c:when test="${not empty profiles}">
                    <c:forEach var="p" items="${profiles}">
                        <div class="profile-card" data-search-keys="${p.fullName.toLowerCase()} ${p.studentId.toLowerCase()} ${p.academicProgram.toLowerCase()}">
                            <div>
                                <div class="avatar-ring">
                                    <c:choose>
                                        <c:when test="${not empty p.imageUrl}">
                                            <img src="${p.imageUrl}" class="avatar-img" alt="Avatar" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                            <span class="avatar-emoji" style="display:none;">👤</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="avatar-emoji">👤</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="profile-name">${p.fullName}</div>
                                <div class="profile-program">${p.academicProgram}</div>
                                
                                <div class="profile-details">
                                    <div class="detail-row">
                                        <div class="detail-label">🎓 Student ID</div>
                                        <div>${p.studentId}</div>
                                    </div>
                                    <div class="detail-row">
                                        <div class="detail-label">📧 Email</div>
                                        <div>${p.email}</div>
                                    </div>
                                    <div class="detail-row">
                                        <div class="detail-label">🎯 Hobbies</div>
                                        <div>${not empty p.hobbies ? p.hobbies : 'None listed'}</div>
                                    </div>
                                </div>
                            </div>
                            
                            <form action="ProfileController" method="POST" style="margin: 0; padding: 0;">
                                <input type="hidden" name="studentId" value="${p.studentId}">
                                <input type="hidden" name="fullName" value="${p.fullName}">
                                <input type="hidden" name="academicProgram" value="${p.academicProgram}">
                                <input type="hidden" name="email" value="${p.email}">
                                <input type="hidden" name="hobbies" value="${p.hobbies}">
                                <input type="hidden" name="bio" value="${p.bio}">
                                <button type="submit" class="btn-view" style="cursor: pointer; width: 100%;">View Full Profile Card</button>
                            </form>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <p style="font-size: 18px; margin-bottom: 10px;">No digital cards found in your database yet.</p>
                        <p style="font-size: 14px;">Click the button at the top right to start compiling student directories!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div id="noResultsState" class="empty-state" style="display: none; margin-top: 20px;">
            <p style="font-size: 18px; margin-bottom: 10px;">No matching records found.</p>
            <p style="font-size: 14px;">Try checking your spelling or search for another keyword!</p>
        </div>
    </div>

    <script>
        document.getElementById('directorySearch').addEventListener('input', function(e) {
            const query = e.target.value.toLowerCase().trim();
            const cards = document.querySelectorAll('.profile-card');
            let visibleCount = 0;
            
            cards.forEach(card => {
                const searchKeys = card.getAttribute('data-search-keys');
                if (searchKeys.includes(query)) {
                    card.style.display = 'flex';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            // Toggle "No records found" element block dynamically
            const noResults = document.getElementById('noResultsState');
            if (visibleCount === 0 && cards.length > 0) {
                noResults.style.display = 'block';
            } else {
                noResults.style.display = 'none';
            }
        });
    </script>
</body>
</html>