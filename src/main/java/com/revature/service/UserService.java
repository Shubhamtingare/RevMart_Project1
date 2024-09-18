package com.revature.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.revature.model.UserDetails;


public interface UserService {

	public UserDetails saveUser(UserDetails user);

	public UserDetails getUserByEmail(String email);

	public List<UserDetails> getUsers(String role);

	public Boolean updateAccountStatus(Integer id, Boolean status);

	public void increaseFailedAttempt(UserDetails user);

	public void userAccountLock(UserDetails user);

	public boolean unlockAccountTimeExpired(UserDetails user);

	public void resetAttempt(int userId);

	public void updateUserResetToken(String email, String resetToken);

	public UserDetails getUserByToken(String token);

	public UserDetails updateUser(UserDetails user);

	public UserDetails updateUserProfile(UserDetails user, MultipartFile img);

	public UserDetails saveAdmin(UserDetails user);

	public Boolean existsEmail(String email);

}
