package com.task.service.impl;

import com.task.dao.BookDao;
import com.task.dao.UserDao;
import com.task.entity.Book;
import com.task.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Base64;
import java.util.List;

/**
 * @author: hbw
 **/
@Service
public class BookServiceImpl implements BookService {
    @Autowired
    BookDao bookDao;

    @Override
    public int addBook(Book book) {
        return bookDao.addBook(book);
    }

    @Override
    public List<Book> selectBook(Book book,int start,int end) {
        return bookDao.selectBook(book,start,end);
    }

    @Override
    public int selectCount(Book book) {
        return bookDao.selectCount(book);
    }

    @Override
    public int deleteBook(int id) {
        return bookDao.deleteBook(id);
    }

    @Override
    public Book selectOneBook(int id){
        Book book = bookDao.selectOneBook(id);
        book.setImag(Base64.getEncoder().encodeToString(book.getPhoto()));
        return book;
    }

    @Override
    public int updateBook(Book book) {
        return bookDao.updateBook(book);
    }

    @Override
    public int getCountBySort(int sort) {
        return bookDao.getCountBySort(sort);
    }

    @Override
    public List getBookByPublish() {
        return bookDao.getBookByPublish();
    }
}
