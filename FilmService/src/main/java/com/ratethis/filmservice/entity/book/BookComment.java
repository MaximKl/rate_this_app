package com.ratethis.filmservice.entity.book;

import com.ratethis.filmservice.entity.film.FilmReaction;
import com.ratethis.filmservice.entity.user.User;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "b_comment")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class BookComment {

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
    @JoinColumn(name = "b_user_com_id")
    private User user;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "u_book_com_id")
    private Book book;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "comment", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<BookReaction> reactions;

}
