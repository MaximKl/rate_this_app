package com.ratethis.filmservice.repository;

import com.ratethis.filmservice.entity.film.FilmCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FilmCategoryRepository extends JpaRepository<FilmCategory, Integer> {
}