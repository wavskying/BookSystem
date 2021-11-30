package com.task.service;

import com.task.entity.Author;

import java.util.List;

/**
 * @author: hbw
 **/
public interface AuthorService {
    public int addAuthor(Author author);

    public List<Author> selectAuthor(Author author,int start,int end);

    public int selectCount(Author author);

    public Author selectOneAuthor(String name);

}
