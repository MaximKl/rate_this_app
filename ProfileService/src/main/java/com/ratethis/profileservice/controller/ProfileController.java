package com.ratethis.profileservice.controller;

import com.ratethis.profileservice.entity.book.BookComment;
import com.ratethis.profileservice.entity.film.FilmComment;
import com.ratethis.profileservice.entity.game.GameComment;
import com.ratethis.profileservice.entity.user.User;
import com.ratethis.profileservice.entity.user.UserBook;
import com.ratethis.profileservice.entity.user.UserFilm;
import com.ratethis.profileservice.entity.user.UserGame;
import com.ratethis.profileservice.service.ProfileService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;


@Controller
@Slf4j
@RequestMapping(value = "/profile")
public class ProfileController {

    @Autowired
    private ProfileService profileService;


    @GetMapping
    private String getStartPage(Model userModel) {
        userModel.addAttribute("user", new User());
        log.info("Start Page sent");
        return "start";
    }

    @GetMapping("/user/to-profile")
    private RedirectView redirectToProfile() {
        return new RedirectView("http://localhost:9191/profile");
    }

    @GetMapping("/user/{name}")
    private String getUserPage(@PathVariable("name") String name, Model userModel) {
        User profileUser = profileService.getUserByNick(name);
        if (profileUser==null)
            return "redirect:to-profile";
        userModel.addAttribute("reviews", profileUser);
        userModel.addAttribute("user", new User());
        log.info("Profile page of user - " + name + " has been sent");
        return "user-page";
    }

    @GetMapping("/user/{name}/{category}/to-profile")
    private RedirectView redirectToProfileFromFullReview() {
        return new RedirectView("http://localhost:9191/profile");
    }

    @GetMapping("/user/{name}/game/{id}")
    private String getUserGameReview(@PathVariable("name") String name, @PathVariable("id") int id, Model userModel) {
        User profileUser = profileService.getUserByNick(name);
        if (profileUser==null)
            return "redirect:to-profile";
        UserGame ug = profileUser.getGames().stream().filter(r->r.getId()==id).findFirst().orElseGet(()->null);
        if(ug==null)
            return "redirect:to-profile";
        userModel.addAttribute("review", ug);
        userModel.addAttribute("comment", profileUser.getGameComments().stream()
                .filter(c->c.getUser().getId()==profileUser.getId() && ug.getGame().getId()==c.getGame().getId()).findFirst().orElseGet(GameComment::new));
        userModel.addAttribute("user", new User());
        log.info("Full review page of user - " + name + " on the game - "+ ug.getGame().getName() +" has been sent");
        return "full-game-review-page";
    }


    @GetMapping("/user/{name}/film/{id}")
    private String getUserFilmReview(@PathVariable("name") String name, @PathVariable("id") int id, Model userModel) {
        User profileUser = profileService.getUserByNick(name);
        if (profileUser==null)
            return "redirect:to-profile";
        UserFilm uf = profileUser.getFilms().stream().filter(r->r.getId()==id).findFirst().orElseGet(()->null);
        if(uf==null)
            return "redirect:to-profile";
        userModel.addAttribute("review", uf);
        userModel.addAttribute("comment", profileUser.getFilmComments().stream()
                .filter(c->c.getUser().getId()==profileUser.getId() && uf.getFilm().getId()==c.getFilm().getId()).findFirst().orElseGet(FilmComment::new));
        userModel.addAttribute("user", new User());
        log.info("Full review page of user - " + name + " on the film - "+ uf.getFilm().getName() +" has been sent");
        return "full-film-review-page";
    }


    @GetMapping("/user/{name}/book/{id}")
    private String getUserBookReview(@PathVariable("name") String name, @PathVariable("id") int id,  Model userModel) {
        User profileUser = profileService.getUserByNick(name);
        if (profileUser==null)
            return "redirect:to-profile";
        UserBook ub = profileUser.getBooks().stream().filter(r->r.getId()==id).findFirst().orElseGet(()->null);
        if(ub==null)
            return "redirect:to-profile";
        userModel.addAttribute("review", ub);
        userModel.addAttribute("comment", profileUser.getBookComments().stream()
                .filter(c->c.getUser().getId()==profileUser.getId() && ub.getBook().getId()==c.getBook().getId()).findFirst().orElseGet(BookComment::new));
        userModel.addAttribute("user", new User());
        log.info("Full review page of user - " + name + " on the book - "+ ub.getBook().getName() +" has been sent");
        return "full-book-review-page";
    }

    @GetMapping("/user/{name}/settings")
    private String getSettings(Model userModel, HttpServletRequest request) {
        if(Arrays.stream(request.getCookies()).noneMatch(c->c.getName().equals("user_id")))
            return "redirect:/profile";
        User user =  profileService.getUserById(Integer.parseInt(Arrays.stream(request.getCookies()).filter(c->c.getName().equals("user_id")).findFirst().get().getValue()));
        if(user.getId()==0)
            return "redirect:/profile";
        userModel.addAttribute("user",user);
        log.info("Settings Page sent");
        return "user-settings-page";
    }

    @PostMapping("/user/{id}/remove")
    private @ResponseBody String deleteUser(@PathVariable("id") int id) {
        profileService.removeUser(id);
        log.info("Delete user with id "+id);
        return "OK";
    }

}
