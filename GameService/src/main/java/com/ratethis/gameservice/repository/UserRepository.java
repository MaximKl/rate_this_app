package com.ratethis.gameservice.repository;

import com.ratethis.gameservice.entity.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
}