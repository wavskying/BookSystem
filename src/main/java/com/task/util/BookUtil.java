package com.task.util;

import com.task.entity.Book;

import java.util.Base64;
import java.util.List;

/**
 * @author: hbw
 **/
public class BookUtil {
    public static List<Book> byteToBase(List<Book> bookList){
        if (bookList.size()>0){
                for(int i = 0;i < bookList.size();i++){
                    if (bookList.get(i).getPhoto()!=null){
                        String image= Base64.getEncoder().encodeToString(bookList.get(i).getPhoto());
                        bookList.get(i).setImag(image);
                    }
                }
        }

        return bookList;
    }
}
