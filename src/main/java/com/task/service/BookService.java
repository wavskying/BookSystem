package com.task.service;

import com.task.entity.Book;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: hbw
 **/
public interface BookService {
    public int addBook(Book book);

    public List<Book> selectBook(Book book,int start,int end);

    public int selectCount(Book book);

    public int deleteBook(int id);

    public Book selectOneBook(int id);

    public int updateBook(Book book);

    public int getCountBySort(int sort);

    public List getBookByPublish();
}
