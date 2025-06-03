import Toybox.Application;
import Toybox.Activity;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class HeartRateView extends WatchUi.Drawable {
    private var mFont;
    private var mIconFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
        mIconFont = WatchUi.loadResource(Rez.Fonts.IconFont);
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
            heartRateStr = heartRate.format("%d");
        } else {
            heartRateStr = "--";
        }

        //dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        //dc.drawRectangle(locX, locY, width, height);

        var x;
        var y;

        var iconDimensions = dc.getTextDimensions("A", mIconFont);
        var heartRateDimensions = dc.getTextDimensions(heartRateStr, mFont);

        x = locX + (width / 2) - ((iconDimensions[0] + heartRateDimensions[0] + 2) / 2);
        y = locY + (height / 2);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mIconFont, "A", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        x += iconDimensions[0] + 2;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, heartRateStr, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
   }
}