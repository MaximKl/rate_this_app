package com.ratethis.filmservice.repository;


import com.ratethis.filmservice.entity.film.Film;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface FilmRepository extends JpaRepository<Film,Integer> {

    @Modifying
    @Query(value = "CALL rate_this_db.film_deliter(:id)", nativeQuery = true)
    void remove(@Param("id") int id);

}
