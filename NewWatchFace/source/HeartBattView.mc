import Toybox.Application;
import Toybox.Activity;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class HeartBattView extends WatchUi.Drawable {
    private var mFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
    }

    function draw(dc) {
        var heartRateStr;

        var heartRate = Activity.getActivityInfo().currentHeartRate;
        if (heartRate == null) {
            var sample = ActivityMonitor.getHeartRateHistory(1, true).next();
            if (sample != null && sample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE) {
                heartRate = sample.heartRate;
            }
        }

        if (heartRate != null) {
            heartRateStr = heartRate.format("%d") + " BPM";
        } else {
            heartRateStr = "--";
        }

        var battery = System.getSystemStats().battery.toLong();
        var batteryStr = Lang.format("BATT $1$%", [battery]);

        var viewX = dc.getWidth() * 0.2;
        var viewW = (dc.getWidth() / 2) - viewX;
        var viewY = dc.getHeight() * 0.6;
        var viewH = dc.getHeight() - viewY;
        var x;
        var y;

        var heartRateDimensions = dc.getTextDimensions(heartRateStr, mFont);
        var batteryDimensions = dc.getTextDimensions(batteryStr, mFont);

        x = viewX + (viewW / 2);
        y = viewY + ((viewH / 2) - ((heartRateDimensions[1] + batteryDimensions[1]) / 2));
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, heartRateStr, Graphics.TEXT_JUSTIFY_CENTER);

        y += batteryDimensions[1];
        dc.drawText(x, y, mFont, batteryStr, Graphics.TEXT_JUSTIFY_CENTER);
    }
}