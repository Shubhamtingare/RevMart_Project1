package com.revature.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.revature.model.UserDetails;


public interface UserRepo extends JpaRepository<UserDetails, Integer> {

	public UserDetails findByEmail(String email);

	public List<UserDetails> findByRole(String role);

	public UserDetails findByResetToken(String token);

	public Boolean existsByEmail(String email);
}

