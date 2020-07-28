package com.example.health_trackerserver.water;

import com.example.health_trackerserver.commons.exception.HealthTrackerException;
import com.example.health_trackerserver.commons.util.DateUtil;
import com.example.health_trackerserver.water.dto.WaterConsumptionRequest;
import com.example.health_trackerserver.water.dto.WaterConsumptionResponse;
import com.example.health_trackerserver.water.dto.WaterRequest;
import com.example.health_trackerserver.water.dto.WaterResponse;
import com.example.health_trackerserver.water.entity.Water;
import com.example.health_trackerserver.water.entity.WaterConsumption;
import ma.glasnost.orika.MapperFacade;
import net.bytebuddy.implementation.bytecode.Throw;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Maryam Moein <maryam.moein@hotmail.com>
 */
@Service
public class WaterServiceImpl implements WaterService {

    private final WaterRepository waterRepository;
    private final WaterConsumptionRepository waterConsumptionRepository;
    private final MapperFacade modelMapper;

    WaterServiceImpl(WaterRepository waterRepository, WaterConsumptionRepository waterConsumptionRepository, MapperFacade modelMapper) {
        this.waterRepository = waterRepository;
        this.waterConsumptionRepository = waterConsumptionRepository;
        this.modelMapper = modelMapper;
    }

    @Override
    public WaterResponse create(WaterRequest waterRequest) {
        final Water water = modelMapper.map(waterRequest, Water.class);
        final Water savedWater = waterRepository.save(water);
        return modelMapper.map(savedWater, WaterResponse.class);
    }

    @Override
    public WaterResponse update(WaterRequest waterRequest) {
        final Water water = modelMapper.map(waterRequest, Water.class);
        waterRepository.findByDate(water.getDate()).orElseThrow(() -> new HealthTrackerException("Invalid water request!"));
        final Water updatedWater = waterRepository.save(water);
        return modelMapper.map(updatedWater, WaterResponse.class);
    }

    @Override
    public WaterConsumptionResponse findByDate(String date) {
        final Water water = waterRepository.findByDate(DateUtil.INSTANCE.convertToMillis(date)).get();
        final List<WaterConsumption> waterConsumptions = waterConsumptionRepository.findAllByWaterId(water.getId());
        return new WaterConsumptionResponse(water.getId(), water.getMinConsumption(), waterConsumptions);
    }

    @Override
    public WaterConsumptionResponse deleteWaterConsumption(long id) {
        final WaterConsumption waterConsumption = waterConsumptionRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid waterConsumption id"));
        waterConsumptionRepository.deleteById(id);
        final List<WaterConsumption> waterConsumptions = waterConsumptionRepository.findAllByWaterId(waterConsumption.getWater().getId());
        return new WaterConsumptionResponse(waterConsumption.getId(), waterConsumption.getWater().getMinConsumption(), waterConsumptions);
    }

    @Override
    public WaterConsumptionResponse createWaterConsumption(final WaterConsumptionRequest waterConsumptionRequest) {
        final Water water = waterRepository.findById(waterConsumptionRequest.getWaterId()).orElseThrow(() -> new IllegalArgumentException("Invalid water id"));
        final WaterConsumption waterConsumption = waterConsumptionRepository.save(new WaterConsumption(waterConsumptionRequest.getTime(),
                waterConsumptionRequest.getConsumption(), water));
        return mapAllWaterConsumptionsToWaterConsumptionResponse(waterConsumption);
    }

    @Override
    public WaterConsumptionResponse updateWaterConsumption(final WaterConsumptionRequest waterConsumptionRequest) {
        final WaterConsumption waterConsumption = waterConsumptionRepository.findById(waterConsumptionRequest.getWaterConsumptionId()).orElseThrow(() -> new IllegalArgumentException("Invalid waterConsumption id"));
        waterConsumption.setTime(waterConsumptionRequest.getTime());
        waterConsumption.setConsumption(waterConsumptionRequest.getConsumption());
        waterConsumptionRepository.save(waterConsumption);
        return mapAllWaterConsumptionsToWaterConsumptionResponse(waterConsumption);
    }

    private WaterConsumptionResponse mapAllWaterConsumptionsToWaterConsumptionResponse(final WaterConsumption waterConsumption) {
        final List<WaterConsumption> waterConsumptions = waterConsumptionRepository.findAllByWaterId(waterConsumption.getWater().getId());
        return new WaterConsumptionResponse(waterConsumption.getWater().getId(), waterConsumption.getWater().getMinConsumption(), waterConsumptions);
    }
}
