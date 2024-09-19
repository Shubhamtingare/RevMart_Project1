package com.revature.controller;

import java.security.Principal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.revature.model.Cart;
import com.revature.model.Category;
import com.revature.model.OrderRequest;
import com.revature.model.ProductOrder;
import com.revature.model.UserDetails;
import com.revature.service.CartService;
import com.revature.service.CategoryService;
import com.revature.service.OrderService;
import com.revature.service.UserService;
import com.revature.utils.MailServiceHelper;
import com.revature.utils.OrderStatus;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/user")
public class Controller_User {

    private static final Logger logger = LoggerFactory.getLogger(Controller_User.class);

    @Autowired
    private UserService userService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private CartService cartService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private MailServiceHelper mailHelper;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/")
    public String home() {
        logger.info("Navigating to user home page");
        return "userHome";
    }

    @ModelAttribute
    public void getUserDetails(Principal p, Model m) {
        if (p != null) {
            String email = p.getName();
            UserDetails userDetails = userService.getUserByEmail(email);
            m.addAttribute("user", userDetails);
            Integer countCart = cartService.getCountCart(userDetails.getId());
            m.addAttribute("countCart", countCart);
            logger.info("Loaded user details for email: {}", email);
        }
        List<Category> allActiveCategory = categoryService.getAllActiveCategory();
        m.addAttribute("categorys", allActiveCategory);
        logger.info("Loaded all active categories");
    }

    @GetMapping("/addCart")
    public String addToCart(@RequestParam Integer pid, @RequestParam Integer uid, HttpSession session) {
        logger.info("Adding product with ID {} to cart for user ID {}", pid, uid);
        Cart saveCart = cartService.saveCart(pid, uid);
        if (ObjectUtils.isEmpty(saveCart)) {
            session.setAttribute("errorMsg", "Product add to cart failed");
            logger.warn("Failed to add product to cart for user ID {}", uid);
        } else {
            session.setAttribute("succMsg", "Product added to cart");
            logger.info("Product added to cart successfully for user ID {}", uid);
        }
        return "redirect:/product/" + pid;
    }

    @GetMapping("/cart")
    public String loadCartPage(Principal p, Model m) {
        UserDetails user = getLoggedInUserDetails(p);
        logger.info("Loading cart page for user {}", user.getEmail());
        List<Cart> carts = cartService.getCartsByUser(user.getId());
        m.addAttribute("carts", carts);
        if (carts.size() > 0) {
            Double totalOrderPrice = carts.get(carts.size() - 1).getTotalOrderPrice();
            m.addAttribute("totalOrderPrice", totalOrderPrice);
        }
        return "cart";
    }

    @GetMapping("/cartQuantityUpdate")
    public String updateCartQuantity(@RequestParam String sy, @RequestParam Integer cid) {
        logger.info("Updating quantity for cart ID {} with operation {}", cid, sy);
        cartService.updateQuantity(sy, cid);
        return "redirect:/user/cart";
    }

    @GetMapping("/orders")
    public String orderPage(Principal p, Model m) {
        UserDetails user = getLoggedInUserDetails(p);
        logger.info("Loading order page for user {}", user.getEmail());
        List<Cart> carts = cartService.getCartsByUser(user.getId());
        m.addAttribute("carts", carts);
        if (carts.size() > 0) {
            Double orderPrice = carts.get(carts.size() - 1).getTotalOrderPrice();
            Double totalOrderPrice = carts.get(carts.size() - 1).getTotalOrderPrice() + 250 + 100;
            m.addAttribute("orderPrice", orderPrice);
            m.addAttribute("totalOrderPrice", totalOrderPrice);
        }
        return "order";
    }

    @PostMapping("/save-order")
    public String saveOrder(@ModelAttribute OrderRequest request, Principal p) throws Exception {
        UserDetails user = getLoggedInUserDetails(p);
        logger.info("Saving order for user ID {}", user.getId());
        orderService.saveOrder(user.getId(), request);
        cartService.clearCart(user.getId());
        logger.info("Order placed and cart cleared for user ID {}", user.getId());
        return "redirect:/user/success";
    }

