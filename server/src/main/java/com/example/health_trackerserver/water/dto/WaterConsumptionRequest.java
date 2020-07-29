package com.example.health_trackerserver.water.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class WaterConsumptionRequest {
    private long waterConsumptionId;
    private long waterId;
    private String time;
    private double consumption;

    public WaterConsumptionRequest(final long waterId, final String time, final double consumption) {
        this.waterId = waterId;
        this.time = time;
        this.consumption = consumption;
    }

    public WaterConsumptionRequest(final long waterConsumptionId, final long waterId) {
        this.waterConsumptionId = waterConsumptionId;
        this.waterId = waterId;
    }
}
