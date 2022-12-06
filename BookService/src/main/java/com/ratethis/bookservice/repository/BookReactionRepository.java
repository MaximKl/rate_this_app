package com.ratethis.bookservice.repository;

import com.ratethis.bookservice.entity.book.BookReaction;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookReactionRepository extends JpaRepository<BookReaction, Integer> {
}