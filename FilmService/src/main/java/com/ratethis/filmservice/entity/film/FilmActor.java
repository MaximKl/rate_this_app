package com.ratethis.filmservice.entity.film;

import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "f_actor")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class FilmActor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "f_actor_id")
    private int id;

    @Column(name = "f_actor_name")
    private String name;

    @Column(name = "f_actor_surname")
    private String surname;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "actors_films",
            joinColumns = @JoinColumn(name = "f_actor_id"),
            inverseJoinColumns = @JoinColumn(name = "a_film_id"))
    private List<Film> films;

}
