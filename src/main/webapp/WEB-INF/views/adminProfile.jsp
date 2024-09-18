<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>My Profile</title>
</head>
<body>
    <section>
        <div class="container-fluid mt-5 p-5 bg-light">
            <div class="row">
                <div class="col-md-10 offset-md-1">
                    <p class="fs-3 text-center">My Profile</p>

                    <c:if test="${not empty sessionScope.succMsg}">
                        <p class="text-success fw-bold text-center">${sessionScope.succMsg}</p>
                        <%-- Remove session message after displaying --%>
                        <%
                            session.removeAttribute("succMsg");
                        %>
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMsg}">
                        <p class="text-danger fw-bold text-center">${sessionScope.errorMsg}</p>
                        <%-- Remove session message after displaying --%>
                        <%
                            session.removeAttribute("errorMsg");
                        %>
                    </c:if>

                    <hr>

                    <div class="text-center">
                        <img alt="" src="${pageContext.request.contextPath}/../img/profile_img/${user.profileImage}"
                             class="border p-2"
                             style="width: 110px; height: 110px; border-radius: 50%;">
                    </div>

                    <div class="col-md-8 offset-md-2 mt-4">
                        <form action="${pageContext.request.contextPath}/admin/update-profile" method="post" enctype="multipart/form-data">
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <th scope="row">Name</th>
                                        <td>:</td>
                                        <td><input type="text" name="name" class="form-control" value="${user.name}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Mobile Number</th>
                                        <td>:</td>
                                        <td><input type="text" name="mobileNumber" class="form-control" value="${user.mobileNumber}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Email</th>
                                        <td>:</td>
                                        <td><input type="text" name="email" class="form-control" readonly value="${user.email}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Address</th>
                                        <td>:</td>
                                        <td><input type="text" name="address" class="form-control" value="${user.address}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">City</th>
                                        <td>:</td>
                                        <td><input type="text" name="city" class="form-control" value="${user.city}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">State</th>
                                        <td>:</td>
                                        <td><input type="text" name="state" class="form-control" value="${user.state}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Pincode</th>
                                        <td>:</td>
                                        <td><input type="text" name="pincode" class="form-control" value="${user.pincode}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Image</th>
                                        <td>:</td>
                                        <td><input type="file" name="img" class="form-control"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Role</th>
                                        <td>:</td>
                                        <td><input type="text" name="role" class="form-control" readonly value="${user.role}"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Account Status</th>
                                        <td>:</td>
                                        <td><input type="text" name="isEnable" class="form-control" readonly value="${user.isEnable}">
                                            <input type="hidden" name="id" value="${user.id}">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="text-center">
                                            <button class="btn btn-sm bg-primary text-light">Update</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>

                <hr>

                <div class="col-md-10 offset-md-1 mt-1">
                    <div class="row">
                        <p class="text-center fs-3">Change Password</p>
                        <div class="col-md-6 offset-md-3">
                            <form action="${pageContext.request.contextPath}/admin/change-password" method="post">
                                <table class="table table-borderless">
                                    <tbody>
                                        <tr>
                                            <th scope="row">Current Password</th>
                                            <td><input type="password" name="currentPassword" class="form-control"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">New Password</th>
                                            <td><input type="password" name="newPassword" class="form-control"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Confirm Password</th>
                                            <td><input type="password" name="confirmPassword" class="form-control"></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td class="text-center">
                                                <button class="btn btn-sm bg-primary text-light col-md-4">Update</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
</body>
</html>
