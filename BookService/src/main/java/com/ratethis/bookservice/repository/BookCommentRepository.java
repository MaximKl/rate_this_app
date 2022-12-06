package com.ratethis.bookservice.repository;

import com.ratethis.bookservice.entity.book.BookComment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookCommentRepository extends JpaRepository<BookComment, Integer> {
}