package com.ratethis.gameservice.entity.film;

import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "f_publ")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class FilmPublisher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "f_pabl_id")
    private int id;

    @Column(name = "f_pabl_name")
    private String name;

    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "publisher", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<Film> films;

}
