package com.ratethis.bookservice.repository;

import com.ratethis.bookservice.entity.book.BookCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookCategoryRepository extends JpaRepository<BookCategory, Integer> {
}