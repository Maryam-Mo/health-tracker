package com.example.health_trackerserver.water;

import com.example.health_trackerserver.water.entity.Water;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

/**
 * @author Maryam Moein <maryam.moein@hotmail.com>
 */
public interface WaterRepository extends JpaRepository<Water, Long> {
    Optional<Water> findByDate(Long convertToMillis);
}
