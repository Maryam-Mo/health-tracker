package com.example.health_trackerserver.commons.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author Maryam Moein <maryam.moein@hotmail.com>
 */
public enum  DateUtil {
    INSTANCE;

    private DateUtil(){}

    public Long convertToMillis(String date) {
        SimpleDateFormat f = new SimpleDateFormat("dd-MMM-yyyy");
        try {
            Date d = f.parse(date);
            return d.getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
}
