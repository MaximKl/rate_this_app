package com.ratethis.gameservice.repository;

import com.ratethis.gameservice.entity.game.GamePublisher;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GamePublisherRepository extends JpaRepository<GamePublisher, Integer> {
}