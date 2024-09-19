package com.revature.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.revature.model.Cart;


public interface CartRepo extends JpaRepository<Cart, Integer> {

	public Cart findByProductIdAndUserId(Integer productId, Integer userId);

	public Integer countByUserId(Integer userId);

	public List<Cart> findByUserId(Integer userId);

	public void deleteByUserId(Integer userId);

}

