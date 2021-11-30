package com.task.dao;

import com.task.entity.Book;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author: hbw
 **/
@Repository
public interface BookDao {
    public int addBook(@Param("book") Book book);

    public List<Book> selectBook(@Param("book") Book book,@Param("start") int start,@Param("end") int end);

    public int selectCount(@Param("book") Book book);

    public int deleteBook(int id);

    public Book selectOneBook(@Param("id") int id);

    public int updateBook(@Param("book") Book book);

    public int getCountBySort(@Param("sort") int sort);

    public List getBookByPublish();


}
