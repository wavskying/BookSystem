package com.task.service.impl;

import com.task.dao.UserDao;
import com.task.entity.User;
import com.task.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * @author: hbw
 **/
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;
    @Override
    public User isLogin(String username, String password) {
        User user = userDao.selectUser(username,password);
        return user;
    }

    @Override
    public int addUser(User user) {
        return userDao.addUser(user);
    }

    @Override
    public int deleteUser(String id) {
        return userDao.deleteUser(id);
    }

    @Override
    public int updateUser(User user) {
        return userDao.update(user);
    }

    @Override
    public List<User> selectUsers(User user,int start,int end) {
        return userDao.selectUsers(user,start,end);
    }

    @Override
    public int selectCount(User user) {
        return userDao.selectCount(user);
    }

}
