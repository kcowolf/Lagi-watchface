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
            dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(dc.getWidth() * 0.1, dc.getHeight() / 2, mIconFont, "D", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }
}