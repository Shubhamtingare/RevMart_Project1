<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Admin</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Optional Font Awesome CDN for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: url('https://images.unsplash.com/photo-1508780709619-79562169bc64?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDJ8fG9mZmljZXxlbnwwfHx8fDE2NzQ1ODU4NzU&ixlib=rb-1.2.1&q=80&w=1080') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6); /* Dark overlay to enhance contrast */
            z-index: 1;
        }

        .container {
            position: relative;
            z-index: 2;
            margin-top: 5rem;
        }

        .card {
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.85); /* Slightly transparent background for the card */
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.3); /* Shadow for depth */
            transition: box-shadow 0.3s ease, transform 0.3s ease;
        }

        .card:hover {
            box-shadow: 0 10px 18px rgba(0, 0, 0, 0.5);
            transform: translateY(-5px); /* Smooth lift effect */
        }

        .card-header {
            background-color:#8a8583;
            color: white;
            text-align: center;
            font-size: 1.8rem;
            padding: 15px;
            border-radius: 15px 15px 0 0;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .card-body {
            padding: 2rem;
            color: #333;
        }

        .form-label {
            color: #475c6c;
            font-weight: bold;
        }

        input, textarea, select {
            background-color: rgba(255, 255, 255, 0.95); /* Light input fields */
            border: 1px solid #ddd;
            color: #333;
            padding: 0.75rem;
            border-radius: 5px;
            transition: border-color 0.2s;
        }

        input:focus, textarea:focus, select:focus {
            border-color: #007bff; /* Highlight on focus */
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.4);
        }

        .btn-primary {
            background-color: #475c6c;
            border: none;
            padding: 0.75rem 1rem;
            font-size: 1.1rem;
            font-weight: bold;
            width: 100%;
            border-radius: 10px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-3px); /* Subtle lift effect on hover */
        }

        .text-success, .text-danger {
            font-weight: bold;
            font-size: 1rem;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Dark Overlay -->
    <div class="overlay"></div>

    <section>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-7">
                    <div class="card">
                        <div class="card-header text-center">
                            Add Admin
                        </div>

                        <div class="card-body">
                            <!-- Success and Error Messages -->
                            <c:if test="${not empty sessionScope.succMsg}">
                                <p class="text-success">${sessionScope.succMsg}</p>
                                <c:remove var="succMsg" scope="session"/>
                            </c:if>

                            <c:if test="${not empty sessionScope.errorMsg}">
                                <p class="text-danger">${sessionScope.errorMsg}</p>
                                <c:remove var="errorMsg" scope="session"/>
                            </c:if>

                            <!-- Form to Add Admin -->
                            <form action="${pageContext.request.contextPath}/admin/save-admin" enctype="multipart/form-data" method="post">
                                <div class="row mb-3">
                                    <div class="col">
                                        <label class="form-label">Full Name</label>
                                        <input required class="form-control" name="name" type="text">
                                    </div>

                                    <div class="col">
                                        <label class="form-label">Mobile Number</label>
                                        <input required class="form-control" name="mobileNumber" type="number">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input required class="form-control" name="email" type="email">
                                </div>

                                <div class="row mb-3">
                                    <div class="col">
                                        <label class="form-label">Address</label>
                                        <input required class="form-control" name="address" type="text">
                                    </div>

                                    <div class="col">
                                        <label class="form-label">City</label>
                                        <input required class="form-control" name="city" type="text">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col">
                                        <label class="form-label">State</label>
                                        <input required class="form-control" name="state" type="text">
                                    </div>

                                    <div class="col">
                                        <label class="form-label">Pincode</label>
                                        <input required class="form-control" name="pincode" type="number">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col">
                                        <label class="form-label">Password</label>
                                        <input required class="form-control" name="password" type="password">
                                    </div>
                                    <div class="col">
                                        <label class="form-label">Confirm Password</label>
                                        <input required class="form-control" name="cpassword" type="password">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Profile Image</label>
                                    <input class="form-control" name="img" type="file">
                                </div>
                                
                                <button type="submit" class="btn btn-primary">Register</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
