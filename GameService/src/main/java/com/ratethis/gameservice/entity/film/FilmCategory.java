package com.ratethis.gameservice.entity.film;


import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "f_categories")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class FilmCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;
    @Column(name = "cat_name")
    private String name;

    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "categories_films",
            joinColumns = @JoinColumn(name = "f_categories_id"),
            inverseJoinColumns = @JoinColumn(name = "cat_film_id"))
    private List<Film> films;
}
