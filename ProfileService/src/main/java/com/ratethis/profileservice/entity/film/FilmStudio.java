package com.ratethis.profileservice.entity.film;

import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "f_studio")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class FilmStudio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "f_stud_id")
    private int id;

    @Column(name = "f_stud_name")
    private String name;

    @ToString.Exclude
    @OneToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, mappedBy = "studio", fetch = FetchType.LAZY)
    @Fetch(value = FetchMode.SUBSELECT)
    private List<Film> films;

}
