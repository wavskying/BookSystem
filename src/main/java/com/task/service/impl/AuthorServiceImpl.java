package com.task.service.impl;

import com.task.dao.AuthorDao;
import com.task.entity.Author;
import com.task.entity.Book;
import com.task.service.AuthorService;
import org.omg.PortableServer.LIFESPAN_POLICY_ID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Base64;
import java.util.List;

/**
 * @author: hbw
 **/
@Service
public class AuthorServiceImpl implements AuthorService {

    @Autowired
    AuthorDao authorDao;

    @Override
    public int addAuthor(Author author) {
        return authorDao.addAuthor(author);
    }

    @Override
    public List<Author> selectAuthor(Author author,int start,int end) {
        List<Author> authorList = authorDao.selectAuthor(author,start,end);
        for (Author author1:authorList){
            if (author1.getImage()!=null){
                author1.setPhoto(Base64.getEncoder().encodeToString(author1.getImage()));
            }
        }
        return authorList;
    }

    @Override
    public int selectCount(Author author) {
        return authorDao.selectCount(author);
    }

    @Override
    public Author selectOneAuthor(String name){
        Author author = authorDao.selectOneAuthor(name);
        author.setPhoto(Base64.getEncoder().encodeToString(author.getImage()));
        for (Book book : author.getBookList()){
            if (book.getPhoto() != null){
                book.setImag(Base64.getEncoder().encodeToString(book.getPhoto()));
            }
        }
        return author;
    }
}
