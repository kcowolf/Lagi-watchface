import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

class NotificationsView extends WatchUi.Drawable {
    private var mFont;
    private var mIconFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
        mIconFont = WatchUi.loadResource(Rez.Fonts.IconFont);
    }

    function draw(dc) {
        var notifications = System.getDeviceSettings().notificationCount;
        var notificationsStr = notifications.format("%d");

        var viewX = 0;
        var viewY = dc.getHeight() * 0.85;
        var viewW = dc.getWidth();
        var viewH = dc.getHeight() * 0.15;

        //dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        //dc.drawRectangle(viewX, viewY, viewW, viewH);

        var iconDimensions = dc.getTextDimensions("E", mIconFont);
        var notificationDimensions = dc.getTextDimensions(notificationsStr, mFont);

        var x = viewX + (viewW / 2) - ((iconDimensions[0] + notificationDimensions[0] + 2) / 2);
        var y = viewY + (viewH / 2);

        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mIconFont, "E", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        x += (iconDimensions[0] + 2);

        if (notifications == 0) {
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        } else {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        }
        dc.drawText(x, y, mFont, notificationsStr, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}