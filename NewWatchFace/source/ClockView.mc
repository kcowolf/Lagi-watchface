import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;

class ClockView extends WatchUi.Drawable {
    private var mHmSpacing;
    private var mMsSpacing;
    private var mFont;
    private var mSecondsFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);

        mHmSpacing = params[:hmSpacing];
        mMsSpacing = params[:msSpacing];
        mFont = WatchUi.loadResource(Rez.Fonts.ClockFont);
        mSecondsFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
    }

    function draw(dc) {
        var clockTime = System.getClockTime();

        var hour = clockTime.hour;
        if (hour > 12) {
            hour -= 12;
        } else if (hour == 0) {
            hour = 12;
        }

        var hourStr = hour.format("%02d");
        var minutesStr = clockTime.min.format("%02d");
        var secondsStr = clockTime.sec.format("%02d");

        var hoursDimensions = dc.getTextDimensions(hourStr, mFont);
        var minutesDimensions = dc.getTextDimensions(minutesStr, mFont);
        var secondsDimensions = dc.getTextDimensions(secondsStr, mSecondsFont);

        var lineLength = (dc.getWidth() * 0.75);
        var x = (dc.getWidth() / 2) - (lineLength / 2);
        var y = (dc.getHeight() / 2) - (hoursDimensions[1] / 2) + 10;

        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(x, y, x + lineLength, y);

        y += hoursDimensions[1] - 20;
        dc.drawLine(x, y, x + lineLength, y);

        var hmLength = hoursDimensions[0] + minutesDimensions[0] + mHmSpacing;

        x = (dc.getWidth() / 2) - (hmLength / 2);
        y = (dc.getHeight() / 2) - (hoursDimensions[1] / 2);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, hourStr, Graphics.TEXT_JUSTIFY_LEFT);

        x += hoursDimensions[0];
        x += mHmSpacing;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, minutesStr, Graphics.TEXT_JUSTIFY_LEFT);

        x += minutesDimensions[0];
        x += mMsSpacing;
        y = (dc.getHeight() / 2) - (secondsDimensions[1] / 2);
        dc.drawText(x, y, mSecondsFont, secondsStr, Graphics.TEXT_JUSTIFY_LEFT);
    }
}