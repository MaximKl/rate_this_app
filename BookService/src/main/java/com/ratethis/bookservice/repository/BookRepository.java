package com.ratethis.bookservice.repository;

import com.ratethis.bookservice.entity.book.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface BookRepository extends JpaRepository<Book, Integer> {

    @Modifying
    @Query(value = "CALL rate_this_db.book_deliter(:id)", nativeQuery = true)
    void remove(@Param("id") int id);

}