package com.task.service;

import com.task.dao.UserDao;
import com.task.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author: hbw
 **/
public interface UserService {

    public User isLogin(String username, String password);

    public int addUser(User user);

    public int deleteUser(String id);

    public int updateUser(User user);

    public List<User> selectUsers(User user,int start,int end);

    public int selectCount(User user);




}
