package com.example.health_trackerserver.water;

import com.example.health_trackerserver.water.dto.WaterConsumptionRequest;
import com.example.health_trackerserver.water.dto.WaterConsumptionResponse;
import com.example.health_trackerserver.water.dto.WaterRequest;
import com.example.health_trackerserver.water.dto.WaterResponse;
import com.example.health_trackerserver.water.entity.Water;

/**
 * @author Maryam Moein <maryam.moein@hotmail.com>
 */
public interface WaterService {
    WaterResponse create(WaterRequest waterRequest);
    WaterResponse update(WaterRequest waterRequest);
    WaterConsumptionResponse findByDate(Long date);
    WaterConsumptionResponse deleteWaterConsumption(WaterConsumptionRequest waterConsumptionRequest);
    WaterConsumptionResponse createWaterConsumption(WaterConsumptionRequest waterConsumptionRequest);
    WaterConsumptionResponse updateWaterConsumption(WaterConsumptionRequest waterConsumptionRequest);
}
