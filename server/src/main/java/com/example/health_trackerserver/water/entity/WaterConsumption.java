package com.example.health_trackerserver.water.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "WATER_CONSUMPTION")
@NoArgsConstructor
@Getter
@Setter
@EqualsAndHashCode(exclude = "water")
@ToString(exclude = "water")
public class WaterConsumption {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String time;
    private double consumption;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "water_id")
    private Water water;

    public WaterConsumption(String time, double consumption, Water water) {
        this.time = time;
        this.consumption = consumption;
        this.water = water;
    }
}
