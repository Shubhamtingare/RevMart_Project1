<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>All Orders</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-zA8fKOB5nMmf07RjI1Rk5qV8e4J8jFP4Mj6xEj6Z56icpZZxQ0xl+zR8RQ7xKeQj" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO6C5P88BBuYKEkO1u0Bbd67g7P12aW1Cx5Yt3IQ3Qms5gk/gvj0J" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-Ig7t6ZyWkt+uCblJ5Cggw59ITfH9EnLRh/+V8aIedgrQ3s5qlJ6rP6H63l7kFkv8" crossorigin="anonymous"></script>
</head>
<body>
<div>
 <jsp:include page="navbar.jsp"></jsp:include>
</div>
    <section>
        <div class="container-fluid mt-5">
            <div class="row">
                <h3 class="text-center mb-4">All Orders</h3>
                <hr>
                <a href="${pageContext.request.contextPath}/admin/" class="btn btn-secondary mb-3">
                    <i class="fa-solid fa-arrow-left"></i> Back
                </a>

                <c:if test="${not empty sessionScope.succMsg}">
                    <div class="alert alert-success text-center" role="alert">
                        ${sessionScope.succMsg}
                    </div>
                    <%-- Remove session message after displaying --%>
                    <%
                        session.removeAttribute("succMsg");
                    %>
                </c:if>

                <c:if test="${not empty sessionScope.errorMsg}">
                    <div class="alert alert-danger text-center" role="alert">
                        ${sessionScope.errorMsg}
                    </div>
                    <%-- Remove session message after displaying --%>
                    <%
                        session.removeAttribute("errorMsg");
                    %>
                </c:if>

                <div class="col-md-4 mb-4">
                    <form action="${pageContext.request.contextPath}/admin/search-order" method="get">
                        <div class="input-group">
                            <input type="text" class="form-control" name="orderId" placeholder="Enter order id">
                            <button class="btn btn-primary" type="submit">Search</button>
                        </div>
                    </form>
                </div>

                <div class="col-md-12">
                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">Order Id</th>
                                <th scope="col">Deliver Details</th>
                                <th scope="col">Date</th>
                                <th scope="col">Product Details</th>
                                <th scope="col">Price</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${srch}">
                                <c:if test="${not empty orderDtls}">
                                    <tr>
                                        <th scope="row">${orderDtls.orderId}</th>
                                        <td>
                                            Name: ${orderDtls.orderAddress.firstName} ${orderDtls.orderAddress.lastName} <br>
                                            Email: ${orderDtls.orderAddress.email} <br>
                                            Mobno: ${orderDtls.orderAddress.mobileNo} <br>
                                            Address: ${orderDtls.orderAddress.address} <br>
                                            City: ${orderDtls.orderAddress.city} <br>
                                            State: ${orderDtls.orderAddress.state}, ${orderDtls.orderAddress.pincode}
                                        </td>
                                        <td>${orderDtls.orderDate}</td>
                                        <td>${orderDtls.product.title}</td>
                                        <td>
                                            Quantity: ${orderDtls.quantity} <br>
                                            Price: ${orderDtls.price} <br>
                                            Total Price: ${orderDtls.quantity * orderDtls.price}
                                        </td>
                                        <td>${orderDtls.status}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/update-order-status" method="post">
                                                <div class="d-flex align-items-center">
                                                    <select class="form-select me-2" name="st">
                                                        <option>--select--</option>
                                                        <option value="1">In Progress</option>
                                                        <option value="2">Order Received</option>
                                                        <option value="3">Product Packed</option>
                                                        <option value="4">Out for Delivery</option>
                                                        <option value="5">Delivered</option>
                                                        <option value="6">Cancelled</option>
                                                    </select>
                                                    <input type="hidden" name="id" value="${orderDtls.id}">
                                                    <c:if test="${orderDtls.status == 'Cancelled' || orderDtls.status == 'Delivered'}">
                                                        <button class="btn btn-secondary btn-sm" disabled>Update</button>
                                                    </c:if>
                                                    <c:if test="${orderDtls.status != 'Cancelled' && orderDtls.status != 'Delivered'}">
                                                        <button class="btn btn-primary btn-sm">Update</button>
                                                    </c:if>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:if test="${empty orderDtls}">
                                    <tr>
                                        <td colspan="7" class="text-center text-danger">${errorMsg}</td>
                                    </tr>
                                </c:if>
                            </c:if>

                            <c:if test="${!srch}">
                                <c:forEach var="o" items="${orders}">
                                    <tr>
                                        <th scope="row">${o.orderId}</th>
                                        <td>
                                            Name: ${o.orderAddress.firstName} ${o.orderAddress.lastName} <br>
                                            Email: ${o.orderAddress.email} <br>
                                            Mobno: ${o.orderAddress.mobileNo} <br>
                                            Address: ${o.orderAddress.address} <br>
                                            City: ${o.orderAddress.city} <br>
                                            State: ${o.orderAddress.state}, ${o.orderAddress.pincode}
                                        </td>
                                        <td>${o.orderDate}</td>
                                        <td>${o.product.title}</td>
                                        <td>
                                            Quantity: ${o.quantity} <br>
                                            Price: ${o.price} <br>
                                            Total Price: ${o.quantity * o.price}
                                        </td>
                                        <td>${o.status}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/update-order-status" method="post">
                                                <div class="d-flex align-items-center">
                                                    <select class="form-select me-2" name="st">
                                                        <option>--select--</option>
                                                        <option value="1">In Progress</option>
                                                        <option value="2">Order Received</option>
                                                        <option value="3">Product Packed</option>
                                                        <option value="4">Out for Delivery</option>
                                                        <option value="5">Delivered</option>
                                                        <option value="6">Cancelled</option>
                                                    </select>
                                                    <input type="hidden" name="id" value="${o.id}">
                                                    <c:if test="${o.status == 'Cancelled' || o.status == 'Delivered'}">
                                                        <button class="btn btn-secondary btn-sm" disabled>Update</button>
                                                    </c:if>
                                                    <c:if test="${o.status != 'Cancelled' && o.status != 'Delivered'}">
                                                        <button class="btn btn-primary btn-sm">Update</button>
                                                    </c:if>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>

                    <c:if test="${!srch}">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${isFirst ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/orders?pageNo=${pageNo-1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${pageNo + 1 == i ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/orders?pageNo=${i-1}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${isLast ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/orders?pageNo=${pageNo+1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                        <div class="text-center mt-3">Total Orders: ${totalElements}</div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
