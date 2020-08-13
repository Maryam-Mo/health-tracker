package com.example.health_trackerserver.water.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ConsumptionResponse {
    private String time;
    private double consumption;
}
