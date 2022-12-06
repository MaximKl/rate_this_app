package com.ratethis.filmservice.controller;

import com.ratethis.filmservice.entity.Country;
import com.ratethis.filmservice.entity.film.*;
import com.ratethis.filmservice.entity.user.User;
import com.ratethis.filmservice.entity.user.UserFilm;
import com.ratethis.filmservice.service.FilmService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

@Controller
@RequestMapping("/films")
@Slf4j
public class FilmController {

    @Autowired
    private FilmService filmService;


    @GetMapping("")
    private String getFilm(@RequestParam(value = "fname", required = false) String filmName, Model userModel) {
        List<Film> allFilms = filmService.getAllFilms();
        List<Film> filmsToReturn = new ArrayList<>();
        if (filmName != null) {
            if (!filmName.isBlank()) {
                List<String> words = Arrays.stream(filmName.split(" ")).toList();
                for (Film f : allFilms) {
                    List<String> fNameWords = Arrays.stream(f.getName().split(" ")).toList();
                    for (String s : words) {
                        if (fNameWords.stream().anyMatch(w -> s.equalsIgnoreCase(w)) && filmsToReturn.stream().noneMatch(film -> film.getName().equalsIgnoreCase(f.getName())))
                            filmsToReturn.add(f);
                    }
                }
                if (filmsToReturn.isEmpty()) {
                    userModel.addAttribute("mes", "Пошук за назвою - '" + filmName + "' не дав результатів");
                    userModel.addAttribute("searched", filmName);
                    userModel.addAttribute("allFilms", filmsToReturn);
                    userModel.addAttribute("user", new User());
                    log.info("Bad filtered films page");
                    return "films-page";
                }
            }
        }

        if (filmsToReturn.isEmpty()) {
            userModel.addAttribute("allFilms", allFilms.stream().sorted(Comparator.comparing(Film::getName)).toList());
        } else {
            userModel.addAttribute("allFilms", filmsToReturn.stream().sorted(Comparator.comparing(Film::getName)).toList());
            userModel.addAttribute("mes", "Результати пошуку за назвою - " + filmName);
            userModel.addAttribute("searched", filmName);
        }
        userModel.addAttribute("user", new User());
        log.info("Getting all films page");
        return "films-page";
    }


    @PostMapping
    private @ResponseBody String removeFilm(@RequestParam(value = "filmId") String filmId) {
        if (filmId != null) {
            if (!filmId.isBlank()) {
                filmService.removeFilm(Integer.parseInt(filmId));
                return "OK";
            }
        }
        return "BAD";
    }

    @GetMapping("/add")
    private String addFilm(Model filmModel) {
        filmModel.addAttribute("film", new Film());
        filmModel.addAttribute("allPublishers", filmService.getAllPublishers());
        filmModel.addAttribute("allCategories", filmService.getAllCategories().stream().sorted(Comparator.comparing(FilmCategory::getName)).toList());
        filmModel.addAttribute("allActors", filmService.getAllActors().stream().sorted(Comparator.comparing(FilmActor::getSurname)).toList());
        filmModel.addAttribute("allDirectors", filmService.getAllDirectors().stream().sorted(Comparator.comparing(FilmDirector::getSurname)).toList());
        filmModel.addAttribute("allStudios", filmService.getAllStudios());
        filmModel.addAttribute("allCountries", filmService.getAllCountries().stream().sorted(Comparator.comparing(Country::getName)).toList());
        filmModel.addAttribute("allFilms", filmService.getAllFilms());
        log.info("Getting add-film page");
        return "add-film";
    }


