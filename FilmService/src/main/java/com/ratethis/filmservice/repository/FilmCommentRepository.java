package com.ratethis.filmservice.repository;

import com.ratethis.filmservice.entity.film.FilmComment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FilmCommentRepository extends JpaRepository<FilmComment, Integer> {
}