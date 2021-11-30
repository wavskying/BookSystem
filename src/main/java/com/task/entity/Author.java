package com.task.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 *@author: hbw
 **/
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Author {
    private int id;
    private String name;
    private String sex;
    private String birthday;
    private String birthArea;
    private String introduction;
    private byte[] image;
    private String photo;
    private List<Book> bookList;

    public Author(int id,String name,String sex,String birthday,String birthArea,String introduction,byte[] image){
        this.id = id;
        this.name = name;
        this.sex = sex;
        this.birthday = birthday;
        this.birthArea = birthArea;
        this.introduction = introduction;
        this.image = image;
    }

    public Author(int id,String name){
        this.id = id;
        this.name = name;
    }

    public Author(String name,byte[] image,String introduction){
        this.name = name;
        this.image = image;
        this.introduction = introduction;
        this.id = 0;
        this.sex = null;
        this.birthArea = null;
        this.birthday = null;

    }
}