    @GetMapping("/{id}")
    private String getFilm(@PathVariable("id") int id, Model userModel, HttpServletRequest request,
                           @RequestParam(value = "comM", required = false) String commonMark,
                           @RequestParam(value = "efM", required = false) String effectMark,
                           @RequestParam(value = "stM", required = false) String storyMark,
                           @RequestParam(value = "soundM", required = false) String soundMark,
                           @RequestParam(value = "actM", required = false) String actorsMark,
                           @RequestParam(value = "camM", required = false) String cameraMark,
                           @RequestParam(value = "toChange", required = false) String toChange) {

        Film searchedFilm = filmService.getFilmById(id);
        User user = null;
        boolean isUserScoreFilm = false;
        boolean alwaysTrue = false;
        boolean isOperation = false;
        int ugId = 0;
        if (searchedFilm.getId() == 0)
            return "redirect:/profile";

        List<Integer> numbers = new ArrayList<>();
        for (int i = 0; i < 101; i++)
            numbers.add(i);

        List<Cookie> cookies = Arrays.stream(request.getCookies()).toList();
        if (cookies.stream().anyMatch(c -> c.getName().equals("user_id"))) {
            if (searchedFilm.getComments().stream().anyMatch(c -> c.getUser().getId() == Integer.parseInt(cookies.stream().filter(cc -> cc.getName().equals("user_id")).findFirst().get().getValue())))
                alwaysTrue = true;
            user = filmService.getUser(Integer.parseInt(cookies.stream().filter(c -> c.getName().equals("user_id")).findFirst().get().getValue()));
            if (user.getFilms().stream().anyMatch(g -> g.getFilm().getId() == id)) {
                isUserScoreFilm = true;
            }
        }


        if (toChange != null) {
            if (toChange.equals("1"))
                isUserScoreFilm = false;
        }

        if (commonMark != null && effectMark != null && storyMark != null && soundMark != null && actorsMark != null && cameraMark != null && user != null) {
            if (!commonMark.isBlank() && !effectMark.isBlank() && !storyMark.isBlank() && !soundMark.isBlank() && !actorsMark.isBlank() && !cameraMark.isBlank() && !isUserScoreFilm) {
                try {
                    int comM = Integer.parseInt(commonMark);
                    int effM = Integer.parseInt(effectMark);
                    int stM = Integer.parseInt(storyMark);
                    int soundM = Integer.parseInt(soundMark);
                    int actM = Integer.parseInt(actorsMark);
                    int camM = Integer.parseInt(cameraMark);
                    if (comM >= 0 && comM <= 100 && effM >= 0 && effM <= 100 && stM >= 0 && stM <= 100 && soundM >= 0 && soundM <= 100 && actM >= 0 && actM <= 100 && camM >= 0 && camM <= 100) {
                        if (user.getFilms().stream().anyMatch(g -> g.getFilm().getId() == id)) {
                            ugId = user.getFilms().stream().filter(userFilm -> userFilm.getFilm().getId() == id).findFirst().get().getId();
                            UserFilm receivedUg = filmService.getUserFilmById(ugId);
                            receivedUg.setCommonMark(comM);
                            receivedUg.setEffectMark(effM);
                            receivedUg.setActorsMark(actM);
                            receivedUg.setSoundMark(soundM);
                            receivedUg.setCameramanMark(camM);
                            receivedUg.setStoryMark(stM);
                            filmService.saveUserFilm(receivedUg);
                        } else {
                            user.getFilms().add(filmService.saveUserFilm(new UserFilm(0, effM, stM, comM, soundM, camM, actM, user, searchedFilm)));
                            filmService.saveUser(user);
                        }
                        isOperation = true;
                    } else {
                        userModel.addAttribute("wrong", "Надано невірні значення");
                    }
                } catch (Exception e) {
                    userModel.addAttribute("wrong", "Надано невірні значення");
                }
            } else {
                userModel.addAttribute("wrong", "Надано невірні значення");
            }
        }

        List<FilmComment> userComments = new ArrayList<>();
        if (alwaysTrue) {
            userComments = user.getFilmComments().stream().filter(fc -> fc.getFilm().getId() == id).toList();
            userModel.addAttribute("thisFilmComment", userComments);
        }

        userModel.addAttribute("isCommented", !userComments.isEmpty());
        userModel.addAttribute("isScored", isUserScoreFilm);
        userModel.addAttribute("numbers", numbers);
        userModel.addAttribute("film", searchedFilm);
        userModel.addAttribute("filmComments", searchedFilm.getComments().stream().sorted(Comparator.comparingInt(FilmComment::getRating).reversed()).toList());
        userModel.addAttribute("user", new User());
        log.info("Getting the page of a film - " + searchedFilm.getName());
        if (isOperation)
            return "redirect:/films/" + id;
        return "film-page";
    }


