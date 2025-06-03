import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

class DateView extends WatchUi.Drawable {
    private var mDayOfWeek;
    private var mDateStr;
    private var mFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
    }

    function draw(dc) {
        var now = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var dayOfWeek = now.day_of_week;
        if (dayOfWeek != mDayOfWeek) {
            mDayOfWeek = dayOfWeek;

            var dayStrings = [
                Rez.Strings.Sun,
                Rez.Strings.Mon,
                Rez.Strings.Tue,
                Rez.Strings.Wed,
                Rez.Strings.Thu,
                Rez.Strings.Fri,
                Rez.Strings.Sat,
            ];

            var monthStrings = [
                Rez.Strings.Jan,
                Rez.Strings.Feb,
                Rez.Strings.Mar,
                Rez.Strings.Apr,
                Rez.Strings.May,
                Rez.Strings.Jun,
                Rez.Strings.Jul,
                Rez.Strings.Aug,
                Rez.Strings.Sep,
                Rez.Strings.Oct,
                Rez.Strings.Nov,
                Rez.Strings.Dec,
            ];

            mDateStr = Lang.format("$1$ $2$ $3$", [
                WatchUi.loadResource(dayStrings[dayOfWeek - 1]).toUpper(),
                WatchUi.loadResource(monthStrings[now.month - 1]).toUpper(),
                now.day.format("%02d")
            ]);
        }

        //dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        //dc.drawRectangle(locX, locY, width, height);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width / 2, height / 2, mFont, mDateStr, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}