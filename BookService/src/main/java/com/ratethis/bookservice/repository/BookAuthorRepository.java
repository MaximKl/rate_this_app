package com.ratethis.bookservice.repository;

import com.ratethis.bookservice.entity.book.BookAuthor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookAuthorRepository extends JpaRepository<BookAuthor, Integer> {
}