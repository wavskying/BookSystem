package com.task.dao;

import com.task.entity.Author;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: hbw
 **/
@Service
public interface AuthorDao {
    public int addAuthor(@Param("author") Author author);

    public List<Author> selectAuthor(@Param("author") Author author,@Param("start") int start,@Param("end") int end);

    public int selectCount(@Param("author") Author author);

    public Author selectOneAuthor(@Param("name") String name);


}
