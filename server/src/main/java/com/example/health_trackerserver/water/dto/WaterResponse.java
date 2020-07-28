package com.example.health_trackerserver.water.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class WaterResponse {
    private long id;
    private long date;
    private double minConsumption;
}
