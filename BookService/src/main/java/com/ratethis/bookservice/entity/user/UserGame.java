package com.ratethis.bookservice.entity.user;

import com.ratethis.bookservice.entity.game.Game;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "user_game")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class UserGame {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_u_game")
    private int id;

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

    @Column(name = "g_spent_time")
    private int spentTime;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "ug_user_id")
    private User user;

    @ToString.Exclude
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @JoinColumn(name = "ug_game_id")
    private Game game;

}
