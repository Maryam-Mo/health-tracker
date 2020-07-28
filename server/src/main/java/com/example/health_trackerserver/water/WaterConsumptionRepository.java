package com.example.health_trackerserver.water;

import com.example.health_trackerserver.water.entity.WaterConsumption;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WaterConsumptionRepository extends JpaRepository<WaterConsumption, Long> {
    List<WaterConsumption> findAllByWaterId(long id);
}
