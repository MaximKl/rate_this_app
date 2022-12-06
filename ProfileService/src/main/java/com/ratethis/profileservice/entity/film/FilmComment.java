package com.ratethis.profileservice.entity.film;

import com.ratethis.profileservice.entity.user.User;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "f_comment")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class FilmComment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "com_id")
    private int id;

    @Column(name = "com_rating")
    private int rating;

    @Column(name = "com_like")
    private int like;

    @Column(name = "com_dislike")
    private int dislike;

    @Column(name = "com_body")
    private String body;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "u_film_com_id")
    private Film film;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "f_user_com_id")
    private User user;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "comment", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<FilmReaction> reactions;

}
