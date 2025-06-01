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

        var viewX = dc.getWidth()* 0.5;
        var viewY = dc.getHeight()* 0.15;
        var viewW = dc.getWidth() * 0.4;
        var viewH = dc.getHeight() * 0.20;

        //dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        //dc.drawRectangle(viewX, viewY, viewW, viewH);

        var iconDimensions = dc.getTextDimensions("C", mIconFont);
        var batteryDimensions = dc.getTextDimensions(batteryStr, mFont);

        var x = viewX + (viewW / 2) - ((iconDimensions[0] + batteryDimensions[0] + 2) / 2);
        var y = viewY + (viewH / 2) - ((iconDimensions[1]) / 2);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mIconFont, "C", Graphics.TEXT_JUSTIFY_LEFT);

        x += iconDimensions[0] + 2;
        y += ((iconDimensions[1] / 2) - (batteryDimensions[1] / 2));
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, batteryStr, Graphics.TEXT_JUSTIFY_LEFT);
    }
}