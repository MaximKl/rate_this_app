package com.ratethis.profileservice.controller;

import com.ratethis.profileservice.entity.user.User;
import com.ratethis.profileservice.service.ProfileService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.QueryParam;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Controller
@Slf4j
public class DomainController {
    @Autowired
    private ProfileService profileService;

    @PostMapping("/enter")
    private RedirectView enter(@ModelAttribute("user") User user, @QueryParam("link") String link, HttpServletResponse response) {
        User consumedUser = profileService.authorisation(user.getNickname(), user.getPassword());
        if (consumedUser.getId() == 0)
            return new RedirectView("http://localhost:9191" + link + "?authError=" + URLEncoder.encode("Надано неврні дані", StandardCharsets.UTF_8));
        Cookie idCookie = new Cookie("user_id", Integer.toString(consumedUser.getId()));
        Cookie nickCookie = new Cookie("nick", consumedUser.getNickname());
        idCookie.setMaxAge(60 * 60 * 6);
        nickCookie.setMaxAge(60 * 60 * 6);
        if (consumedUser.getIsAdmin()) {
            Cookie admin = new Cookie("admin", "1");
            admin.setMaxAge(60 * 60 * 6);
            response.addCookie(admin);
        }
        response.addCookie(idCookie);
        response.addCookie(nickCookie);
        log.info("Authorisation by user with id " + consumedUser.getId() + " has been saved");
        return new RedirectView("http://localhost:9191" + link);
    }

    @PostMapping("/addUser")
    private RedirectView addUser(@ModelAttribute("user") User user, @QueryParam("link") String link, HttpServletResponse response) {
        if (!profileService.uniqueNickname(user.getNickname()))
            return new RedirectView("http://localhost:9191" + link + "?error=" + URLEncoder.encode("Корисутвача з ніком - " + user.getNickname() + " вже зареєстровано", StandardCharsets.UTF_8));
        if (!profileService.uniqueMail(user.getEmail()))
            return new RedirectView("http://localhost:9191" + link + "?error=" + URLEncoder.encode("Корисутвача з поштою - " + user.getEmail() + " вже зареєстровано", StandardCharsets.UTF_8));
        user.setId(0);
        user.setIsAdmin(false);
        profileService.saveUser(user);
        Cookie idCookie = new Cookie("user_id", Integer.toString(user.getId()));
        Cookie nickCookie = new Cookie("nick", user.getNickname());
        idCookie.setMaxAge(60 * 60 * 6);
        nickCookie.setMaxAge(60 * 60 * 6);
        response.addCookie(idCookie);
        response.addCookie(nickCookie);
        log.info("New user with id " + user.getId() + " has been saved");
        return new RedirectView("http://localhost:9191" + link);
    }

    @PostMapping("/updateUser")
    private RedirectView updateUser(@ModelAttribute("user") User user, @QueryParam("id") String id, HttpServletResponse response) {
        User user1 = profileService.getUserById(Integer.parseInt(id));
        if (!user1.getNickname().equals(user.getNickname())) {
            if (!profileService.uniqueNickname(user.getNickname()))
                return new RedirectView("http://localhost:9191/profile/user/" + user.getNickname() + "/settings?error=" + URLEncoder.encode("Корисутвача з ніком - " + user.getNickname() + " вже зареєстровано", StandardCharsets.UTF_8));
        }
        if (!user1.getEmail().equals(user.getEmail())) {
            if (!profileService.uniqueMail(user.getEmail()))
                return new RedirectView("http://localhost:9191/profile/user/" + user.getNickname() + "/settings?error=" + URLEncoder.encode("Корисутвача з поштою - " + user.getEmail() + " вже зареєстровано", StandardCharsets.UTF_8));
        }
        user.setIsAdmin(false);
        user.setId(Integer.parseInt(id));
        profileService.saveUser(user);
        Cookie idCookie = new Cookie("user_id", Integer.toString(user.getId()));
        Cookie nickCookie = new Cookie("nick", user.getNickname());
        idCookie.setMaxAge(60 * 60 * 6);
        nickCookie.setMaxAge(60 * 60 * 6);
        response.addCookie(idCookie);
        response.addCookie(nickCookie);
        return new RedirectView("http://localhost:9191/profile/");
    }

}
