package com.ratethis.filmservice.repository;

import com.ratethis.filmservice.entity.film.FilmStudio;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FilmStudioRepository extends JpaRepository<FilmStudio, Integer> {
}