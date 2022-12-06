package com.ratethis.filmservice.entity.book;

import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "b_author")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class BookAuthor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "author_id")
    private int id;

    @Column(name = "author_name")
    private String name;

    @Column(name = "author_surname")
    private String surname;

    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "authors_books",
            joinColumns = @JoinColumn(name = "b_author_id"),
            inverseJoinColumns = @JoinColumn(name = "a_book_id"))
    private List<Book> books;
}
