package com.revature.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.revature.model.Category;
import com.revature.model.Product;
import com.revature.model.ProductOrder;
import com.revature.model.UserDetails;
import com.revature.service.CartService;
import com.revature.service.CategoryService;
import com.revature.service.OrderService;
import com.revature.service.ProductService;
import com.revature.service.UserService;
import com.revature.utils.MailServiceHelper;
import com.revature.utils.OrderStatus;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class Controller_Admin {

	private static final Logger logger = LoggerFactory.getLogger(Controller_Admin.class);

	@Autowired
	private UserService userService;

	@Autowired
	private CartService cartService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ProductService productService;

	@Autowired
	private MailServiceHelper mailHelper;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@ModelAttribute
	public void getUserDetails(Principal p, Model m) {
		if (p != null) {
			String email = p.getName();
			logger.info("Fetching user details for email: {}", email);
			UserDetails userDtls = userService.getUserByEmail(email);
			m.addAttribute("user", userDtls);
			Integer countCart = cartService.getCountCart(userDtls.getId());
			m.addAttribute("countCart", countCart);
		}

		List<Category> allActiveCategory = categoryService.getAllActiveCategory();
		m.addAttribute("categorys", allActiveCategory);
	}

	@GetMapping("/")
	public String index() {
		logger.info("Loading admin home page");
		return "adminHome";
	}

	@GetMapping("/loadAddProduct")
	public String loadAddProduct(Model m) {
		logger.info("Loading add product page");
		List<Category> categories = categoryService.getAllCategory();
		m.addAttribute("categories", categories);
		return "addProduct";
	}

	@GetMapping("/category")
	public String category(Model m, @RequestParam(name = "pageNo", defaultValue = "0") Integer pageNo,
			@RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize) {
		logger.info("Loading category page with pagination pageNo: {}, pageSize: {}", pageNo, pageSize);
		Page<Category> page = categoryService.getAllCategorPagination(pageNo, pageSize);
		List<Category> categorys = page.getContent();
		m.addAttribute("categorys", categorys);
		m.addAttribute("pageNo", page.getNumber());
		m.addAttribute("pageSize", pageSize);
		m.addAttribute("totalElements", page.getTotalElements());
		m.addAttribute("totalPages", page.getTotalPages());
		m.addAttribute("isFirst", page.isFirst());
		m.addAttribute("isLast", page.isLast());
		return "category";
	}

	@PostMapping("/saveCategory")
	public String saveCategory(@ModelAttribute Category category, @RequestParam("file") MultipartFile file,
			HttpSession session) throws IOException {
		logger.info("Saving new category: {}", category.getName());
		String imageName = file != null ? file.getOriginalFilename() : "default.jpg";
		category.setImageName(imageName);

		Boolean existCategory = categoryService.existCategory(category.getName());

		if (existCategory) {
			session.setAttribute("errorMsg", "Category Name already exists");
			logger.warn("Category already exists: {}", category.getName());
		} else {
			Category saveCategory = categoryService.saveCategory(category);

			if (ObjectUtils.isEmpty(saveCategory)) {
				session.setAttribute("errorMsg", "Not saved! Internal server error");
				logger.error("Failed to save category: {}", category.getName());
			} else {
				File saveFile = new ClassPathResource("static/img").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + "category_img" + File.separator
						+ file.getOriginalFilename());
				Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
				session.setAttribute("succMsg", "Saved successfully");
				logger.info("Category saved successfully: {}", category.getName());
			}
		}
		return "redirect:/admin/category";
	}

	@GetMapping("/deleteCategory/{id}")
	public String deleteCategory(@PathVariable int id, HttpSession session) {
		logger.info("Deleting category with id: {}", id);
		Boolean deleteCategory = categoryService.deleteCategory(id);

		if (deleteCategory) {
			session.setAttribute("succMsg", "Category deleted successfully");
			logger.info("Category deleted successfully with id: {}", id);
		} else {
			session.setAttribute("errorMsg", "Something went wrong on the server");
			logger.error("Failed to delete category with id: {}", id);
		}

		return "redirect:/admin/category";
	}

	@GetMapping("/loadEditCategory/{id}")
	public String loadEditCategory(@PathVariable int id, Model m) {
		logger.info("Loading edit category page for category id: {}", id);
		m.addAttribute("category", categoryService.getCategoryById(id));
		return "updateCategory";
	}

	@PostMapping("/updateCategory")
	public String updateCategory(@ModelAttribute Category category, @RequestParam("file") MultipartFile file,
			HttpSession session) throws IOException {
		logger.info("Updating category with id: {}", category.getId());
		Category oldCategory = categoryService.getCategoryById(category.getId());
		String imageName = file.isEmpty() ? oldCategory.getImageName() : file.getOriginalFilename();

		if (!ObjectUtils.isEmpty(category)) {
			oldCategory.setName(category.getName());
			oldCategory.setIsActive(category.getIsActive());
			oldCategory.setImageName(imageName);
		}

		Category updateCategory = categoryService.saveCategory(oldCategory);

		if (!ObjectUtils.isEmpty(updateCategory)) {
			if (!file.isEmpty()) {
				File saveFile = new ClassPathResource("static/img").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + "category_img" + File.separator
						+ file.getOriginalFilename());
				Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
			}
			session.setAttribute("succMsg", "Category updated successfully");
			logger.info("Category updated successfully with id: {}", category.getId());
		} else {
			session.setAttribute("errorMsg", "Something went wrong on the server");
			logger.error("Failed to update category with id: {}", category.getId());
		}
		return "redirect:/admin/loadEditCategory/" + category.getId();
	}

	// Add logging for all the remaining methods similarly
	@PostMapping("/saveProduct")
	public String saveProduct(@ModelAttribute Product product, @RequestParam("file") MultipartFile image,
			HttpSession session) throws IOException {
		logger.info("Saving new product: {}", product.getTitle());
		String imageName = image.isEmpty() ? "default.jpg" : image.getOriginalFilename();
		product.setImage(imageName);
		product.setDiscount(0);
		product.setDiscountPrice(product.getPrice());
		Product saveProduct = productService.saveProduct(product);

		if (!ObjectUtils.isEmpty(saveProduct)) {
			File saveFile = new ClassPathResource("static/img").getFile();
			Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + "product_img" + File.separator
					+ image.getOriginalFilename());
			Files.copy(image.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
			session.setAttribute("succMsg", "Product saved successfully");
			logger.info("Product saved successfully: {}", product.getTitle());
		} else {
			session.setAttribute("errorMsg", "Something went wrong on the server");
			logger.error("Failed to save product: {}", product.getTitle());
		}
		return "redirect:/admin/loadAddProduct";
	}


	@GetMapping("/products")
	public String loadViewProduct(Model m, @RequestParam(defaultValue = "") String ch,
	        @RequestParam(name = "pageNo", defaultValue = "0") Integer pageNo,
	        @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize) {

	    logger.info("Fetching products with search criteria: '{}' at page number: {}, page size: {}", ch, pageNo, pageSize);

	    Page<Product> page = null;
	    if (ch != null && ch.length() > 0) {
	        page = productService.searchProductPagination(pageNo, pageSize, ch);
	        logger.info("Fetched products based on search criteria: {}", ch);
	    } else {
	        page = productService.getAllProductsPagination(pageNo, pageSize);
	        logger.info("Fetched all products without search criteria");
	    }

	    m.addAttribute("products", page.getContent());
	    m.addAttribute("pageNo", page.getNumber());
	    m.addAttribute("pageSize", pageSize);
	    m.addAttribute("totalElements", page.getTotalElements());
	    m.addAttribute("totalPages", page.getTotalPages());
	    m.addAttribute("isFirst", page.isFirst());
	    m.addAttribute("isLast", page.isLast());

	    logger.info("Returning product view with {} products", page.getContent().size());
	    return "products";
	}

	@GetMapping("/deleteProduct/{id}")
	public String deleteProduct(@PathVariable int id, HttpSession session) {
	    logger.info("Attempting to delete product with ID: {}", id);
	    Boolean deleteProduct = productService.deleteProduct(id);
	    if (deleteProduct) {
	        session.setAttribute("succMsg", "Product delete success");
	        logger.info("Product with ID: {} deleted successfully", id);
	    } else {
	        session.setAttribute("errorMsg", "Something wrong on server");
	        logger.error("Failed to delete product with ID: {}", id);
	    }
	    return "redirect:/admin/products";
	}

	@GetMapping("/editProduct/{id}")
	public String editProduct(@PathVariable int id, Model m) {
	    logger.info("Loading edit product page for product ID: {}", id);
	    m.addAttribute("product", productService.getProductById(id));
	    m.addAttribute("categories", categoryService.getAllCategory());
	    logger.info("Loaded product details and categories for editing");
	    return "updateProduct";
	}

	@PostMapping("/updateProduct")
	public String updateProduct(@ModelAttribute Product product, @RequestParam("file") MultipartFile image,
	        HttpSession session, Model m) {

	    logger.info("Attempting to update product with ID: {}", product.getId());

	    if (product.getDiscount() < 0 || product.getDiscount() > 100) {
	        session.setAttribute("errorMsg", "Invalid Discount");
	        logger.warn("Invalid discount for product ID: {}", product.getId());
	    } else {
	        Product updateProduct = productService.updateProduct(product, image);
	        if (!ObjectUtils.isEmpty(updateProduct)) {
	            session.setAttribute("succMsg", "Product update success");
	            logger.info("Product with ID: {} updated successfully", product.getId());
	        } else {
	            session.setAttribute("errorMsg", "Something wrong on server");
	            logger.error("Failed to update product with ID: {}", product.getId());
	        }
	    }
	    return "redirect:/admin/editProduct/" + product.getId();
	}

	@GetMapping("/users")
	public String getAllUsers(Model m, @RequestParam Integer type) {
	    logger.info("Fetching all users of type: {}", type == 1 ? "ROLE_USER" : "ROLE_ADMIN");
	    List<UserDetails> users = null;
	    if (type == 1) {
	        users = userService.getUsers("ROLE_USER");
	    } else {
	        users = userService.getUsers("ROLE_ADMIN");
	    }
	    m.addAttribute("userType", type);
	    m.addAttribute("users", users);
	    logger.info("Fetched {} users of type {}", users.size(), type == 1 ? "ROLE_USER" : "ROLE_ADMIN");
	    return "users";
	}

	@GetMapping("/updateSts")
	public String updateUserAccountStatus(@RequestParam Boolean status, @RequestParam Integer id, 
	        @RequestParam Integer type, HttpSession session) {
	    logger.info("Updating account status for user ID: {} to {}", id, status ? "active" : "inactive");
	    Boolean f = userService.updateAccountStatus(id, status);
	    if (f) {
	        session.setAttribute("succMsg", "Account Status Updated");
	        logger.info("Account status for user ID: {} updated successfully", id);
	    } else {
	        session.setAttribute("errorMsg", "Something wrong on server");
	        logger.error("Failed to update account status for user ID: {}", id);
	    }
	    return "redirect:/admin/users?type=" + type;
	}

	
	
	
	@GetMapping("/orders")
	public String getAllOrders(Model m, @RequestParam(name = "pageNo", defaultValue = "0") Integer pageNo,
	        @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize) {
	    logger.info("Fetching all orders with pageNo: {}, pageSize: {}", pageNo, pageSize);
	    Page<ProductOrder> page = orderService.getAllOrdersPagination(pageNo, pageSize);
	    m.addAttribute("orders", page.getContent());
	    m.addAttribute("srch", false);

	    m.addAttribute("pageNo", page.getNumber());
	    m.addAttribute("pageSize", pageSize);
	    m.addAttribute("totalElements", page.getTotalElements());
	    m.addAttribute("totalPages", page.getTotalPages());
	    m.addAttribute("isFirst", page.isFirst());
	    m.addAttribute("isLast", page.isLast());

	    logger.info("Returned orders view with {} orders", page.getContent().size());
	    return "orders";
	}

	@PostMapping("/update-order-status")
	public String updateOrderStatus(@RequestParam Integer id, @RequestParam Integer st, HttpSession session) {
	    logger.info("Updating order status for order ID: {} to status: {}", id, st);

	    OrderStatus[] values = OrderStatus.values();
	    String status = null;

	    for (OrderStatus orderSt : values) {
	        if (orderSt.getId().equals(st)) {
	            status = orderSt.getName();
	        }
	    }

	    ProductOrder updateOrder = orderService.updateOrderStatus(id, status);

	    try {
	        mailHelper.sendMailForProductOrder(updateOrder, status);
	        logger.info("Sent mail for order ID: {} with updated status: {}", id, status);
	    } catch (Exception e) {
	        logger.error("Error sending mail for order ID: {}", id, e);
	    }

	    if (!ObjectUtils.isEmpty(updateOrder)) {
	        session.setAttribute("succMsg", "Status Updated");
	        logger.info("Order ID: {} status updated successfully", id);
	    } else {
	        session.setAttribute("errorMsg", "Status not updated");
	        logger.error("Failed to update order status for order ID: {}", id);
	    }
	    return "redirect:/admin/orders";
	}

	@GetMapping("/search-order")
	public String searchProduct(@RequestParam String orderId, Model m, HttpSession session,
	        @RequestParam(name = "pageNo", defaultValue = "0") Integer pageNo,
	        @RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize) {

	    logger.info("Searching for order with orderId: {}", orderId);

	    if (orderId != null && orderId.length() > 0) {
	        ProductOrder order = orderService.getOrdersByOrderId(orderId.trim());

	        if (ObjectUtils.isEmpty(order)) {
	            session.setAttribute("errorMsg", "Incorrect orderId");
	            m.addAttribute("orderDtls", null);
	            logger.warn("No order found with orderId: {}", orderId);
	        } else {
	            m.addAttribute("orderDtls", order);
	            logger.info("Order found with orderId: {}", orderId);
	        }

	        m.addAttribute("srch", true);
	    } else {
	        Page<ProductOrder> page = orderService.getAllOrdersPagination(pageNo, pageSize);
	        m.addAttribute("orders", page);
	        m.addAttribute("srch", false);

	        m.addAttribute("pageNo", page.getNumber());
	        m.addAttribute("pageSize", pageSize);
	        m.addAttribute("totalElements", page.getTotalElements());
	        m.addAttribute("totalPages", page.getTotalPages());
	        m.addAttribute("isFirst", page.isFirst());
	        m.addAttribute("isLast", page.isLast());

	        logger.info("Returned paginated orders with pageNo: {}", pageNo);
	    }
	    return "orders";
	}

	@GetMapping("/add-admin")
	public String loadAdminAdd() {
	    logger.info("Loading add admin page");
	    return "addAdmin";
	}

	@PostMapping("/save-admin")
	public String saveAdmin(@ModelAttribute UserDetails user, @RequestParam("img") MultipartFile file, HttpSession session)
	        throws IOException {

	    logger.info("Saving admin user: {}", user.getEmail());

	    String imageName = file.isEmpty() ? "default.jpg" : file.getOriginalFilename();
	    user.setProfileImage(imageName);
	    UserDetails saveUser = userService.saveAdmin(user);

	    if (!ObjectUtils.isEmpty(saveUser)) {
	        if (!file.isEmpty()) {
	            File saveFile = new ClassPathResource("static/img").getFile();
	            Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + "profile_img" + File.separator
	                    + file.getOriginalFilename());
	            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
	        }
	        session.setAttribute("succMsg", "Register successfully");
	        logger.info("Admin user {} registered successfully", user.getEmail());
	    } else {
	        session.setAttribute("errorMsg", "Something wrong on server");
	        logger.error("Failed to register admin user: {}", user.getEmail());
	    }

	    return "redirect:/admin/add-admin";
	}

	@GetMapping("/profile")
	public String profile() {
	    logger.info("Loading admin profile page");
	    return "adminProfile";
	}

	@PostMapping("/update-profile")
	public String updateProfile(@ModelAttribute UserDetails user, @RequestParam MultipartFile img, HttpSession session) {
	    logger.info("Updating profile for user: {}", user.getEmail());

	    UserDetails updateUserProfile = userService.updateUserProfile(user, img);
	    if (ObjectUtils.isEmpty(updateUserProfile)) {
	        session.setAttribute("errorMsg", "Profile not updated");
	        logger.error("Failed to update profile for user: {}", user.getEmail());
	    } else {
	        session.setAttribute("succMsg", "Profile Updated");
	        logger.info("Profile updated for user: {}", user.getEmail());
	    }
	    return "redirect:/admin/adminProfile";
	}

	@PostMapping("/change-password")
	public String changePassword(@RequestParam String newPassword, @RequestParam String currentPassword, Principal p,
	        HttpSession session) {
	    UserDetails loggedInUserDetails = mailHelper.getLoggedInUserDetails(p);
	    logger.info("Attempting password change for user: {}", loggedInUserDetails.getEmail());

	    boolean matches = passwordEncoder.matches(currentPassword, loggedInUserDetails.getPassword());

	    if (matches) {
	        String encodePassword = passwordEncoder.encode(newPassword);
	        loggedInUserDetails.setPassword(encodePassword);
	        UserDetails updateUser = userService.updateUser(loggedInUserDetails);
	        if (ObjectUtils.isEmpty(updateUser)) {
	            session.setAttribute("errorMsg", "Password not updated !! Error in server");
	            logger.error("Failed to update password for user: {}", loggedInUserDetails.getEmail());
	        } else {
	            session.setAttribute("succMsg", "Password Updated successfully");
	            logger.info("Password updated for user: {}", loggedInUserDetails.getEmail());
	        }
	    } else {
	        session.setAttribute("errorMsg", "Current Password incorrect");
	        logger.warn("Incorrect current password for user: {}", loggedInUserDetails.getEmail());
	    }

	    return "redirect:/admin/adminProfile";
	}

}
