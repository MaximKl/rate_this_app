package com.ratethis.profileservice.entity.user;

import com.ratethis.profileservice.entity.film.Film;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "user_film")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class UserFilm {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_u_film")
    private int id;

    @Column(name = "uf_effects_mark")
    private int effectMark;

    @Column(name = "uf_story_mark")
    private int storyMark;

    @Column(name = "uf_common_mark")
    private int commonMark;

    @Column(name = "uf_sound_mark")
    private int soundMark;

    @Column(name = "uf_cameraman_mark")
    private int cameramanMark;

    @Column(name = "uf_actors_mark")
    private int actorsMark;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_u_id")
    private User user;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "film_f_id")
    private Film film;

}
