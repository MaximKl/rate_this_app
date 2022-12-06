package com.ratethis.filmservice.entity.game;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "g_publ")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@JsonIgnoreProperties({"games","hibernateLazyInitializer", "handler"})
public class GamePublisher {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "g_publ_id")
    private int id;

    @Column(name = "g_publ_name")
    private String name;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "publisher", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<Game> games;

}
