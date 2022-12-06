package com.ratethis.filmservice.entity.film;

import com.ratethis.filmservice.entity.user.User;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "f_reaction")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class FilmReaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "r_id")
    private int id;

    @Column(name = "r_like")
    private boolean like;

    @Column(name = "r_dislike")
    private boolean dislike;

    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "com_id")
    private FilmComment comment;

}
