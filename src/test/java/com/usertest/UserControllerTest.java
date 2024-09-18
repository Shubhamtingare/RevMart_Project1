package com.revature.usertest;



import org.junit.jupiter.api.Test;

import com.revature.controller.UserController;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class UserControllerTest {

    private UserController userController = new UserController();

    @Test
    void testHome() {
        String viewName = userController.home();
        assertEquals("userHome", viewName);
    }
    
}
