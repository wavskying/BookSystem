package com.task.service.impl;

import com.task.dao.TypeDao;
import com.task.entity.Type;
import com.task.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: hbw
 **/
@Service
public class TypeServiceImpl implements TypeService {
    @Autowired
    TypeDao typeDao;


    @Override
    public List<Type> selectType() {

        return typeDao.selectType();
    }
}
