package com.ratethis.filmservice.service;

import com.ratethis.filmservice.entity.Country;
import com.ratethis.filmservice.entity.film.*;
import com.ratethis.filmservice.entity.user.User;
import com.ratethis.filmservice.entity.user.UserFilm;
import com.ratethis.filmservice.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FilmService {
    @Autowired
    private FilmRepository filmRepository;

    @Autowired
    private CountryRepository countryRepository;

    @Autowired
    private FilmCategoryRepository filmCategoryRepository;

    @Autowired
    private FilmActorRepository filmActorRepository;

    @Autowired
    private FilmPublisherRepository filmPublisherRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserFilmRepository userFilmRepository;

    @Autowired
    private FilmCommentRepository filmCommentRepository;

    @Autowired
    private FilmReactionRepository filmReactionRepository;

    @Autowired
    private FilmStudioRepository filmStudioRepository;

    @Autowired
    private FilmDirectorRepository filmDirectorRepository;

    public Film saveFilm(Film film) {
        return filmRepository.save(film);
    }

    public FilmComment saveComment(FilmComment comment){
        return filmCommentRepository.save(comment);
    }

    public FilmReaction saveReaction(FilmReaction reaction){
        return filmReactionRepository.save(reaction);
    }


    public Film getFilmById(int id){
        return filmRepository.findById(id).orElseGet(Film::new);
    }

    public UserFilm getUserFilmById(int id){
        return userFilmRepository.findById(id).orElseGet(UserFilm::new);
    }

    public FilmComment getCommentById(int id){
        return filmCommentRepository.findById(id).orElseGet(FilmComment::new);
    }

    public User getUser(int id){
        return userRepository.findById(id).orElseGet(User::new);
    }

    public List<Film> getAllFilms(){
        return filmRepository.findAll();
    }
    public List<Country> getAllCountries(){
        return countryRepository.findAll();
    }

    public List<FilmCategory> getAllCategories(){
        return filmCategoryRepository.findAll();
    }

    public List<FilmDirector> getAllDirectors(){
        return filmDirectorRepository.findAll();
    }

    public List<FilmPublisher> getAllPublishers(){
        return filmPublisherRepository.findAll();
    }

    public List<FilmActor> getAllActors(){
        return filmActorRepository.findAll();
    }

    public List<FilmStudio> getAllStudios(){
        return filmStudioRepository.findAll();
    }

    public FilmDirector saveDirector(FilmDirector filmDirector){
        return filmDirectorRepository.save(filmDirector);
    }

    public FilmPublisher savePublisher(FilmPublisher filmPublisher){
        return filmPublisherRepository.save(filmPublisher);
    }
    public FilmStudio saveStudio(FilmStudio filmStudio){
        return filmStudioRepository.save(filmStudio);
    }

    public FilmCategory saveCategory(FilmCategory filmCategory){
        return filmCategoryRepository.save(filmCategory);
    }

    public UserFilm saveUserFilm(UserFilm userFilm){
        return userFilmRepository.save(userFilm);
    }

    public FilmActor saveActor(FilmActor actor){
        return filmActorRepository.save(actor);
    }

    public User saveUser(User user){
        return userRepository.save(user);
    }

    public void removeComment(int comId){
        filmCommentRepository.deleteById(comId);

    }

    public void removeReaction(int react){
        filmReactionRepository.deleteById(react);

    }

    @Transactional
    public void removeFilm(int filmId){
        filmRepository.remove(filmId);

    }
}
