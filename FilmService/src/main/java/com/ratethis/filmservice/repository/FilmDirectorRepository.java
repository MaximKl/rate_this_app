package com.ratethis.filmservice.repository;

import com.ratethis.filmservice.entity.film.FilmDirector;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FilmDirectorRepository extends JpaRepository<FilmDirector, Integer> {
}