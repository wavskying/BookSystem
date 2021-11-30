package com.task.dao;

import com.task.entity.Type;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: hbw
 **/
@Service
public interface TypeDao {

    public List<Type> selectType();

}
