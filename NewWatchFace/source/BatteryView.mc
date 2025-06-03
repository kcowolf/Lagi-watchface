import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.Weather;

class BatteryView extends WatchUi.Drawable {
    private var mFont;
    private var mIconFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
        mIconFont = WatchUi.loadResource(Rez.Fonts.IconFont);
    }

    function draw(dc) {

        var battery = System.getSystemStats().battery.toLong();
        var batteryStr = battery.format("%d") + "%";

        //dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        //dc.drawRectangle(locX, locY, width, height);

        var iconDimensions = dc.getTextDimensions("C", mIconFont);
        var batteryDimensions = dc.getTextDimensions(batteryStr, mFont);

        var x = locX + (width / 2) - ((iconDimensions[0] + batteryDimensions[0] + 2) / 2);
        var y = locY + (height / 2);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mIconFont, "C", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        x += iconDimensions[0] + 2;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, batteryStr, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}