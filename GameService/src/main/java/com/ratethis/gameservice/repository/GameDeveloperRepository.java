package com.ratethis.gameservice.repository;

import com.ratethis.gameservice.entity.game.GameDeveloper;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GameDeveloperRepository extends JpaRepository<GameDeveloper, Integer> {
}