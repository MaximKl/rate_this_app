package com.ratethis.filmservice.repository;

import com.ratethis.filmservice.entity.film.FilmActor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FilmActorRepository extends JpaRepository<FilmActor, Integer> {
}