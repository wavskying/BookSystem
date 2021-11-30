package com.task.dao;

import com.task.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: hbw
 **/
@Repository
public interface UserDao {

    public int addUser(@Param("user") User user);

    public User selectUser(@Param("username") String username, @Param("password") String password);

    public List<User> selectUsers(@Param("user") User user,@Param("start") int start,@Param("end") int end);

    public int selectCount(@Param("user") User user);

    public int deleteUser(@Param("id") String id);

    public int update(@Param("user") User user);

}