    @PostMapping("/{id}")
    private @ResponseBody String sentInfoComment(@PathVariable("id") int id,
                                                 @RequestParam(value = "comment", required = false) String comment,
                                                 @RequestParam(value = "uid", required = false) String userId,
                                                 @RequestParam(value = "comId", required = false) String commentId,
                                                 @RequestParam(value = "like", required = false) String isLiked,
                                                 @RequestParam(value = "deleteMyComment", required = false) String isDeleteCom) {
        if (userId != null && commentId != null && isLiked != null) {
            if (!commentId.isBlank() && !userId.isBlank() && !isLiked.isBlank()) {
                FilmComment fc = filmService.getCommentById(Integer.parseInt(commentId));
                User user = filmService.getUser(Integer.parseInt(userId));
                if (fc.getId() != 0 && user.getId() != 0) {
                    if (user.getFilmReactions().stream().noneMatch(r -> r.getComment().getId() == fc.getId())) {
                        if (isLiked.equals("true")) {
                            filmService.saveReaction(new FilmReaction(0, true, false, user, fc));
                        } else if (isLiked.equals("false")) {
                            filmService.saveReaction(new FilmReaction(0, false, true, user, fc));
                        }
                        return "OK";
                    } else {
                        FilmReaction previousReaction = user.getFilmReactions().stream().filter(reaction -> reaction.getComment().getId() == fc.getId()).findFirst().get();
                        if (previousReaction.isLike() && isLiked.equals("true")) {
                            previousReaction.setLike(false);
                            filmService.saveReaction(previousReaction);
                        } else if (previousReaction.isLike() && isLiked.equals("false")) {
                            previousReaction.setLike(false);
                            previousReaction.setDislike(true);
                            filmService.saveReaction(previousReaction);
                            return "change";
                        } else if (previousReaction.isDislike() && isLiked.equals("false")) {
                            previousReaction.setDislike(false);
                            filmService.saveReaction(previousReaction);
                        } else if (previousReaction.isDislike() && isLiked.equals("true")) {
                            previousReaction.setDislike(false);
                            previousReaction.setLike(true);
                            filmService.saveReaction(previousReaction);
                            return "change";
                        } else if (!previousReaction.isDislike() && !previousReaction.isLike() && isLiked.equals("true")) {
                            previousReaction.setLike(true);
                            filmService.saveReaction(previousReaction);
                            return "OK";
                        } else if (!previousReaction.isDislike() && !previousReaction.isLike() && isLiked.equals("false")) {
                            previousReaction.setDislike(true);
                            filmService.saveReaction(previousReaction);
                            return "OK";
                        }
                        return "removed";
                    }
                }
            }
        }

        if (comment != null && userId != null) {
            if (!comment.isBlank() && !userId.isBlank()) {
                Film searchedFilm = filmService.getFilmById(id);
                if (searchedFilm.getId() == 0)
                    return "BAD";
                User user = filmService.getUser(Integer.parseInt(userId));
                if (user.getId() != 0) {
                    if (user.getFilmComments().stream().noneMatch(g -> g.getFilm().getId() == searchedFilm.getId())) {
                        filmService.saveComment(new FilmComment(0, 0, 0, 0, comment, searchedFilm, user, new ArrayList<>()));
                        return "OK";
                    } else {
                        return "alreadyCommented";
                    }
                }
            }
        }

        if (isDeleteCom != null && commentId != null) {
            if (isDeleteCom.equals("true") && !commentId.isBlank()) {
                FilmComment fc = filmService.getCommentById(Integer.parseInt(commentId));
                if (!fc.getReactions().isEmpty()) {
                    List<FilmReaction> fReact = fc.getReactions();
                    fReact.forEach(reaction -> {
                        reaction.setComment(null);
                        reaction.setUser(null);
                        filmService.saveReaction(reaction);
                        filmService.removeReaction(reaction.getId());
                    });
                }
                filmService.removeComment(Integer.parseInt(commentId));
                return "OK";
            }
        }
        return "BAD";
    }


