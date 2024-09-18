<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>UserHome</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom CSS for a unique design -->
    <style>
        body {
            background-color: #f5f5f5; /* Light gray background for the body */
        }

        /* Carousel Styles */
        #carouselExample {
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .carousel-item img {
            object-fit: cover;
            height: 350px;
        }

        /* Category Cards */
        .category-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .category-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        .category-card img {
            border-radius: 50%;
            transition: opacity 0.3s ease;
        }

        .category-card img:hover {
            opacity: 0.8;
        }

        /* Latest Products */
        .latest-product-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .latest-product-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        .latest-product-card img {
            border-radius: 10px;
        }

        .card-body p {
            font-weight: bold;
            color: #333;
        }

        .text-center {
            color: #333;
        }

        .bg-light {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp"%>
    <section>
        <!-- Start Carousel -->
        <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/img/p10.jpg" class="d-block w-100" alt="Slide 1">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/p11.jpg" class="d-block w-100" alt="Slide 2">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/p12.jpg" class="d-block w-100" alt="Slide 3">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/p15.jpg" class="d-block w-100" alt="Slide 4">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <!-- End Carousel -->

       <!-- Start Category Module -->
       <div class="container">
            <div class="row mb-4">
                <p class="text-center fs-4 mb-4">Category</p>
                <div class="col-md-2">
                    <div class="card category-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/e2.jpg" width="100%" height="140px" alt="Electronics">
                            <p>Eelectronics</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-2">
                    <div class="card category-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/beauty1.jpg" width="100%" height="140px" alt="Beauty">
                            <p>Beauty</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-2">
                    <div class="card category-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/men.jpeg" width="100%" height="140px" alt="Clothes">
                            <p>Clothes</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-2">
                    <div class="card category-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/lap1.png" width="100%" height="140px" alt="Laptop">
                            <p>Laptop</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-2">
                    <div class="card category-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/p5.jpg" width="100%" height="140px" alt="Mobile">
                            <p>Mobile</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-2">
                    <div class="card category-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/p6.jpg" width="100%" height="140px" alt="Grocery">
                            <p>Grocery</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Category Module -->

        <!-- Start Latest Product Module -->
        <div class="container-fluid bg-light p-4">
            <div class="row">
                <p class="text-center fs-4 mb-4">Latest Product</p>

                <div class="col-md-3">
                    <div class="card latest-product-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/dell1.jpg" class="w-100" height="140px" alt="Dell Laptop">
                            <p>Dell Laptop</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card latest-product-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/cloth.jpg" class="w-100" height="140px" alt="Cloth">
                            <p>Cloth</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card latest-product-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/monile.png" class="w-100" height="140px" alt="Mobile">
                            <p>Mobile</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card latest-product-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/box.png" class="w-100" height="140px" alt="Organic Ghee">
                            <p>Organic Ghee</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card latest-product-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/beauty.jpg" class="w-100" height="140px" alt="Beauty">
                            <p>Beauty Collection</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card latest-product-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/ear1.jpg" class="w-100" height="140px" alt="Beauty">
                            <p>Ear Bud</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card latest-product-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/cloth1.jpg" class="w-100" height="140px" alt="Beauty">
                            <p>Cloth Collection</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card latest-product-card mb-4">
                        <div class="card-body text-center">
                            <img src="img/kit.jpg" class="w-100" height="140px" alt="Beauty">
                            <p>Kitchen Collection</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Latest Product Module -->
    </section>
<%@ include file="footer.jsp"%>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
