package com.ratethis.filmservice.entity.game;

import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "g_dev")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class GameDeveloper {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "g_dev_id")
    private int id;

    @Column(name = "g_dev_name")
    private String name;

    @ToString.Exclude
    @ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    @JoinTable(name = "devs_games",
            joinColumns = @JoinColumn(name = "g_dev_id"),
            inverseJoinColumns = @JoinColumn(name = "g_game_id"))
    private List<Game> games;


}
