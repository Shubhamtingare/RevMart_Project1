package com.revature.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.revature.model.Category;


public interface CategoryRepo extends JpaRepository<Category, Integer> {

	public Boolean existsByName(String name);

	public List<Category> findByIsActiveTrue();

}
