package com.ratethis.bookservice.entity.book;

import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "b_categories")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class BookCategory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "cat_name")
    private String name;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "categories_books",
            joinColumns = @JoinColumn(name = "b_categories_id"),
            inverseJoinColumns = @JoinColumn(name = "cat_book_id"))
    private List<Book> books;
}
