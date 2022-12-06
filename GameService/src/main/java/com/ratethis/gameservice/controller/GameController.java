package com.ratethis.gameservice.controller;

import com.ratethis.gameservice.entity.Country;
import com.ratethis.gameservice.entity.game.*;
import com.ratethis.gameservice.entity.user.User;
import com.ratethis.gameservice.entity.user.UserGame;
import com.ratethis.gameservice.service.GameService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.QueryParam;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

@Controller
@RequestMapping("/games")
@Slf4j
public class GameController {

    @Autowired
    private GameService gameService;

    @GetMapping("")
    private String getGame(@RequestParam(value = "gname", required = false) String gameName, Model userModel) {
        List<Game> allGames = gameService.getAllGames();
        List<Game> gamesToReturn = new ArrayList<>();
        if (gameName != null) {
            if (!gameName.isBlank()) {
                List<String> words = Arrays.stream(gameName.split(" ")).toList();
                for (Game g : allGames) {
                    List<String> gNameWords = Arrays.stream(g.getName().split(" ")).toList();
                    for (String s : words) {
                        if (gNameWords.stream().anyMatch(w -> s.equalsIgnoreCase(w)) && gamesToReturn.stream().noneMatch(game -> game.getName().equalsIgnoreCase(g.getName())))
                            gamesToReturn.add(g);
                    }
                }
                if (gamesToReturn.isEmpty()) {
                    userModel.addAttribute("mes", "Пошук за назвою - '" + gameName + "' не дав результатів");
                    userModel.addAttribute("searched", gameName);
                    userModel.addAttribute("allGames", gamesToReturn);
                    userModel.addAttribute("user", new User());
                    log.info("Bad filtered games page");
                    return "games-page";
                }
            }
        }

        if (gamesToReturn.isEmpty()) {
            userModel.addAttribute("allGames", allGames.stream().sorted(Comparator.comparing(Game::getName)).toList());
        } else {
            userModel.addAttribute("allGames", gamesToReturn.stream().sorted(Comparator.comparing(Game::getName)).toList());
            userModel.addAttribute("mes", "Результати пошуку за назвою - " + gameName);
            userModel.addAttribute("searched", gameName);
        }
        userModel.addAttribute("user", new User());
        log.info("Getting all games page");
        return "games-page";
    }


    @PostMapping
    private @ResponseBody String removeGame(@RequestParam(value = "gameId") String gameId){
        if(gameId!=null){
            if(!gameId.isBlank()){
                gameService.removeGame(Integer.parseInt(gameId));
                return "OK";
            }
        }


        return "BAD";
    }

    @GetMapping("/add")
    private String addGame(Model gameModel) {
        gameModel.addAttribute("game", new Game());
        gameModel.addAttribute("allPublishers", gameService.getAllPublishers());
        gameModel.addAttribute("allCategories", gameService.getAllCategories().stream().sorted(Comparator.comparing(GameCategory::getName)).toList());
        gameModel.addAttribute("allDevelopers", gameService.getAllDevelopers().stream().sorted(Comparator.comparing(GameDeveloper::getName)).toList());
        gameModel.addAttribute("allCountries", gameService.getAllCountries().stream().sorted(Comparator.comparing(Country::getName)).toList());
        gameModel.addAttribute("allGames", gameService.getAllGames());
        log.info("Getting add-game page");
        return "add-game";
    }


