package com.task.service;

import com.task.entity.Type;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: hbw
 **/
public interface TypeService {
    public List<Type> selectType();
}
