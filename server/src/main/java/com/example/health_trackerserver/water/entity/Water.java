package com.example.health_trackerserver.water.entity;

import lombok.*;
import javax.persistence.*;

/**
 * @author Maryam Moein <maryam.moein@hotmail.com>
 */

@Entity
@Table(name = "WATER")
@NoArgsConstructor
@Getter
@Setter
@EqualsAndHashCode()
@ToString()
public class Water {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private long date;
    private double minConsumption;

    public Water(long date, double minConsumption) {
        this.date = date;
        this.minConsumption = minConsumption;
    }
}
