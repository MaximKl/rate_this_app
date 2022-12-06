package com.ratethis.profileservice.entity.book;
import com.ratethis.profileservice.entity.user.User;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "b_reaction")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class BookReaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "r_id")
    private int id;

    @Column(name = "r_like")
    private boolean like;

    @Column(name = "r_dislike")
    private boolean dislike;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "com_id")
    private BookComment comment;

}
