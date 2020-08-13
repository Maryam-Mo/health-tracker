package com.example.health_trackerserver.water;

import com.example.health_trackerserver.water.dto.WaterConsumptionRequest;
import com.example.health_trackerserver.water.dto.WaterConsumptionResponse;
import com.example.health_trackerserver.water.dto.WaterRequest;
import com.example.health_trackerserver.water.dto.WaterResponse;
import com.example.health_trackerserver.water.entity.Water;
import com.example.health_trackerserver.water.entity.WaterConsumption;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author Maryam Moein <maryam.moein@hotmail.com>
 */

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("api/water")
public class WaterResource {

    private final WaterService waterService;

    public WaterResource(final WaterService waterService) {
        this.waterService = waterService;
    }

    @ApiOperation(value = "Create new water")
    @PostMapping("/create")
    public WaterResponse create(@RequestBody WaterRequest waterRequest) {
        return waterService.create(waterRequest);
    }

    @ApiOperation(value = "Update existed water")
    @PostMapping("/update")
    public WaterResponse update(@RequestBody WaterRequest waterRequest) {
        return waterService.update(waterRequest);
    }

    @GetMapping("/findAllConsumptionsByDate/{date}")
    public WaterConsumptionResponse findByDate(@PathVariable Long date) {
        return waterService.findByDate(date);
    }

    @ApiOperation(value = "Delete existed waterConsumption")
    @PostMapping("/deleteWaterConsumption")
    public WaterConsumptionResponse deleteWaterConsumption(@RequestBody WaterConsumptionRequest waterConsumptionRequest){
        return waterService.deleteWaterConsumption(waterConsumptionRequest);
    }

    @ApiOperation(value = "Create new waterConsumption")
    @PostMapping("/createWaterConsumption")
    public WaterConsumptionResponse create(@RequestBody WaterConsumptionRequest waterConsumptionRequest) {
        return waterService.createWaterConsumption(waterConsumptionRequest);
    }

    @ApiOperation(value = "Update new waterConsumption")
    @PostMapping("/updateWaterConsumption")
    public WaterConsumptionResponse update(@RequestBody WaterConsumptionRequest waterConsumptionRequest) {
        return waterService.updateWaterConsumption(waterConsumptionRequest);
    }
}
