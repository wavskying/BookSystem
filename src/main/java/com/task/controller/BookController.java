package com.task.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.task.entity.Book;
import com.task.entity.Type;
import com.task.service.BookService;
import com.task.service.TypeService;
import com.task.standard.ResponseStandard;
import com.task.util.BookUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.annotation.MultipartConfig;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

/**
 * @author: hbw
 **/
@RestController
@RequestMapping("/book")
public class BookController {
    @Autowired
    BookService bookService;

    @Autowired
    TypeService typeService;


    @GetMapping("/index")
    public ModelAndView index(ModelAndView modelAndView){

        modelAndView.setViewName("Index");
        return modelAndView;
    }

    @PostMapping("/addBook")
    public ModelAndView addBook(ModelAndView modelAndView, String name, int price, @RequestParam("photo") MultipartFile multipartFile) throws IOException {
        byte[] bytes = multipartFile.getBytes();
        Book book = new Book(0,name,price,bytes);
        multipartFile.getOriginalFilename();
        bookService.addBook(book);
        modelAndView.setViewName("Index");
        return modelAndView;
    }

    @ResponseBody
    @PostMapping("/updateBook")
    public Map updateBook(@RequestBody Map map1){
        int id;
        if (map1.get("id")!=null){
            id = Integer.parseInt((String) map1.get("id"));
        }else {
            id = 0;
        }
        System.out.println(id);
        String name = (String) map1.get("name");
        System.out.println(name);
        System.out.println(map1.get("price"));
        System.out.println(map1.get("introduction"));
        int price = Integer.parseInt((String) map1.get("price"));
        String introduction = (String) map1.get("introduction");
        Book book = new Book(id,name,price,introduction);
        Map map = new HashMap();
        if (bookService.updateBook(book) > 0){
            map.put("message","修改成功");
        }else {
            map.put("message","修改失败");
        }
        System.out.println(map);
        return map;
    }

    @PostMapping("/addPyBook")
    public int addPyBook(@RequestBody JSONArray jsonArray) throws Exception {
        System.out.println(jsonArray.getJSONObject(0).get("image"));
        System.out.println(jsonArray.getJSONObject(0).get("title"));
        for (int i = 0;i<jsonArray.size();i++){
            String title = (String) jsonArray.getJSONObject(i).get("title");
            String image = (String) jsonArray.getJSONObject(i).get("image");
            String author = (String) jsonArray.getJSONObject(i).get("author");
            String publish = (String) jsonArray.getJSONObject(i).get("publish");
            String publishData = (String) jsonArray.getJSONObject(i).get("publishData");
            int price;
            String introduction = (String) jsonArray.getJSONObject(i).get("introduction");

            URL url = new URL(image);
            HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
            httpURLConnection.setRequestProperty("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36");
            httpURLConnection.setRequestMethod("GET");
            httpURLConnection.setConnectTimeout(5 * 1000);
            InputStream inputStream = httpURLConnection.getInputStream();
            byte[] imageByte = readInputStream(inputStream);
            httpURLConnection.disconnect();
            inputStream.close();

            Random random = new Random();
            price = 15+random.nextInt(100);

            System.out.println(introduction);
            try{
                bookService.addBook(new Book(0,title,price,imageByte,"",introduction,author,publish,publishData,5,0));
            }catch (Exception e){
                System.out.println("出现问题:"+introduction);
            }

        }

        return 1;
    }

    public static byte[] readInputStream(InputStream inStream) throws Exception{
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len = 0;
        while( (len=inStream.read(buffer)) != -1 ){
            outStream.write(buffer, 0, len);
        }
        inStream.close();
        return outStream.toByteArray();
    }


    @PostMapping("/selectBook")
    public JSONObject selectBook( int id, String name, int price,int page,int limit,int sort){
        System.out.println(sort);
        System.out.println(name);
        System.out.println(price);
        Book book = new Book(id,name,price,null,sort);
        int counts = bookService.selectCount(book);
        int start = (page-1)*limit;
        JSONArray jsonArray = JSONArray.parseArray(JSON.toJSONString(BookUtil.byteToBase(bookService.selectBook(book,start,limit))));
        JSONObject jsonObject = new ResponseStandard(1,jsonArray,counts).getResponseBody();
        return jsonObject;
    }

    @PostMapping("/selectOneBook")
    public Book selectOneBook(@RequestBody Map map){
        Integer id = Integer.valueOf(map.get("id").toString());
        System.out.println(id);
        Book book = bookService.selectOneBook(id);
        return book;
    }

    @PostMapping("/selectType")
    @ResponseBody
    public List<Type> selectType(){
        return typeService.selectType();
    }

    @PostMapping("/deleteBook")
    public int deleteBook(int id){
        return bookService.deleteBook(id);
    }

    @PostMapping("/getChart")
    @ResponseBody
    public Map getChart(){
        System.out.println("进来了");
        Map map = new HashMap();
        List<Type> list = typeService.selectType();
        List<Integer> list1 = new LinkedList();
        List list2 = new LinkedList();
        List<Integer> list3 = new LinkedList();
        for (Type type:list){
            list1.add(type.getId());
            list2.add(type.getSort());
        }
        for (int i:list1){
            list3.add(bookService.getCountBySort(i));
        }
        map.put("xAxisData",list2);
        map.put("data",list3);
        return map;
    }

    @PostMapping("/getChart2")
    @ResponseBody
    public List<Map> getChart2(){
        List<Book> bookList = bookService.getBookByPublish();
        List<Map> mapList = new LinkedList<>();
        for (Book book:bookList){
            Map map = new HashMap();
            map.put("value",book.getCountPublish());
            map.put("name",book.getPublish());
            mapList.add(map);
        }
        return mapList;
    }
}
