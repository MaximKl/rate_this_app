package com.ratethis.gameservice.entity;

import com.ratethis.gameservice.entity.book.Book;
import com.ratethis.gameservice.entity.film.Film;
import com.ratethis.gameservice.entity.game.Game;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "country")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Country {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "c_name")
    private String name;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "books_countries",
            joinColumns = @JoinColumn(name = "b_country_id"),
            inverseJoinColumns = @JoinColumn(name = "c_book_id"))
    private List<Book> books;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "games_countries",
            joinColumns = @JoinColumn(name = "g_country_id"),
            inverseJoinColumns = @JoinColumn(name = "c_game_id"))
    private List<Game> games;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "films_countries",
            joinColumns = @JoinColumn(name = "f_country_id"),
            inverseJoinColumns = @JoinColumn(name = "c_film_id"))
    private List<Film> films;

}
