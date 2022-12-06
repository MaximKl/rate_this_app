package com.ratethis.filmservice.repository;

import com.ratethis.filmservice.entity.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
}