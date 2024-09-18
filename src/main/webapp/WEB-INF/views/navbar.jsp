<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>${pageTitle}</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- <link rel="stylesheet" href="resources/css/style.css">--%>
    
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark  fixed-top" style="background-color:#343a40" >
        <div class="container-fluid d-flex justify-content-between">
            <div>
            <img src="/img/logo.jpg" alt="Logo" height="50px" width="auto" style="border-radius:30px"/>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            </div>
            <div class="collapse navbar-collapse d-flex justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/"><b style="color:#fafafc">Home</b></a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty user}">
                            <c:choose>
                                <c:when test="${user.role == 'ROLE_USER'}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/user/cart"><i class="fa-solid fa-cart-shopping"></i> <img src="/img/cart.jpg" alt="Logo" height="30px" width="auto" style="border-radius:30px"/></a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/"><i class="fa-solid fa-house"></i><b style="color:#fafafc"> Admin Home</b></a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa-solid fa-user"></i><b style="color:#fafafc"> ${user.name}</b>
                                </a>
                                <ul class="dropdown-menu">
                                    <c:choose>
                                        <c:when test="${user.role == 'ROLE_USER'}">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile"><b style="color:black">Profile</b></a></li>
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/user-orders"><b style="color:black">My Orders</b></a></li>
                                        </c:when>
                                        <c:when test="${user.role == 'ROLE_ADMIN'}">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/profile"><b style="color:black">Profile</b></a></li>
                                        </c:when>
                                        
                                    </c:choose>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><b style="color:black">Logout</b></a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/signin"><i class="fa-solid fa-right-to-bracket"></i> <b style="color:black">Login</b></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register"><b style="color:black">Register</b></a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->