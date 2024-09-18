<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        /* Global Styles */
        body {
            font-family: 'Roboto', sans-serif;
            background: url('https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: #f8f9fa;
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.65);
            z-index: 1;
            
        }

        .container {
            position: relative;
            z-index: 2;
            max-width: 1200px;
            padding-top: 5rem;
            padding: 20px;
        }

        /* Header Styling */
        .dashboard-title {
            font-size: 3rem;
            color: #fff;
            font-weight: bold;
            text-transform: uppercase;
            text-align: center;
            letter-spacing: 2px;
            margin-bottom: 2rem;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
            position: relative;
            z-index: 2;
            margin-right:-350px;
        }

        .dashboard-title span {
            color: #FFBF00;
            text-shadow: 2px 2px 10px rgba(0, 255, 255, 0.5);
        }

        /* Card Design */
        .row {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 40px;
            flex-wrap: wrap;
            margin-right:-350px;
        }

        .card {
            width: 250px;
            height: 200px;
            border-radius: 15px;
            border: none;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.25);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            cursor: pointer;
            
            
            
            
        }

        .card:hover {
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 20px 30px rgba(0, 0, 0, 0.4);
        }

        .card-body {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: #fff;
        }

        .card-body i {
            font-size: 3rem;
            color: #17a2b8;
            margin-bottom: 15px;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .card:hover i {
            transform: scale(1.2);
            color: #ffc107;
        }

        .card-body h4 {
            font-size: 1.4rem;
            font-weight: bold;
            text-transform: uppercase;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);
            margin-bottom: 10px;
        }

        /* Tooltip Styling */
        .tooltip-custom {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0, 0, 0, 0.7);
            color: #fff;
            padding: 5px 12px;
            font-size: 0.8rem;
            border-radius: 5px;
            display: none;
            text-align: center;
        }

        .card:hover .tooltip-custom {
            display: block;
        }

        /* Animation for Cards */
        .card-body {
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Button hover effect */
        a.text-decoration-none:hover {
            text-decoration: none;
            opacity: 0.85;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .container {
                max-width: 100%;
                padding: 0 20px;
            }

            .card {
                width: 100%;
                margin-bottom: 20px;
            }
        }
    </style>
</head>

<body>


    <!-- Dark Overlay -->
    <div class="overlay"></div>
    
    <div>
 <jsp:include page="navbar.jsp"></jsp:include>
</div>

    <!-- Dashboard Content -->
    <section>
        <div class="container p-5 mt-3">
            <p class="dashboard-title"> <span> Admin Dashboard</span></p>

            <!-- First row -->
            <div class="row">
                <!-- Add Product -->
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/loadAddProduct" class="text-decoration-none">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-box"></i>
                                <h4>Add Product</h4>
                            </div>
                        </div>
                    </a>
                </div>

                <!-- Add Category -->
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/category" class="text-decoration-none">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-tags"></i>
                                <h4>Add Category</h4>
                              <!--  <div class="tooltip-custom">Manage product categories</div>-->
                            </div>
                        </div>
                    </a>
                </div>

                <!-- View Products -->
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/products" class="text-decoration-none">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-boxes"></i>
                                <h4>View Products</h4>
                               <!-- <div class="tooltip-custom">View and manage all products</div>-->
                            </div>
                        </div>
                    </a>
                </div>

                <!-- Orders -->
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/orders" class="text-decoration-none">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-truck"></i>
                                <h4>Orders</h4>
                               <!-- <div class="tooltip-custom">View customer orders</div> -->
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Second row -->
            <div class="row">
                <!-- Users -->
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/users?type=1" class="text-decoration-none">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-users"></i>
                                <h4>Users</h4>
                            </div>
                        </div>
                    </a>
                </div>

                <!-- Add Admin -->
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/add-admin" class="text-decoration-none">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-user-shield"></i>
                                <h4>Add Admin</h4>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/admin/users?type=2" class="text-decoration-none">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="fas fa-user-tie"></i>
                                <h4>Admin</h4>
                            </div>
                        </div>
                    </a>
                </div>
            </div>

        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>

</html>
