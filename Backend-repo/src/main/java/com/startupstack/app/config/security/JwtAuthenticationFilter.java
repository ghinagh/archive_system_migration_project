package com.startupstack.app.config.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;

    public JwtAuthenticationFilter(JwtUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        String header = request.getHeader("Authorization");

        if (header != null && header.startsWith("Bearer ")) {
            String token = header.substring(7);

            if (jwtUtil.validateToken(token)) {
                String  username   = jwtUtil.extractUsername(token);
                int     permission = jwtUtil.extractPermission(token);
                String  userEnt    = jwtUtil.extractUserEnt(token);
                String  userDoc    = jwtUtil.extractUserDoc(token);
                String  userLevel  = jwtUtil.extractUserLevel(token);
                Integer siteWly    = jwtUtil.extractSiteWly(token);

                // Store JWT claims as request attributes so SecurityUtils and
                // the permission aspect can read them without re-parsing the token.
                request.setAttribute("userPermission", permission);
                request.setAttribute("userEnt",        userEnt);
                request.setAttribute("userDoc",        userDoc);
                request.setAttribute("userLevel",      userLevel);
                request.setAttribute("siteWly",        siteWly);

                UsernamePasswordAuthenticationToken authentication =
                        new UsernamePasswordAuthenticationToken(username, null, Collections.emptyList());
                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        }

        filterChain.doFilter(request, response);
    }
}
