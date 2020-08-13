package com.example.health_trackerserver.water;

import com.example.health_trackerserver.commons.exception.HealthTrackerException;
import com.example.health_trackerserver.commons.util.DateUtil;
import com.example.health_trackerserver.water.dto.*;
import com.example.health_trackerserver.water.entity.Water;
import com.example.health_trackerserver.water.entity.WaterConsumption;
import ma.glasnost.orika.MapperFacade;
import net.bytebuddy.implementation.bytecode.Throw;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

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
        final Optional<Water> waterOptional = waterRepository.findByDate(waterRequest.getDate());
        if (!waterOptional.isPresent()) {
            final Water water = modelMapper.map(waterRequest, Water.class);
            final Water savedWater = waterRepository.save(water);
            return modelMapper.map(savedWater, WaterResponse.class);
        }
        return modelMapper.map(waterOptional.get(), WaterResponse.class);
    }

    @Override
    public WaterResponse update(WaterRequest waterRequest) {
        final Water water = modelMapper.map(waterRequest, Water.class);
        final Water savedWater = waterRepository.findByDate(water.getDate()).orElseThrow(() -> new HealthTrackerException("Invalid water request!"));
        water.setId(savedWater.getId());
        final Water updatedWater = waterRepository.save(water);
        return modelMapper.map(updatedWater, WaterResponse.class);
    }

    @Override
    public WaterConsumptionResponse findByDate(Long date) {
        final Water water = waterRepository.findByDate(date).orElseThrow(() -> new IllegalArgumentException("Invalid water date"));
        return mapAllWaterConsumptionsToWaterConsumptionResponse(water.getId());
    }

    @Override
    public WaterConsumptionResponse deleteWaterConsumption(WaterConsumptionRequest waterConsumptionRequest) {
        final WaterConsumption waterConsumption = waterConsumptionRepository.findByTimeAndWaterId(waterConsumptionRequest.getTime(), waterConsumptionRequest.getWaterId());
        waterConsumptionRepository.deleteById(waterConsumption.getId());
        return mapAllWaterConsumptionsToWaterConsumptionResponse(waterConsumptionRequest.getWaterId());
    }

    @Override
    public WaterConsumptionResponse createWaterConsumption(final WaterConsumptionRequest waterConsumptionRequest) {
        final Water water = waterRepository.findById(waterConsumptionRequest.getWaterId()).orElseThrow(() -> new IllegalArgumentException("Invalid water id"));
        WaterConsumption waterConsumption = null;
        if (checkIsUnique(waterConsumptionRequest.getTime(), waterConsumptionRequest.getWaterId()) == null) {
            waterConsumption = new WaterConsumption(waterConsumptionRequest.getTime(),
                    waterConsumptionRequest.getConsumption(), water);
        } else {
            waterConsumption = checkIsUnique(waterConsumptionRequest.getTime(), waterConsumptionRequest.getWaterId());
            waterConsumption.setConsumption(waterConsumptionRequest.getConsumption());
            waterConsumption.setWater(water);
        }
        waterConsumptionRepository.save(waterConsumption);
        return mapAllWaterConsumptionsToWaterConsumptionResponse(waterConsumptionRequest.getWaterId());
    }

    @Override
    public WaterConsumptionResponse updateWaterConsumption(final WaterConsumptionRequest waterConsumptionRequest) {
        final WaterConsumption waterConsumption = waterConsumptionRepository.findByTimeAndWaterId(waterConsumptionRequest.getTime(), waterConsumptionRequest.getWaterId());
        waterConsumption.setConsumption(waterConsumptionRequest.getConsumption());
        waterConsumptionRepository.save(waterConsumption);
        return mapAllWaterConsumptionsToWaterConsumptionResponse(waterConsumptionRequest.getWaterId());
    }

    private WaterConsumptionResponse mapAllWaterConsumptionsToWaterConsumptionResponse(final long id) {
        final List<WaterConsumption> waterConsumptions = waterConsumptionRepository.findAllByWaterId(id);
        final List<ConsumptionResponse> consumptionResponses = new ArrayList<>();
        waterConsumptions.forEach(waterConsum -> {
            consumptionResponses.add(new ConsumptionResponse(waterConsum.getTime(), waterConsum.getConsumption()));
        });
        return new WaterConsumptionResponse(id, consumptionResponses);
    }

    private WaterConsumption checkIsUnique(String time, long waterId) {
        WaterConsumption waterConsumptions = waterConsumptionRepository.findByTimeAndWaterId(time, waterId);
        if (waterConsumptions == null) {
            return null;
        }
        return waterConsumptions;
    }
}
