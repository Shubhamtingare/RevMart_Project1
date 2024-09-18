<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS for a unique design -->
    <style>
        body {
            background-image: url('img/bg.jpg');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .card {
            border: none;
            background-color: #c1bca6;
            border-radius: 25px;
            width: 100%;
            max-width: 500px;
        }

        .card-header {
            background-color: transparent;
            border-bottom: none;
        }

        .card-header p {
            font-weight: bold;
            color: #0072ff;
        }

        .card-body {
            padding-top: 0;
        }

        .btn-primary {
            background-color: #0072ff;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #005bb5;
        }

        .btn-secondary {
            background-color: #938028;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #6d5b2f;
        }

        .card-footer {
            background-color: transparent;
            border-top: none;
        }

        .card-footer a {
            color: #0072ff;
            transition: color 0.3s ease;
        }

        .card-footer a:hover {
            color: #005bb5;
        }

        /* Add responsive behavior */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="card shadow-sm p-4 mb-4">
            <!-- Card header -->
            <div class="card-header">
                <p class="fs-4 text-center" style="color:#938028">Login</p>
            </div>

            <!-- Card body with the form -->
            <div class="card-body">
                <!-- Display error message if any -->
                <c:if test="${not empty loginError}">
                    <div class="alert alert-danger" role="alert">
                        ${loginError}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label class="form-label"><b>User Type</b></label>
                        <select class="form-select" name="userType" required>
                            <option value="USER">User</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><b>Email</b></label>
                        <input required class="form-control" name="username" type="email">
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><b>Password</b></label>
                        <input required class="form-control" name="password" type="password">
                    </div>

                    <!-- Submit button -->
                    <button type="submit" class="btn btn-secondary col-md-12">Login</button>
                </form>
            </div>

            <!-- Card footer with links -->
            <div class="card-footer text-center">
                <a href="${pageContext.request.contextPath}/forgotPassword" class="text-decoration-none">Forgot Password</a><br>
                Don't have an account? 
                <a href="${pageContext.request.contextPath}/register" class="text-decoration-none">Create one</a>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
