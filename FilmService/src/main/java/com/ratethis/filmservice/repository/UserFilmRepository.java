package com.ratethis.filmservice.repository;

import com.ratethis.filmservice.entity.user.UserFilm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserFilmRepository extends JpaRepository<UserFilm,Integer> {
}
