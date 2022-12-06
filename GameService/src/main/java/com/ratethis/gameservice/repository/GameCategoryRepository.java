package com.ratethis.gameservice.repository;

import com.ratethis.gameservice.entity.game.GameCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GameCategoryRepository extends JpaRepository<GameCategory, Integer> {
}