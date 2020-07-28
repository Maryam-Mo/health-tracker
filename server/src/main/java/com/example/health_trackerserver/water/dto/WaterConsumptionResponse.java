package com.example.health_trackerserver.water.dto;

import com.example.health_trackerserver.water.entity.WaterConsumption;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class WaterConsumptionResponse {
    private long waterId;
    private double minConsumption;
    private List<WaterConsumption> waterConsumptions;
}
