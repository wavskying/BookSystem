package com.task.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.task.entity.User;
import com.task.service.UserService;
import com.task.standard.ResponseStandard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * @author: hbw
 **/
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;


    @RequestMapping(value = "/login",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public Map login(@RequestBody() Map<String,String> map, HttpServletRequest request){
        Map map1 = new HashMap();
        User user = userService.isLogin(map.get("username"),map.get("password"));
        if (user != null){
            request.getSession().setAttribute("user",user);
            System.out.println(user);
            map1.put("result","success");
            map1.put("user",user);
        }else {
            map1.put("result","false");
        }
        return map1;
    }

    @PostMapping("/outLogin")
    @ResponseBody
    public int outLogin(HttpServletRequest request){
        request.getSession().removeAttribute("user");
        return 1;
    }

    @PostMapping("/selectUsers")
    @ResponseBody
    public JSONObject selectUsers(String id,String name,int page,int limit){
        System.out.println("222");
        System.out.println(id);
        System.out.println(name);
        User user = new User(id,name,null,null,null);
        int counts = userService.selectCount(user);
        int start = (page-1)*limit;
        JSONArray jsonArray = JSONArray.parseArray(JSON.toJSONString(userService.selectUsers(user,start,limit)));
        return new ResponseStandard(1,jsonArray,counts).getResponseBody();
    }

    @PostMapping("/addUser")
    @ResponseBody
    public Map addUser(@RequestBody Map map){
        System.out.println(map);
        String username = (String) map.get("registerUsername");
        String name = (String) map.get("name");
        String password = (String) map.get("registerPassword");
        String identity = (String) map.get("selectValue");

        int result = userService.addUser(new User(username,name,username,password,identity));

        Map map1 = new HashMap();

        if (result > 0){
            map1.put("message","注册成功");
        }else {
            map1.put("message","注册失败");
        }
        return map1;
    }

    @PostMapping("/deleteUser")
    @ResponseBody
    public Map deleteUser(@RequestBody User user){
        Map map = new HashMap();
        if (userService.deleteUser(user.getId())>0){
            map.put("message","删除成功");
        }else {
            map.put("message","删除失败");
        }
        return map;
    }

    @PostMapping("/updateUser")
    @ResponseBody
    public Map updateUser(@RequestBody User user){
        Map map = new HashMap();
        if (userService.updateUser(user)>0){
            map.put("message","修改成功");
        }else {
            map.put("message","修改失败");
        }
        return map;
    }

    @RequestMapping("/index")
    public ModelAndView loginIndex(ModelAndView modelAndView){
        modelAndView.setViewName("Login");
        return modelAndView;
    }

}
