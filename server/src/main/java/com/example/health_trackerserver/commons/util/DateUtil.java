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
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date d = f.parse(date);
            return d.getTime();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String convertMillisToDate(long millis) {
        Date date = new Date(millis);
        SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
        return df2.format(date);
    }
}
