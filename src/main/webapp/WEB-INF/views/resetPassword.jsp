<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
</head>
<body>
    <section>
        <div class="container mt-5 p-5">
            <div class="row">
                <!-- Left column with the image -->
                <div class="col-md-6 p-5">
                    <img alt="" src="img/ecom.png" width="100%" height="400px">
                </div>

                <!-- Right column with the reset password form -->
                <div class="col-md-6 mt-3 p-5">
                    <div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
                        <!-- Card header with success and error messages -->
                        <div class="card-header">
                            <p class="fs-4 text-center">Reset Password</p>

                            <!-- Success message -->
                            <c:if test="${not empty sessionScope.succMsg}">
                                <p class="text-success fw-bold text-center">${sessionScope.succMsg}</p>
                                <!-- Optionally remove session message if needed -->
                                <%
                                    session.removeAttribute("succMsg");
                                %>
                            </c:if>

                            <!-- Error message -->
                            <c:if test="${not empty sessionScope.errorMsg}">
                                <p class="text-danger fw-bold text-center">${sessionScope.errorMsg}</p>
                                <!-- Optionally remove session message if needed -->
                                <%
                                    session.removeAttribute("errorMsg");
                                %>
                            </c:if>
                        </div>

                        <!-- Card body with the reset password form -->
                        <div class="card-body">
                            <form action="/reset-password" method="post" id="resetPassword" novalidate>
                                <div class="mb-3">
                                    <label class="form-label">New Password</label>
                                    <input id="pass" class="form-control" name="password" type="password" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Confirm Password</label>
                                    <input name="confirmPassword" class="form-control" type="password" required>
                                </div>

                                <!-- Hidden token input -->
                                <input type="hidden" value="${token}" name="token">

                                <button type="submit" class="btn bg-primary text-white col-md-12">Reset Password</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