    @GetMapping("/success")
    public String loadSuccess() {
        logger.info("Loading success page");
        return "success";
    }

    @GetMapping("/user-orders")
    public String myOrder(Model m, Principal p) {
        UserDetails loginUser = getLoggedInUserDetails(p);
        logger.info("Loading order history for user ID {}", loginUser.getId());
        List<ProductOrder> orders = orderService.getOrdersByUser(loginUser.getId());
        m.addAttribute("orders", orders);
        return "myOrders";
    }

    @GetMapping("/update-status")
    public String updateOrderStatus(@RequestParam Integer id, @RequestParam Integer st, HttpSession session) {
        OrderStatus[] values = OrderStatus.values();
        String status = null;
        for (OrderStatus orderSt : values) {
            if (orderSt.getId().equals(st)) {
                status = orderSt.getName();
            }
        }
        logger.info("Updating order status for order ID {} to status {}", id, status);
        ProductOrder updateOrder = orderService.updateOrderStatus(id, status);

        try {
            mailHelper.sendMailForProductOrder(updateOrder, status);
            logger.info("Mail sent for order ID {} with status {}", id, status);
        } catch (Exception e) {
            logger.error("Failed to send mail for order ID {} with status {}", id, status, e);
        }

        if (!ObjectUtils.isEmpty(updateOrder)) {
            session.setAttribute("succMsg", "Status Updated");
            logger.info("Order status updated for order ID {}", id);
        } else {
            session.setAttribute("errorMsg", "Status not updated");
            logger.warn("Failed to update status for order ID {}", id);
        }
        return "redirect:/user/user-orders";
    }

    @GetMapping("/profile")
    public String profile() {
        logger.info("Loading user profile page");
        return "userProfile";
    }

    @PostMapping("/update-profile")
    public String updateProfile(@ModelAttribute UserDetails user, @RequestParam MultipartFile img, HttpSession session) {
        logger.info("Updating profile for user ID {}", user.getId());
        UserDetails updateUserProfile = userService.updateUserProfile(user, img);
        if (ObjectUtils.isEmpty(updateUserProfile)) {
            session.setAttribute("errorMsg", "Profile not updated");
            logger.warn("Failed to update profile for user ID {}", user.getId());
        } else {
            session.setAttribute("succMsg", "Profile Updated");
            logger.info("Profile updated successfully for user ID {}", user.getId());
        }
        return "redirect:/user/userProfile";
    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam String newPassword, @RequestParam String currentPassword, Principal p,
            HttpSession session) {
        UserDetails loggedInUserDetails = getLoggedInUserDetails(p);
        logger.info("Changing password for user ID {}", loggedInUserDetails.getId());

        boolean matches = passwordEncoder.matches(currentPassword, loggedInUserDetails.getPassword());

        if (matches) {
            String encodePassword = passwordEncoder.encode(newPassword);
            loggedInUserDetails.setPassword(encodePassword);
            UserDetails updateUser = userService.updateUser(loggedInUserDetails);
            if (ObjectUtils.isEmpty(updateUser)) {
                session.setAttribute("errorMsg", "Password not updated!! Error in server");
                logger.error("Failed to update password for user ID {}", loggedInUserDetails.getId());
            } else {
                session.setAttribute("succMsg", "Password Updated successfully");
                logger.info("Password updated successfully for user ID {}", loggedInUserDetails.getId());
            }
        } else {
            session.setAttribute("errorMsg", "Current Password incorrect");
            logger.warn("Current password incorrect for user ID {}", loggedInUserDetails.getId());
        }

        return "redirect:/user/userProfile";
    }

    private UserDetails getLoggedInUserDetails(Principal p) {
        String email = p.getName();
        logger.info("Fetching user details for email: {}", email);
        return userService.getUserByEmail(email);
    }
}
