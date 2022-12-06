package com.ratethis.bookservice.entity.book;

import com.ratethis.bookservice.entity.Country;
import com.ratethis.bookservice.entity.user.UserBook;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "book")
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "b_id")
    private int id;

    @Column(name = "b_common_mark")
    private int commonMark;

    @Column(name = "b_art_mark")
    private int artMark;

    @Column(name = "b_description")
    private String description;

    @Column(name = "b_name")
    private String name;

    @Column(name = "b_release_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date releaseDate;

    @Column(name = "b_size")
    private int size;

    @Column(name = "b_story_mark")
    private int storyMark;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "authors_books",
            joinColumns = @JoinColumn(name = "a_book_id"),
            inverseJoinColumns = @JoinColumn(name = "b_author_id"))
    private List<BookAuthor> authors;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "categories_books",
            joinColumns = @JoinColumn(name = "cat_book_id"),
            inverseJoinColumns = @JoinColumn(name = "b_categories_id"))
    private List<BookCategory> categories;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "books_countries",
            joinColumns = @JoinColumn(name = "c_book_id"),
            inverseJoinColumns = @JoinColumn(name = "b_country_id"))
    private List<Country> countries;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "book", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<BookComment> comments;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "book", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<UserBook> users;

    public Book() {

        authors = new ArrayList<>();
        categories = new ArrayList<>();
        countries = new ArrayList<>();
        comments = new ArrayList<>();
        users = new ArrayList<>();

    }
}
