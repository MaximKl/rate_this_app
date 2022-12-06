package com.ratethis.gameservice.repository;

import com.ratethis.gameservice.entity.user.UserGame;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserGameRepository extends JpaRepository<UserGame, Integer> {
}