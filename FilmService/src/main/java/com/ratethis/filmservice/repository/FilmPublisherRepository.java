package com.ratethis.filmservice.repository;

import com.ratethis.filmservice.entity.film.FilmPublisher;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FilmPublisherRepository extends JpaRepository<FilmPublisher, Integer> {
}