package com.ratethis.filmservice.repository;

import com.ratethis.filmservice.entity.film.FilmReaction;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FilmReactionRepository extends JpaRepository<FilmReaction, Integer> {
}