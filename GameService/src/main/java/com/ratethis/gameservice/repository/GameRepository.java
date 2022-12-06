package com.ratethis.gameservice.repository;

import com.ratethis.gameservice.entity.game.Game;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface GameRepository extends JpaRepository<Game, Integer> {

    @Modifying
    @Query(value = "CALL rate_this_db.deliter(:id)", nativeQuery = true)
    void remove(@Param("id") int id);

}
