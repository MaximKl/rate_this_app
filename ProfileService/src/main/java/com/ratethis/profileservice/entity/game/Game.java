package com.ratethis.profileservice.entity.game;

import com.ratethis.profileservice.entity.Country;
import com.ratethis.profileservice.entity.user.UserGame;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "game")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Game {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "g_id")
    private int id;

    @Column(name = "g_name")
    private String name;


    @Column(name = "g_release_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date releaseDate;

    @Column(name = "g_common_mark")
    private int commonMark;

    @Column(name = "g_effects_mark")
    private int effectMark;

    @Column(name = "g_story_mark")
    private int storyMark;

    @Column(name = "g_gameplay_mark")
    private int gameplayMark;

    @Column(name = "g_idea_mark")
    private int ideaMark;

    @Column(name = "g_sound_mark")
    private int soundMark;

    @Column(name = "g_cost")
    private int cost;

    @Column(name = "g_spent_time")
    private int spentTime;

    @Column(name = "g_description")
    private String description;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "g_publ_id")
    private GamePublisher publisher;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "categories_games",
            joinColumns = @JoinColumn(name = "cat_game_id"),
            inverseJoinColumns = @JoinColumn(name = "g_categories_id"))
    private List<GameCategory> categories;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "game", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<GameComment> comments;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "devs_games",
            joinColumns = @JoinColumn(name = "g_game_id"),
            inverseJoinColumns = @JoinColumn(name = "g_dev_id"))
    private List<GameDeveloper> developers;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "game", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<UserGame> users;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "games_countries",
            joinColumns = @JoinColumn(name = "c_game_id"),
            inverseJoinColumns = @JoinColumn(name = "g_country_id"))
    private List<Country> countries;

}
