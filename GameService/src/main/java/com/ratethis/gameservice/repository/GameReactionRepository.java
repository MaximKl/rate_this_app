package com.ratethis.gameservice.repository;

import com.ratethis.gameservice.entity.game.GameReaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface GameReactionRepository extends JpaRepository<GameReaction, Integer> {

}