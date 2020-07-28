package com.example.health_trackerserver.water;

import com.example.health_trackerserver.HealthTrackerServerApplicationTests;
import com.example.health_trackerserver.commons.util.DateUtil;
import com.example.health_trackerserver.water.dto.WaterConsumptionRequest;
import com.example.health_trackerserver.water.dto.WaterConsumptionResponse;
import com.example.health_trackerserver.water.dto.WaterRequest;
import com.example.health_trackerserver.water.dto.WaterResponse;
import ma.glasnost.orika.MapperFacade;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

/**
 * @author Maryam Moein <maryam.moein@hotmail.com>
 */
public class WaterServiceTest extends HealthTrackerServerApplicationTests {

    @Autowired
    private WaterService waterService;
    @Autowired
    private MapperFacade modelMapper;

    @Test
    public void create() {
        final WaterResponse savedWater = waterService.create(getWater());

        assertNotNull(savedWater.getId());
        assertEquals(getWater().getDate(), savedWater.getDate());
        assertEquals(getWater().getMinConsumption(), savedWater.getMinConsumption(), 0);
    }

    @Test
    public void update() {
        final WaterResponse savedWater = waterService.create(getWater());
        savedWater.setMinConsumption(3);
        final WaterResponse updatedWater = waterService.update(modelMapper.map(savedWater, WaterRequest.class));

        assertNotNull(updatedWater);
        assertEquals(savedWater.getDate(), updatedWater.getDate());
        assertEquals(savedWater.getMinConsumption(), updatedWater.getMinConsumption(), 0);
    }

    @Test
    public void createWaterConsumption() {
        final WaterConsumptionResponse waterConsumptionResponse = waterService.createWaterConsumption(getWaterConsumption());

        assertNotNull(waterConsumptionResponse);
        assertEquals(2, waterConsumptionResponse.getMinConsumption(), 0);
        assertEquals(waterConsumptionResponse.getWaterConsumptions().size(), 1);
    }

    @Test
    public void findByDate() {
        waterService.createWaterConsumption(getWaterConsumption());
        String date = "12-December-2019";
        WaterConsumptionResponse waterConsumptionResponse = waterService.findByDate(date);

        assertNotNull(waterConsumptionResponse);
        assertEquals(2, waterConsumptionResponse.getMinConsumption(), 0);
        assertEquals(waterConsumptionResponse.getWaterConsumptions().size(), 1);
    }

    private WaterRequest getWater() {
        long date = DateUtil.INSTANCE.convertToMillis("12-December-2019");
        return new WaterRequest(date, 2);
    }

    private WaterConsumptionRequest getWaterConsumption() {
        WaterResponse savedWater = waterService.create(getWater());
        return new WaterConsumptionRequest(savedWater.getId(), "12 pm", 0.5);
    }
}
