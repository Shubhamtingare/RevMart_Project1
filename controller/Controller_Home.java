package com.revature.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.List;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.revature.model.Category;
import com.revature.model.Product;
import com.revature.model.UserDetails;
import com.revature.service.CartService;
import com.revature.service.CategoryService;
import com.revature.service.ProductService;
import com.revature.service.UserService;
import com.revature.utils.MailServiceHelper;

import io.micrometer.common.util.StringUtils;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class Controller_Home {

    // Add the logger
    private static final Logger logger = LoggerFactory.getLogger(Controller_Home.class);

    @Autowired
    private UserService userService;
    
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private MailServiceHelper mailHelper;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    private CartService cartService;

    @ModelAttribute
    public void getUserDetails(Principal p, Model m) {
        if (p != null) {
            String email = p.getName();
            UserDetails userDetails = userService.getUserByEmail(email);
            m.addAttribute("user", userDetails);
            Integer countCart = cartService.getCountCart(userDetails.getId());
            m.addAttribute("countCart", countCart);
        }

        List<Category> allActiveCategory = categoryService.getAllActiveCategory();
        m.addAttribute("categorys", allActiveCategory);
    }

    @GetMapping("/signin")
    public String login() {
        logger.info("Navigating to login page");
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        logger.info("Navigating to registration page");
        return "register";
    }

    @GetMapping("/")
    public String userHome(Model m) {
        logger.info("Loading user home page");

        List<Category> allActiveCategory = categoryService.getAllActiveCategory().stream()
                .sorted((c1, c2) -> c2.getId().compareTo(c1.getId())).limit(6).toList();
        List<Product> allActiveProducts = productService.getAllActiveProducts("").stream()
                .sorted((p1, p2) -> p2.getId().compareTo(p1.getId())).limit(8).toList();
        m.addAttribute("category", allActiveCategory);
        m.addAttribute("products", allActiveProducts);
        
        logger.debug("Categories: {}", allActiveCategory);
        logger.debug("Products: {}", allActiveProducts);

        return "userHome";
    }

    @GetMapping("/products")
    public String products(Model m, 
        @RequestParam(value = "category", required = false) String category,
        @RequestParam(name = "pageNo", defaultValue = "0") Integer pageNo,
        @RequestParam(name = "pageSize", defaultValue = "12") Integer pageSize,
        @RequestParam(defaultValue = "") String ch) {

        logger.info("Loading products with category: {}, page: {}, pageSize: {}, search: {}", category, pageNo, pageSize, ch);

        List<Category> categories = categoryService.getAllActiveCategory();
        m.addAttribute("paramValue", category);
        m.addAttribute("categories", categories);

        Page<Product> page;
        if (StringUtils.isEmpty(ch)) {
            if (StringUtils.isEmpty(category)) {
                page = productService.getAllActiveProductPagination(pageNo, pageSize, "");
            } else {
                page = productService.getAllActiveProductPagination(pageNo, pageSize, category);
            }
        } else {
            page = productService.searchActiveProductPagination(pageNo, pageSize, category, ch);
        }

        List<Product> products = page.getContent();
        logger.debug("Number of Products: {}", products.size());

        m.addAttribute("products", products);
        m.addAttribute("productsSize", products.size());
        m.addAttribute("pageNo", page.getNumber());
        m.addAttribute("pageSize", pageSize);
        m.addAttribute("totalElements", page.getTotalElements());
        m.addAttribute("totalPages", page.getTotalPages());
        m.addAttribute("isFirst", page.isFirst());
        m.addAttribute("isLast", page.isLast());

        return "product";
    }

    @GetMapping("/product/{id}")
    public String product(@PathVariable int id, Model m) {
        logger.info("Loading product details for product ID: {}", id);
        Product productById = productService.getProductById(id);
        m.addAttribute("product", productById);
        return "viewProduct";
    }

	
	
	
    @PostMapping("/saveUser")
    public String saveUser(@ModelAttribute UserDetails user, @RequestParam("img") MultipartFile file, HttpSession session)
            throws IOException {

        logger.info("Attempting to save user with email: {}", user.getEmail());

        Boolean existsEmail = userService.existsEmail(user.getEmail());

        if (existsEmail) {
            session.setAttribute("errorMsg", "Email already exists");
            logger.warn("User with email {} already exists", user.getEmail());
        } else {
            String imageName = file.isEmpty() ? "default.jpg" : file.getOriginalFilename();
            user.setProfileImage(imageName);
            UserDetails saveUser = userService.saveUser(user);

            if (!ObjectUtils.isEmpty(saveUser)) {
                logger.info("User {} saved successfully", user.getEmail());

                if (!file.isEmpty()) {
                    File saveFile = new ClassPathResource("static/img").getFile();
                    Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + "profile_img" + File.separator
                            + file.getOriginalFilename());
                    Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

                    logger.info("Profile image saved for user {}", user.getEmail());
                }
                session.setAttribute("succMsg", "Register successfully");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server");
                logger.error("Error saving user {}", user.getEmail());
            }
        }

        return "redirect:/register";
    }

    @GetMapping("/forgot-password")
    public String showForgotPassword() {
        logger.info("Navigating to forgot password page");
        return "forgotPassword";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam String email, HttpSession session, HttpServletRequest request)
            throws UnsupportedEncodingException, MessagingException {

        logger.info("Processing forgot password for email: {}", email);

        UserDetails userByEmail = userService.getUserByEmail(email);

        if (ObjectUtils.isEmpty(userByEmail)) {
            session.setAttribute("errorMsg", "Invalid email");
            logger.warn("No user found with email: {}", email);
        } else {
            String resetToken = UUID.randomUUID().toString();
            userService.updateUserResetToken(email, resetToken);
            String url = MailServiceHelper.generateUrl(request) + "/reset-password?token=" + resetToken;
            Boolean sendMail = mailHelper.sendMail(url, email);

            if (sendMail) {
                session.setAttribute("succMsg", "Please check your email. Password reset link sent.");
                logger.info("Password reset email sent to: {}", email);
            } else {
                session.setAttribute("errorMsg", "Something went wrong on server! Email not sent.");
                logger.error("Failed to send password reset email to: {}", email);
            }
        }

        return "redirect:/forgot-password";
    }

    @GetMapping("/reset-password")
    public String showResetPassword(@RequestParam String token, HttpSession session, Model m) {

        logger.info("Loading reset password page for token: {}", token);

        UserDetails userByToken = userService.getUserByToken(token);

        if (userByToken == null) {
            m.addAttribute("msg", "Your link is invalid or expired !!");
            logger.warn("Invalid or expired token: {}", token);
            return "message";
        }
        m.addAttribute("token", token);
        return "resetPassword";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String token, @RequestParam String password, HttpSession session,
            Model m) {

        logger.info("Resetting password for token: {}", token);

        UserDetails userByToken = userService.getUserByToken(token);
        if (userByToken == null) {
            m.addAttribute("errorMsg", "Your link is invalid or expired !!");
            logger.warn("Invalid or expired token: {}", token);
            return "message";
        } else {
            userByToken.setPassword(passwordEncoder.encode(password));
            userByToken.setResetToken(null);
            userService.updateUser(userByToken);
            m.addAttribute("msg", "Password changed successfully");
            logger.info("Password reset successfully for user: {}", userByToken.getEmail());
            return "message";
        }
    }

    @GetMapping("/search")
    public String searchProduct(@RequestParam String ch, Model m) {
        logger.info("Searching for products with keyword: {}", ch);
        List<Product> searchProducts = productService.searchProduct(ch);
        m.addAttribute("products", searchProducts);
        List<Category> categories = categoryService.getAllActiveCategory();
        m.addAttribute("categories", categories);
        return "product";
    }
}

