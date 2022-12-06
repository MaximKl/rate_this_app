package com.ratethis.bookservice.repository;

import com.ratethis.bookservice.entity.user.UserBook;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserBookRepository extends JpaRepository<UserBook, Integer> {
}