    @PostMapping("/add")
    private RedirectView postFilm(@ModelAttribute("film") Film film, @RequestParam("acts") String actors, @RequestParam("cats") String cats, @RequestParam("dirs") String directors) {
        List<Film> allFilms = filmService.getAllFilms();
        int existedId = 0;
        if (film.getName() != null) {
            if (!film.getName().isBlank()) {
                if (allFilms.stream().anyMatch(f -> f.getName().equalsIgnoreCase(film.getName())))
                    existedId = allFilms.stream().filter(f -> f.getName().equalsIgnoreCase(film.getName())).map(Film::getId).findFirst().get();
            }
        }

        List<FilmActor> actorsToReturn = new ArrayList<>();
        FilmPublisher publisherToReturn;
        FilmStudio studioToReturn;
        List<FilmCategory> categoriesToReturn = new ArrayList<>();
        List<FilmDirector> directorsToReturn = new ArrayList<>();
        if (actors != null) {
            if (!actors.isBlank()) {
                List<String> listActors = Arrays.stream(actors.split(";")).map(d -> d.substring(0, d.length())).toList();
                List<FilmActor> allActors = filmService.getAllActors();
                for (String s : listActors) {
                    if (!s.isBlank()) {
                        List<String> nameSurname = new ArrayList<>(Arrays.stream(s.split(" ")).toList());
                        if (nameSurname.size() == 1)
                            nameSurname.add(" ");
                        if (allActors.stream().noneMatch(a -> a.getName().equalsIgnoreCase(nameSurname.get(0)) && a.getSurname().equalsIgnoreCase(nameSurname.get(1)))) {
                            actorsToReturn.add(filmService.saveActor(new FilmActor(0, nameSurname.get(0), nameSurname.get(1), new ArrayList<>())));

                        } else if (allActors.stream().anyMatch(a -> a.getName().equalsIgnoreCase(nameSurname.get(0)) && a.getSurname().equalsIgnoreCase(nameSurname.get(1))))
                            actorsToReturn.add(allActors.stream().filter(a -> a.getName().equalsIgnoreCase(nameSurname.get(0)) && a.getSurname().equalsIgnoreCase(nameSurname.get(1))).findFirst().get());
                    }
                }
            }
        }

        if (directors != null) {
            if (!directors.isBlank()) {
                List<String> listDirectors = Arrays.stream(directors.split(";")).map(d -> d.substring(0, d.length())).toList();
                List<FilmDirector> allDirectors = filmService.getAllDirectors();
                for (String s : listDirectors) {
                    if (!s.isBlank()) {
                        List <String> nameSurname = new ArrayList<>(Arrays.stream(s.split(" ")).toList());
                        if (nameSurname.size() == 1)
                            nameSurname.add(" ");
                        if (allDirectors.stream().noneMatch(a -> a.getName().equalsIgnoreCase(nameSurname.get(0)) && a.getSurname().equalsIgnoreCase(nameSurname.get(1)))) {
                            directorsToReturn.add(filmService.saveDirector(new FilmDirector(0, nameSurname.get(0), nameSurname.get(1), new ArrayList<>())));

                        } else if (allDirectors.stream().anyMatch(a -> a.getName().equalsIgnoreCase(nameSurname.get(0)) && a.getSurname().equalsIgnoreCase(nameSurname.get(1))))
                            directorsToReturn.add(allDirectors.stream().filter(a -> a.getName().equalsIgnoreCase(nameSurname.get(0)) && a.getSurname().equalsIgnoreCase(nameSurname.get(1))).findFirst().get());
                    }
                }
            }
        }

        if (cats != null) {
            if (!cats.isBlank()) {
                List<String> categories = Arrays.stream(cats.split(";")).map(c -> c.substring(0, c.length())).toList();
                List<FilmCategory> allCategories = filmService.getAllCategories();
                for (String s : categories) {
                    if (allCategories.stream().noneMatch(c -> c.getName().equalsIgnoreCase(s)) && !s.isBlank())
                        categoriesToReturn.add(filmService.saveCategory(new FilmCategory(0, s, new ArrayList<>())));
                    else if (allCategories.stream().anyMatch(c -> c.getName().equalsIgnoreCase(s)))
                        categoriesToReturn.add(allCategories.stream().filter(c -> c.getName().equalsIgnoreCase(s)).findFirst().get());
                }
            }
        }

        if (film.getPublisher() != null) {
            List<FilmPublisher> allPublishers = filmService.getAllPublishers();
            if (allPublishers.stream().anyMatch(p -> p.getName().equalsIgnoreCase(film.getPublisher().getName())))
                publisherToReturn = allPublishers.stream().filter(p -> p.getName().equalsIgnoreCase(film.getPublisher().getName())).findFirst().get();
            else if (allPublishers.stream().noneMatch(p -> p.getName().equalsIgnoreCase(film.getPublisher().getName())) && !film.getPublisher().getName().isBlank())
                publisherToReturn = filmService.savePublisher(new FilmPublisher(0, film.getPublisher().getName(), new ArrayList<>()));
            else
                return new RedirectView("http://localhost:9191/films/add?err=" + URLEncoder.encode("Некоректно надано видавця!", StandardCharsets.UTF_8));
        } else
            return new RedirectView("http://localhost:9191/films/add?err=" + URLEncoder.encode("Не надано видавця!", StandardCharsets.UTF_8));

        if (film.getStudio() != null) {
            List<FilmStudio> allStudios = filmService.getAllStudios();
            if (allStudios.stream().anyMatch(s -> s.getName().equalsIgnoreCase(film.getStudio().getName())))
                studioToReturn = allStudios.stream().filter(s -> s.getName().equalsIgnoreCase(film.getStudio().getName())).findFirst().get();
            else if (allStudios.stream().noneMatch(p -> p.getName().equalsIgnoreCase(film.getStudio().getName())) && !film.getStudio().getName().isBlank())
                studioToReturn = filmService.saveStudio(new FilmStudio(0, film.getStudio().getName(), new ArrayList<>()));
            else
                return new RedirectView("http://localhost:9191/films/add?err=" + URLEncoder.encode("Некоректно надано студію!", StandardCharsets.UTF_8));
        } else
            return new RedirectView("http://localhost:9191/films/add?err=" + URLEncoder.encode("Не надано студію!", StandardCharsets.UTF_8));

        if (existedId > 0) {
            Film existingFilm = filmService.getFilmById(existedId);
            film.setActorsMark(existingFilm.getActorsMark());
            film.setCommonMark(existingFilm.getCommonMark());
            film.setStoryMark(existingFilm.getStoryMark());
            film.setCameramanMark(existingFilm.getCameramanMark());
            film.setSoundMark(existingFilm.getSoundMark());
            film.setEffectMark(existingFilm.getEffectMark());
        }
        film.setId(existedId);
        film.getActors().addAll(actorsToReturn);
        film.getDirectors().addAll(directorsToReturn);
        film.setStudio(studioToReturn);
        film.setPublisher(publisherToReturn);
        film.getCategories().addAll(categoriesToReturn);

        Film savedFilm = filmService.saveFilm(film);

        log.info("Film with id - " + savedFilm.getId() + " was successfully saved");
        return new RedirectView("http://localhost:9191/films");
    }
}
