<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        /* Global Styles */
        body {
            font-family: 'Roboto', sans-serif;
            background: url('https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: #f8f9fa;
            min-height: 100vh;
            position: relative;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1;
            margin-top: -89px;
        }

        .container {
            position: relative;
            z-index: 2;
            max-width: 800px;
            padding-top: 5rem;
            padding-bottom: 2rem;
        }

        .card {
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(20px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            width: 700px;
            margin-left: -90px;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.5);
        }

        .card-header {
            background-color: #8a8583;
            color: white;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            padding: 1rem;
            border-radius: 15px 15px 0 0;
            text-transform: uppercase;
        }

        .card-body {
            padding: 2rem;
        }

        .form-label {
            color: #f8f9fa;
        }

        input, textarea, select {
            background-color: rgba(255, 255, 255, 0.9);
            border: 1px solid #ccc;
            color: #333;
            transition: all 0.3s ease;
        }

        input:hover, textarea:hover, select:hover {
            border-color: #6c63ff;
            box-shadow: 0 0 5px rgba(108, 99, 255, 0.5);
        }

        input:focus, textarea:focus, select:focus {
            border-color: #6c63ff;
            box-shadow: none;
        }

        .btn-primary {
            background-color: #8a8583;
            border: none;
            padding: 0.75rem;
            font-size: 1rem;
            font-weight: bold;
            width: 100%;
            border-radius: 10px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #574bfc;
            transform: translateY(-5px);
        }

        .text-success, .text-danger {
            font-weight: bold;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
        }
    </style>
</head>

<body>

    <!-- Dark Overlay -->
    <div class="overlay"></div>

    <!-- Add Product Form -->
    <section>
        <div class="container p-5 mt-3">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header">
                            Add Product
                        </div>

                        <!-- Success/Error Messages -->
                        <div class="card-body">
                            <!-- Check for success message -->
                            <c:if test="${not empty sessionScope.succMsg}">
                                <p class="text-success">${sessionScope.succMsg}</p>
                            </c:if>

                            <!-- Check for error message -->
                            <c:if test="${not empty sessionScope.errorMsg}">
                                <p class="text-danger">${sessionScope.errorMsg}</p>
                            </c:if>

                            <!-- Form -->
                            <form id="productForm" action="${pageContext.request.contextPath}/admin/saveProduct" method="post" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <label class="form-label">Enter Title</label>
                                    <input type="text" name="title" class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Enter Description</label>
                                    <textarea rows="3" class="form-control" name="description" required></textarea>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Category</label>
                                    <select class="form-select" name="category" required>
                                        <option value="">--select--</option>
                                        <c:forEach var="c" items="${categories}">
                                            <option value="${c.id}">${c.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Enter Price</label>
                                    <input type="number" name="price" class="form-control" step="0.01" required>
                                </div>

                             <div class="mb-3">
    <label class="form-label" style="margin-right: 30px;">Status</label> <!-- Added margin-right for space -->
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" value="true" name="isActive" id="activeRadio" checked>
        <label class="form-check-label" for="activeRadio">Active</label>
    </div>
    <div class="form-check form-check-inline" style="margin-left: 20px;">
        <input class="form-check-input" type="radio" value="false" name="isActive" id="inactiveRadio">
        <label class="form-check-label" for="inactiveRadio">Inactive</label>
    </div>
</div>



                                <div class="row">
                                    <div class="mb-3 col-md-6">
                                        <label class="form-label">Enter Stock</label>
                                        <input type="number" name="stock" class="form-control" required>
                                    </div>

                                    <div class="mb-3 col-md-6">
                                        <label class="form-label">Upload Image</label>
                                        <input type="file" name="file" class="form-control">
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JS for validation -->
    <script>
        document.getElementById('productForm').addEventListener('submit', function(event) {
            var title = document.querySelector('input[name="title"]').value;
            var description = document.querySelector('textarea[name="description"]').value;
            var category = document.querySelector('select[name="category"]').value;
            var price = document.querySelector('input[name="price"]').value;
            var stock = document.querySelector('input[name="stock"]').value;

            if (!title || !description || !category || !price || !stock) {
                event.preventDefault(); // Prevent form submission
                alert('Please fill out all required fields.');
            }
        });
    </script>

</body>

</html>
