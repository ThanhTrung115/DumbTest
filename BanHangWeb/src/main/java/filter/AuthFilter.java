/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@WebFilter("/*")
public class AuthFilter implements Filter {

    // PUBLIC paths (không cần đăng nhập) - Java 8
    private static final Set<String> PUBLIC_PATHS = new HashSet<>(Arrays.asList(
        "/", "/home", "/sanpham",
        "/login", "/register", "/logout",
        "/index.jsp", "/index.html"
    ));

    // Tiền tố static để bỏ qua
    private static final String[] STATIC_PREFIX = {
        "/assets/", "/css/", "/js/", "/img/", "/images/", "/favicon", "/META-INF", "/WEB-INF"
    };

    private boolean isPublic(HttpServletRequest req) {
        String p = req.getServletPath();
        if (p == null || p.isEmpty()) p = "/";
        if (PUBLIC_PATHS.contains(p)) return true;
        for (String s : STATIC_PREFIX) {
            if (p.startsWith(s)) return true;
        }
        return false;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getServletPath();
        if (isPublic(req)) {
            chain.doFilter(request, response);
            return;
        }

        // Bắt buộc admin cho /admin/*
        if (path != null && path.startsWith("/admin")) {
            User u = (User) req.getSession().getAttribute("currentUser");
            if (u != null && u.isAdmin()) {
                chain.doFilter(request, response);
            } else {
                resp.sendRedirect(req.getContextPath() + "/login");
            }
            return;
        }

        // Các trang còn lại yêu cầu đăng nhập
        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        chain.doFilter(request, response);
    }
}
