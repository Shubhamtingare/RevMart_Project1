<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f5f5f5;
        }
        .product-container {
            margin-top: 70px;
            margin-bottom: 100px;
            background-color: #a9a9a9;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .product-title {
            font-size: 1.75rem;
            font-weight: bold;
        }
        .product-price {
            font-size: 1.5rem;
            color: #ff4c4c;
        }
        .discounted-price {
            text-decoration: line-through;
            color: #999;
        }
        .features-icons .fa-2x {
            margin-bottom: 10px;
        }
        .btn-add-to-cart {
            background-color: #ff4c4c;
            color: white;
            font-weight: bold;
            transition: all 0.3s;
        }
        .btn-add-to-cart:hover {
            background-color: #e63939;
        }
        .badge-success {
            background-color: #28a745;
        }
        .badge-warning {
            background-color: #ffc107;
        }
    </style>
</head>
<body>
<div>
 <jsp:include page="navbar.jsp"></jsp:include>
</div>
    <section>
        <div class="container product-container">
            <div class="row">

                <!-- Success Message -->
                <c:if test="${not empty sessionScope.succMsg}">
                    <p class="text-success text-center" role="alert">${sessionScope.succMsg}</p>
                    <%
                        session.removeAttribute("succMsg");
                    %>
                </c:if>

                <!-- Error Message -->
                <c:if test="${not empty sessionScope.errorMsg}">
                    <p class="text-danger text-center ">${sessionScope.errorMsg}</p>
                    <%
                        session.removeAttribute("errorMsg");
                    %>
                </c:if>

                <!-- Product Image -->
                <div class="col-md-6 text-center" style="padding:5px;">
                <p class="product-title">${product.title}</p>
                    <img alt="" src="${pageContext.request.contextPath}/img/product_img/${product.image}" class="img-fluid" width="300px" height="250px">
                </div>

                <!-- Product Details -->
                <div class="col-md-6" style="padding:20px;padding-left:20px;">
                    
                    <p style="font-weight:bold;font-size:1.5rem"><strong>Description:</strong><br> ${product.description}</p>
                    <p><strong>Product Details:</strong>
                        Status: 
                        <!-- Check Product Stock -->
                        <c:if test="${product.stock > 0}">
                            <span class="badge badge-success">Available</span>
                        </c:if>
                        <c:if test="${product.stock <= 0}">
                            <span class="badge badge-warning">Out of stock</span>
                        </c:if>
                        <br><b>Category: ${product.category}</b><br>
                        <b>Policy: 7 Days Replacement & Return</b>
                    </p>

                    <!-- Product Pricing -->
                    <p class="product-price">
                        <i class="fas fa-rupee-sign"></i> ${product.discountPrice}
                        <span class="discounted-price" style="color:black">${product.price}</span>
                        <span class="text-success" style>${product.discount}% off</span>
                    </p>

                    <!-- Additional Product Details -->
                    <div class="row features-icons">
                        <div class="col-md-4">
                            <i class="fas fa-money-bill-wave fa-2x text-success"></i>
                            <p>Cash On Delivery</p>
                        </div>
                        <div class="col-md-4">
                            <i class="fas fa-undo-alt fa-2x text-danger"></i>
                            <p>Return Available</p>
                        </div>
                        <div class="col-md-4">
                            <i class="fas fa-truck-moving fa-2x text-primary"></i>
                            <p>Free Shipping</p>
                        </div>
                    </div>

                    <!-- Add to Cart Button Based on Stock and User Login -->
                    <c:if test="${product.stock > 0}">
                        <c:choose>
                            <c:when test="${user == null}">
                                <a href="${pageContext.request.contextPath}/signin" class="btn btn-add-to-cart col-md-12 mt-3" style="background-color:red">Add To Cart</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/user/addCart?pid=${product.id}&uid=${user.id}" class="btn btn-add-to-cart col-md-12 mt-3" style="background-color:green">Add To Cart</a>
                            </c:otherwise>
                        </c:choose>
                    </c:if>

                    <!-- Out of Stock Button -->
                    <c:if test="${product.stock <= 0}">
                        <a href="#" class="btn btn-warning col-md-12 mt-3">Out of Stock</a>
                    </c:if>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
