package com.task.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.task.entity.Author;
import com.task.service.AuthorService;
import com.task.standard.ResponseStandard;
import com.task.util.PublicUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.InputStream;
import java.net.URL;
import java.util.Map;

/**
 * @author: hbw
 **/
@Controller
@RequestMapping("/author")
public class AuthorController {
    @Autowired
    AuthorService authorService;

    @PostMapping("/selectAuthor")
    @ResponseBody
    public JSONObject selectAuthor(int id, String name, int page, int limit){
        System.out.println(name);
        Author author = new Author(0,name);
        int counts = authorService.selectCount(author);
        int start = (page-1)*limit;
        JSONArray jsonArray =  JSONArray.parseArray(JSON.toJSONString(authorService.selectAuthor(author,start,limit)));
        JSONObject jsonObject = new ResponseStandard(1,jsonArray,counts).getResponseBody();
        System.out.println(jsonObject);
        return jsonObject;
    }

    @PostMapping("/selectOneAuthor")
    @ResponseBody
    public Author selectOneAuthor(@RequestBody Map map){
        String name = (String) map.get("name");
        System.out.println(name);
        return authorService.selectOneAuthor(name);
    }


    @PostMapping("/addAuthor")
    @ResponseBody
    public Map addAuthor(@RequestBody Map map){
        System.out.println(map);
        int flag = authorService.addAuthor(new Author(0, (String) map.get("name"),null,null,null,null,null));
        if (flag>0){
            map.put("state",200);
        }else {
            map.put("state",404);
        }
        return map;
    }

    @PostMapping("/addPyAuthor")
    @ResponseBody
    public int addPyAuthor(@RequestBody JSONArray jsonArray) throws Exception {
        System.out.println(jsonArray.getJSONObject(0).get("image"));
        System.out.println(jsonArray.getJSONObject(0).get("name"));
        for (int i = 0;i<jsonArray.size();i++){
            String name = (String) jsonArray.getJSONObject(i).get("name");
            String image = (String) jsonArray.getJSONObject(i).get("image");
            String introduction = (String) jsonArray.getJSONObject(i).get("introduction");
            URL url = new URL(image);
            InputStream inputStream = PublicUtil.getInputStream(url);
            byte[] imageByte = PublicUtil.readInputStream(inputStream);
            PublicUtil.closeHttpURLConnection();

            authorService.addAuthor(new Author(name,imageByte,introduction));

        }
        return 1;
    }


}
