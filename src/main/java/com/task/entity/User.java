package com.task.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author: hbw
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String id;
    private String name;
    private String sex;
    private String age;
    private String username;
    private String password;
    private String identity;


    public User(String id,String name,String username,String password,String identity){
        this.id = id;
        this.name = name;
        this.username = username;
        this.password = password;
        this.identity = identity;
    }

}
