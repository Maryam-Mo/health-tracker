package com.example.health_trackerserver.water;

import com.example.health_trackerserver.HealthTrackerServerApplicationTests;
import com.example.health_trackerserver.commons.util.DateUtil;
import com.example.health_trackerserver.water.dto.WaterConsumptionRequest;
import com.example.health_trackerserver.water.dto.WaterConsumptionResponse;
import com.example.health_trackerserver.water.dto.WaterRequest;
import com.example.health_trackerserver.water.dto.WaterResponse;
import com.example.health_trackerserver.water.entity.WaterConsumption;
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
        assertEquals(savedWater.getId(), updatedWater.getId());
        assertEquals(savedWater.getDate(), updatedWater.getDate());
        assertEquals(savedWater.getMinConsumption(), updatedWater.getMinConsumption(), 0);
    }

    @Test
    public void createWaterConsumption() {
        final WaterConsumptionResponse waterConsumptionResponse = waterService.createWaterConsumption(getWaterConsumption());

        assertNotNull(waterConsumptionResponse);
        assertEquals(1, waterConsumptionResponse.getWaterConsumptions().size());
        assertEquals(getWaterConsumption().getConsumption(), waterConsumptionResponse.getWaterConsumptions().get(0).getConsumption(), 0);
        assertEquals(getWaterConsumption().getTime(), waterConsumptionResponse.getWaterConsumptions().get(0).getTime());
    }

    @Test
    public void updateWaterConsumption() {
        final WaterConsumptionResponse createdWaterConsumptionResponse = waterService.createWaterConsumption(getWaterConsumption());
        final WaterConsumptionRequest waterConsumptionRequest = new WaterConsumptionRequest(createdWaterConsumptionResponse.getWaterId(), getWaterConsumption().getTime(), 0.6);
        final WaterConsumptionResponse updatedWaterConsumptionResponse = waterService.updateWaterConsumption(waterConsumptionRequest);

        assertNotNull(updatedWaterConsumptionResponse);
        assertEquals(waterConsumptionRequest.getWaterId(), updatedWaterConsumptionResponse.getWaterId(), 0);
        assertEquals(1, updatedWaterConsumptionResponse.getWaterConsumptions().size());
    }

    @Test
    public void findByDate() {
        waterService.createWaterConsumption(getWaterConsumption());
        String date = "2019-12-12";
        WaterConsumptionResponse waterConsumptionResponse = waterService.findByDate(DateUtil.INSTANCE.convertToMillis(date));

        assertNotNull(waterConsumptionResponse);
        assertEquals(waterConsumptionResponse.getWaterConsumptions().size(), 1);
    }

    @Test
    public void deleteWaterConsumption() {
        final WaterConsumptionResponse createdWaterConsumptionResponse = waterService.createWaterConsumption(getWaterConsumption());
        final WaterConsumptionRequest waterConsumptionRequest = new WaterConsumptionRequest(createdWaterConsumptionResponse.getWaterId(), getWaterConsumption().getTime(), getWaterConsumption().getConsumption());
        final WaterConsumptionResponse waterConsumptionResponse = waterService.deleteWaterConsumption(waterConsumptionRequest);

        assertNotNull(waterConsumptionResponse);
        assertEquals(waterConsumptionResponse.getWaterConsumptions().size(), 0);
    }

    private WaterRequest getWater() {
        long date = DateUtil.INSTANCE.convertToMillis("2019-12-12");
        return new WaterRequest(date, 2);
    }

    private WaterConsumptionRequest getWaterConsumption() {
        WaterResponse savedWater = waterService.create(getWater());
        return new WaterConsumptionRequest(savedWater.getId(), "12 pm", 0.5);
    }
}
