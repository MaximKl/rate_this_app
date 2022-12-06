package com.ratethis.gameservice.service;

import com.ratethis.gameservice.entity.Country;
import com.ratethis.gameservice.entity.game.*;
import com.ratethis.gameservice.entity.user.User;
import com.ratethis.gameservice.entity.user.UserGame;
import com.ratethis.gameservice.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class GameService {
    @Autowired
    private GameRepository gameRepository;

    @Autowired
    private CountryRepository countryRepository;

    @Autowired
    private GameCategoryRepository gameCategoryRepository;

    @Autowired
    private GameDeveloperRepository gameDeveloperRepository;

    @Autowired
    private GamePublisherRepository gamePublisherRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserGameRepository userGameRepository;

    @Autowired
    private GameCommentRepository gameCommentRepository;

    @Autowired
    private GameReactionRepository gameReactionRepository;
    public Game saveGame(Game game) {
        return gameRepository.save(game);
    }

    public GameComment saveComment(GameComment comment){
        return gameCommentRepository.save(comment);
    }

    public GameReaction saveReaction(GameReaction reaction){
        return gameReactionRepository.save(reaction);
    }


    public Game getGameById(int id){
        return gameRepository.findById(id).orElseGet(Game::new);
    }

    public UserGame getUserGameById(int id){
        return userGameRepository.findById(id).orElseGet(UserGame::new);
    }

    public GameComment getCommentById(int id){
        return gameCommentRepository.findById(id).orElseGet(GameComment::new);
    }

    public User getUser(int id){
        return userRepository.findById(id).orElseGet(User::new);
    }

    public List<Game> getAllGames(){
        return gameRepository.findAll();
    }
    public List<Country> getAllCountries(){
        return countryRepository.findAll();
    }

    public List<GameCategory> getAllCategories(){
        return gameCategoryRepository.findAll();
    }

    public List<GameDeveloper> getAllDevelopers(){
        return gameDeveloperRepository.findAll();
    }

    public List<GamePublisher> getAllPublishers(){
        return gamePublisherRepository.findAll();
    }

    public GameDeveloper saveDeveloper(GameDeveloper gameDeveloper){
        return gameDeveloperRepository.save(gameDeveloper);
    }

    public GamePublisher savePublisher(GamePublisher gamePublisher){
        return gamePublisherRepository.save(gamePublisher);
    }

    public GameCategory saveCategory(GameCategory gameCategory){
        return gameCategoryRepository.save(gameCategory);
    }

    public UserGame saveUserGame(UserGame userGame){
        return userGameRepository.save(userGame);
    }

    public User saveUser(User user){
        return userRepository.save(user);
    }

    public void removeComment(int comId){
        gameCommentRepository.deleteById(comId);

    }

    public void removeReaction(int react){
        gameReactionRepository.deleteById(react);

    }

    @Transactional
    public void removeGame(int gameId){
        gameRepository.remove(gameId);

    }
}
