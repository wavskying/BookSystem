package com.task.interceptor;

import com.task.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author: hbw
 **/
public class IdentityBookInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("拦截到了添加图书");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user.getIdentity().equals("管理员用户")){
            return true;
        }else {
            request.setAttribute("add", "您没有权限操作");
            request.getRequestDispatcher("/web/Index.jsp").forward(request, response);
            return false;
        }
    }
}
