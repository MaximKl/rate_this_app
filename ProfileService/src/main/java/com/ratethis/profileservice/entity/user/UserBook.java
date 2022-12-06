package com.ratethis.profileservice.entity.user;
import com.ratethis.profileservice.entity.book.Book;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "user_book")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class UserBook {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_u_book")
    private int id;

    @Column(name = "b_common_mark")
    private int commonMark;

    @Column(name = "b_art_mark")
    private int artMark;

    @Column(name = "b_story_mark")
    private int storyMark;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_u_id")
    private User user;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "book_b_id")
    private Book book;

}
