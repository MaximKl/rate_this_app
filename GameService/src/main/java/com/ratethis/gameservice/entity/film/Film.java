package com.ratethis.gameservice.entity.film;

import com.ratethis.gameservice.entity.Country;
import com.ratethis.gameservice.entity.user.UserFilm;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "film")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Film {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "f_id")
    private int id;

    @Column(name = "f_name")
    private String name;

    @Column(name = "f_cost")
    private int cost;

    @Column(name = "f_effects_mark")
    private int effectMark;

    @Column(name = "f_story_mark")
    private int storyMark;

    @Column(name = "f_common_mark")
    private int commonMark;

    @Column(name = "f_sound_mark")
    private int soundMark;

    @Column(name = "f_cameraman_mark")
    private int cameramanMark;

    @Column(name = "f_length")
    private int length;

    @Column(name = "f_actors_mark")
    private int actorsMark;

    @Column(name = "f_release_date")
    private Date releaseDate;

    @Column(name = "f_description")
    private String description;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "f_stud_id")
    private FilmStudio studio;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "f_publ_id")
    private FilmPublisher publisher;

    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "film", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<UserFilm> users;

    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "categories_films",
            joinColumns = @JoinColumn(name = "cat_film_id"),
            inverseJoinColumns = @JoinColumn(name = "f_categories_id"))
    private List<FilmCategory> categories;


    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "films_countries",
            joinColumns = @JoinColumn(name = "c_film_id"),
            inverseJoinColumns = @JoinColumn(name = "f_country_id"))
    private List<Country> countries;


    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "film", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<FilmComment> comments;


    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "actors_films",
            joinColumns = @JoinColumn(name = "a_film_id"),
            inverseJoinColumns = @JoinColumn(name = "f_actor_id"))
    private List<FilmActor> actors;

    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "directors_films",
            joinColumns = @JoinColumn(name = "d_film_id"),
            inverseJoinColumns = @JoinColumn(name = "f_director_id"))
    private List<FilmDirector> directors;
}
