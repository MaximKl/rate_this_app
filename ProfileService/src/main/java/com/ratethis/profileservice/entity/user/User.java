package com.ratethis.profileservice.entity.user;

import com.ratethis.profileservice.entity.book.BookComment;
import com.ratethis.profileservice.entity.book.BookReaction;
import com.ratethis.profileservice.entity.film.FilmComment;
import com.ratethis.profileservice.entity.film.FilmReaction;
import com.ratethis.profileservice.entity.game.GameComment;
import com.ratethis.profileservice.entity.game.GameReaction;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "u_profile")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "u_id")
    private int id;

    @Column(name = "u_nickname")
    private String nickname;

    @Column(name = "u_password")
    private String password;

    @Column(name = "u_email")
    private String email;

    @Column(name = "u_is_admin")
    private boolean isAdmin;

    @Column(name = "u_desc")
    private String description;


    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<UserGame> games;


    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<UserBook> books;


    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<UserFilm> films;


    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<BookComment> bookComments;

    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<GameComment> gameComments;

    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<FilmComment> filmComments;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<GameReaction> reactions;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<FilmReaction> filmReactions;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<BookReaction> bookReactions;

    public void setIsAdmin(boolean b) {
        isAdmin=b;
    }
    public boolean getIsAdmin() {
        return isAdmin;
    }
}
