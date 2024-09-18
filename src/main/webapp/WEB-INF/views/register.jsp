<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #c6b38c;
            font-family: 'Arial', sans-serif;
        }

        .container {
            
            background: #c6b38c;
             backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .card {
            border: none;
        }

        .card-header {
            background-color: #007bff;
            color: white;
            padding: 15px;
            font-size: 1.5rem;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .form-control {
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        label {
            font-weight: bold;
            color: #333;
        }

        button {
            border-radius: 10px;
            background-color: #007bff;
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        .alert {
            border-radius: 10px;
            font-weight: bold;
        }

        .img-fluid {
            border-radius: 15px;
            border:;
        }

        .card-footer {
            font-size: 0.9rem;
            background-color: #f0f0f0;
            border-bottom-left-radius: 15px;
            border-bottom-right-radius: 15px;
        }

        a {
            color: #007bff;
            font-weight: bold;
            text-decoration: none;
            transition: color 0.3s;
        }

        a:hover {
            color: #0056b3;
        }

        .btn-primary {
            background-color: #28a745;
            border: none;
        }

        .btn-primary:hover {
            background-color: #218838;
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }

            .form-control {
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body style=" background: #c6b38c; backdrop-filter: blur(10px);">
    <section>
        <div class="container my-5 p-5" >
            <div class="row justify-content-center" >
                <!-- Left column with the image -->
                <div class="col-lg-5 col-md-6 mb-4">
                    <img alt="E-Commerce" src="img/register1.jpg" class="img-fluid">
                </div>

                <!-- Right column with the registration form -->
                <div class="col-lg-7 col-md-6"style="border-radius:40px">
                   
                        <!-- Card header -->
                        <div class="card-header text-center  text-white=" style="background:#8f897c;border-radius:40px">
                            <h4 class="mb-0">Create Your Account</h4>
                        </div>

                        <!-- Success message display using JSTL -->
                        <c:if test="${not empty sessionScope.succMsg}">
                            <div class="alert alert-success text-center">
                                ${sessionScope.succMsg}
                                <%
                                    session.removeAttribute("succMsg");
                                %>
                            </div>
                        </c:if>

                        <!-- Error message display using JSTL -->
                        <c:if test="${not empty sessionScope.errorMsg}">
                            <div class="alert alert-danger text-center">
                                ${sessionScope.errorMsg}
                                <%
                                    session.removeAttribute("errorMsg");
                                %>
                            </div>
                        </c:if>
<br>
                        <!-- Card body with the registration form -->
                        <div style="background:#8f897c;">
                            <form action="/saveUser" enctype="multipart/form-data" id="userRegister" novalidate method="post" style="background:#c6b38c;">
                                <!-- Full Name and Mobile Number -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Full Name</label>
                                        <input required class="form-control" name="name" type="text">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Mobile Number</label>
                                        <input required class="form-control" name="mobileNumber" type="number">
                                    </div>
                                </div>

                                <!-- Email -->
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input required class="form-control" name="email" type="email">
                                </div>

                                <!-- Address and City -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Address</label>
                                        <input required class="form-control" name="address" type="text">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">City</label>
                                        <input required class="form-control" name="city" type="text">
                                    </div>
                                </div>

                                <!-- State and Pincode -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">State</label>
                                        <input required class="form-control" name="state" type="text">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Pincode</label>
                                        <input required class="form-control" name="pincode" type="number">
                                    </div>
                                </div>

                                <!-- Password and Confirm Password -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Password</label>
                                        <input required class="form-control" name="password" type="password" id="pass">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Confirm Password</label>
                                        <input required class="form-control" name="confirmpassword" type="password">
                                    </div>
                                </div>

                                <!-- Profile Image Upload -->
                                <div class="mb-3">
                                    <label class="form-label">Profile Image</label>
                                    <input class="form-control" name="img" type="file">
                                </div>

                                <!-- Submit Button -->
                                <div class="d-grid">
                                    <button type="submit" class="btn" style="background-color:gray;border-radius:20px"><b>Register Now</b></button>
                                </div>
                            </form>
                        </div>

                        <!-- Card footer with login link -->
                        <div class="card-footer text-center" style="margin:5px;border-radius:10px;background-color:#d79c1b;">
                            Already have an account? <a href="/login" class="text-decoration-none text-danger">Login here</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
