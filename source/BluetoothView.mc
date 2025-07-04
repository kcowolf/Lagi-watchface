import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class BluetoothView extends WatchUi.Drawable {
    private var mIconFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mIconFont = WatchUi.loadResource(Rez.Fonts.IconFont);
    }

    function draw(dc) {
        if (System.getDeviceSettings().phoneConnected) {
            dc.setColor(gAccentColor, Graphics.COLOR_TRANSPARENT);
        } else {
            dc.setColor(gDisabledColor, Graphics.COLOR_TRANSPARENT);
        }
        dc.drawText(locX, locY, mIconFont, "D", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}