    @GetMapping("/{id}")
    private String getGame(@PathVariable("id") int id, Model userModel, HttpServletRequest request,
                           @RequestParam(value = "comM", required = false) String commonMark,
                           @RequestParam(value = "efM", required = false) String effectMark,
                           @RequestParam(value = "stM", required = false) String storyMark,
                           @RequestParam(value = "soundM", required = false) String soundMark,
                           @RequestParam(value = "gamM", required = false) String gameplayMark,
                           @RequestParam(value = "ideaM", required = false) String ideaMark,
                           @RequestParam(value = "toChange", required = false) String toChange,
                           @RequestParam(value = "spt", required = false) String spentTime) {

        Game searchedGame = gameService.getGameById(id);
        User user = null;
        boolean isUserScoreGame = false;
        boolean alwaysTrue = false;
        boolean isOperation = false;
        int ugId = 0;
        if (searchedGame.getId() == 0)
            return "redirect:/profile";

        List<Integer> numbers = new ArrayList<>();
        for (int i = 0; i < 101; i++)
            numbers.add(i);

        List<Cookie> cookies = Arrays.stream(request.getCookies()).toList();
        if (cookies.stream().anyMatch(c -> c.getName().equals("user_id"))) {
            if (searchedGame.getComments().stream().anyMatch(c -> c.getUser().getId() == Integer.parseInt(cookies.stream().filter(cc -> cc.getName().equals("user_id")).findFirst().get().getValue())))
                alwaysTrue = true;
            user = gameService.getUser(Integer.parseInt(cookies.stream().filter(c -> c.getName().equals("user_id")).findFirst().get().getValue()));
            if (user.getGames().stream().anyMatch(g -> g.getGame().getId() == id)) {
                isUserScoreGame = true;
            }
        }

        if (toChange != null) {
            if (toChange.equals("1"))
                isUserScoreGame = false;
        }

        if (commonMark != null && effectMark != null && storyMark != null && soundMark != null && gameplayMark != null && spentTime != null && ideaMark != null && user != null) {
            if (!commonMark.isBlank() && !effectMark.isBlank() && !storyMark.isBlank() && !soundMark.isBlank() && !gameplayMark.isBlank() && !ideaMark.isBlank() && !spentTime.isBlank() && !isUserScoreGame) {
                try {
                    int comM = Integer.parseInt(commonMark);
                    int effM = Integer.parseInt(effectMark);
                    int stM = Integer.parseInt(storyMark);
                    int soundM = Integer.parseInt(soundMark);
                    int gamM = Integer.parseInt(gameplayMark);
                    int ideaM = Integer.parseInt(ideaMark);
                    int spt = Integer.parseInt(spentTime);
                    if (comM >= 0 && comM <= 100 && effM >= 0 && effM <= 100 && stM >= 0 && stM <= 100 && soundM >= 0 && soundM <= 100 && gamM >= 0 && gamM <= 100 && ideaM >= 0 && ideaM <= 100 && spt >= 1) {
                        if (user.getGames().stream().anyMatch(g -> g.getGame().getId() == id)) {
                            ugId = user.getGames().stream().filter(userGame -> userGame.getGame().getId() == id).findFirst().get().getId();
                            UserGame receivedUg = gameService.getUserGameById(ugId);
                            receivedUg.setCommonMark(comM);
                            receivedUg.setEffectMark(effM);
                            receivedUg.setIdeaMark(ideaM);
                            receivedUg.setSoundMark(soundM);
                            receivedUg.setGameplayMark(gamM);
                            receivedUg.setStoryMark(stM);
                            receivedUg.setSpentTime(spt);
                            gameService.saveUserGame(receivedUg);
                        } else {
                            user.getGames().add(gameService.saveUserGame(new UserGame(0, comM, effM, stM, gamM, ideaM, soundM, spt, user, searchedGame)));
                            gameService.saveUser(user);
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

        List<GameComment> userComments = new ArrayList<>();
        if (alwaysTrue) {
            userComments = user.getGameComments().stream().filter(gc -> gc.getGame().getId() == id).toList();
            userModel.addAttribute("thisGameComment", userComments);
        }

        userModel.addAttribute("isCommented", !userComments.isEmpty());
        userModel.addAttribute("isScored", isUserScoreGame);
        userModel.addAttribute("numbers", numbers);
        userModel.addAttribute("game", searchedGame);
        userModel.addAttribute("gameComments", searchedGame.getComments().stream().sorted(Comparator.comparingInt(GameComment::getRating).reversed()).toList());
        userModel.addAttribute("user", new User());
        log.info("Getting the page of a game - " + searchedGame.getName());
        if (isOperation)
            return "redirect:/games/" + id;
        return "game-page";
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
                GameComment gc = gameService.getCommentById(Integer.parseInt(commentId));
                User user = gameService.getUser(Integer.parseInt(userId));
                if (gc.getId() != 0 && user.getId() != 0) {
                    if (user.getReactions().stream().noneMatch(r -> r.getComment().getId() == gc.getId())) {
                        if (isLiked.equals("true")) {
                            gameService.saveReaction(new GameReaction(0, true, false, user, gc));
                        } else if (isLiked.equals("false")) {
                            gameService.saveReaction(new GameReaction(0, false, true, user, gc));
                        }
                        return "OK";
                    } else {
                        GameReaction previousReaction = user.getReactions().stream().filter(reaction -> reaction.getComment().getId() == gc.getId()).findFirst().get();
                        if (previousReaction.isLike() && isLiked.equals("true")) {
                            previousReaction.setLike(false);
                            gameService.saveReaction(previousReaction);
                        } else if (previousReaction.isLike() && isLiked.equals("false")) {
                            previousReaction.setLike(false);
                            previousReaction.setDislike(true);
                            gameService.saveReaction(previousReaction);
                            return "change";
                        } else if (previousReaction.isDislike() && isLiked.equals("false")) {
                            previousReaction.setDislike(false);
                            gameService.saveReaction(previousReaction);
                        } else if (previousReaction.isDislike() && isLiked.equals("true")) {
                            previousReaction.setDislike(false);
                            previousReaction.setLike(true);
                            gameService.saveReaction(previousReaction);
                            return "change";
                        } else if (!previousReaction.isDislike() && !previousReaction.isLike() && isLiked.equals("true")) {
                            previousReaction.setLike(true);
                            gameService.saveReaction(previousReaction);
                            return "OK";
                        } else if (!previousReaction.isDislike() && !previousReaction.isLike() && isLiked.equals("false")) {
                            previousReaction.setDislike(true);
                            gameService.saveReaction(previousReaction);
                            return "OK";
                        }
                        return "removed";
                    }
                }
            }
        }

        if (comment != null && userId != null) {
            if (!comment.isBlank() && !userId.isBlank()) {
                Game searchedGame = gameService.getGameById(id);
                if (searchedGame.getId() == 0)
                    return "BAD";
                User user = gameService.getUser(Integer.parseInt(userId));
                if (user.getId() != 0) {
                    if(user.getGameComments().stream().noneMatch(g->g.getGame().getId()==searchedGame.getId())) {
                        gameService.saveComment(new GameComment(0, 0, 0, 0, comment, user, searchedGame, new ArrayList<>()));
                        return "OK";
                    }else{
                        return "alreadyCommented";
                    }
                }
            }
        }

        if (isDeleteCom != null && commentId != null) {
            if (isDeleteCom.equals("true") && !commentId.isBlank()) {
                GameComment gc = gameService.getCommentById(Integer.parseInt(commentId));
                if(!gc.getReactions().isEmpty()) {
                    List<GameReaction> gReact = gc.getReactions();
                    gReact.forEach(reaction -> {
                        reaction.setComment(null);
                        reaction.setUser(null);
                        gameService.saveReaction(reaction);
                        gameService.removeReaction(reaction.getId());
                    });
                }
                gameService.removeComment(Integer.parseInt(commentId));
                return "OK";
            }
        }
        return "BAD";
    }


    @PostMapping("/add")
    private RedirectView postGame(@ModelAttribute("game") Game game, @QueryParam("devs") String devs, @QueryParam("cats") String cats) {
        List<Game> allGames = gameService.getAllGames();
        int existedId = 0;
        if (game.getName() != null) {
            if (!game.getName().isBlank()) {
                if (allGames.stream().anyMatch(g -> g.getName().equalsIgnoreCase(game.getName())))
                    existedId = allGames.stream().filter(g -> g.getName().equalsIgnoreCase(game.getName())).map(Game::getId).findFirst().get();
            }
        }

        List<GameDeveloper> developersToReturn = new ArrayList<>();
        GamePublisher publisherToReturn;
        List<GameCategory> categoriesToReturn = new ArrayList<>();
        if (devs != null) {
            if (!devs.isBlank()) {
                List<String> developers = Arrays.stream(devs.split(";")).map(d -> d.substring(0, d.length())).toList();
                List<GameDeveloper> allDevelopers = gameService.getAllDevelopers();
                for (String s : developers) {
                    if (allDevelopers.stream().noneMatch(d -> d.getName().equalsIgnoreCase(s)) && !s.isBlank())
                        developersToReturn.add(gameService.saveDeveloper(new GameDeveloper(0, s, new ArrayList<>())));
                    else if (allDevelopers.stream().anyMatch(d -> d.getName().equalsIgnoreCase(s)))
                        developersToReturn.add(allDevelopers.stream().filter(d -> d.getName().equalsIgnoreCase(s)).findFirst().get());
                }
            }
        }

        if (cats != null) {
            if (!cats.isBlank()) {
                List<String> categories = Arrays.stream(cats.split(";")).map(c -> c.substring(0, c.length())).toList();
                List<GameCategory> allCategories = gameService.getAllCategories();
                for (String s : categories) {
                    if (allCategories.stream().noneMatch(c -> c.getName().equalsIgnoreCase(s)) && !s.isBlank())
                        categoriesToReturn.add(gameService.saveCategory(new GameCategory(0, s, new ArrayList<>())));
                    else if (allCategories.stream().anyMatch(c -> c.getName().equalsIgnoreCase(s)))
                        categoriesToReturn.add(allCategories.stream().filter(c -> c.getName().equalsIgnoreCase(s)).findFirst().get());
                }
            }
        }

        if (game.getPublisher() != null) {
            List<GamePublisher> allPublishers = gameService.getAllPublishers();
            if (allPublishers.stream().anyMatch(p -> p.getName().equalsIgnoreCase(game.getPublisher().getName())))
                publisherToReturn = allPublishers.stream().filter(p -> p.getName().equalsIgnoreCase(game.getPublisher().getName())).findFirst().get();
            else if (allPublishers.stream().noneMatch(p -> p.getName().equalsIgnoreCase(game.getPublisher().getName())) && !game.getPublisher().getName().isBlank())
                publisherToReturn = gameService.savePublisher(new GamePublisher(0, game.getPublisher().getName(), new ArrayList<>()));
            else
                return new RedirectView("http://localhost:9191/games/add?err=" + URLEncoder.encode("Некоректно надано видавця!", StandardCharsets.UTF_8));
        } else
            return new RedirectView("http://localhost:9191/games/add?err=" + URLEncoder.encode("Не надано видавця!", StandardCharsets.UTF_8));

        if(existedId>0){
            Game existingGame =  gameService.getGameById(existedId);
            game.setIdeaMark(existingGame.getIdeaMark());
            game.setCommonMark(existingGame.getCommonMark());
            game.setStoryMark(existingGame.getStoryMark());
            game.setGameplayMark(existingGame.getGameplayMark());
            game.setSoundMark(existingGame.getSoundMark());
            game.setEffectMark(existingGame.getEffectMark());
        }

        game.setId(existedId);
        game.getDevelopers().addAll(developersToReturn);
        game.setPublisher(publisherToReturn);
        game.getCategories().addAll(categoriesToReturn);

        Game savedGame = gameService.saveGame(game);

        log.info("Game with id - " + savedGame.getId() + " was successfully saved");
        return new RedirectView("http://localhost:9191/games");
    }

}
