package com.ratethis.gameservice.repository;

import com.ratethis.gameservice.entity.game.GameComment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GameCommentRepository extends JpaRepository<GameComment, Integer> {
}