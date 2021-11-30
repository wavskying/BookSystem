package com.task.interceptor;

import com.task.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author: hbw
 **/
public class UserLoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("执行了拦截器方法");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if ((user!=null)){
            System.out.println("没有拦截");
            return true;
        }else {
            System.out.println("拦截成功");
            request.setAttribute("msg", "你还没有登陆");
            request.getRequestDispatcher("/web/jsp/Login.jsp").forward(request, response);
            System.out.println("最后");
            return false;
        }

    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("执行了拦截器的postHandle方法");
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("执行了拦截器的afterCompletion方法");
    }
}
