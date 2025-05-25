import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

var HoursFont;
var SecondsFont;

class NewWatchFaceView extends WatchUi.WatchFace {
    private var mDateLabel;
    private var mHoursLabel;
    private var mMinutesLabel;
    private var mSecondsLabel;
    private var mLines = [];

    private var mDayOfWeek;
    private var mDayOfWeekStr;
    private var mMonth;
    private var mMonthStr;

    function initialize() {
        WatchFace.initialize();

        HoursFont = WatchUi.loadResource(Rez.Fonts.HoursFont);
        SecondsFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));

        mDateLabel = View.findDrawableById("DateLabel") as Text;
        mHoursLabel = View.findDrawableById("HoursLabel") as Text;
        mMinutesLabel = View.findDrawableById("MinutesLabel") as Text;
        mSecondsLabel = View.findDrawableById("SecondsLabel") as Text;

        mLines.add(linePixelCoords(dc, 0.15, 0.4, 0.85, 0.4));
        mLines.add(linePixelCoords(dc, 0.15, 0.6, 0.85, 0.6));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        updateClock(dc);
        updateDate(dc);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        // Draw calls which must be done after updating the layout
        drawLines(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }


    hidden function drawLines(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);
        for (var i = 0; i < mLines.size(); i++) {
            dc.drawLine(mLines[i][0], mLines[i][1], mLines[i][2], mLines[i][3]);
        }
    }

    hidden function linePixelCoords(dc as Dc, x1 as Float, y1 as Float, x2 as Float, y2 as Float) as Array {
        return [Math.ceil(dc.getWidth() * x1), Math.ceil(dc.getHeight() * y1), Math.ceil(dc.getWidth() * x2), Math.ceil(dc.getHeight() * y2)];
    }

    hidden function updateClock(dc as Dc) as Void {
        var clockTime = System.getClockTime();

        var hour = clockTime.hour;
        if (hour > 12) {
            hour -= 12;
        }

        var minutesStr = clockTime.min.format("%02d");

        mHoursLabel.setText(hour.format("%02d"));
        mMinutesLabel.setText(minutesStr);
        mSecondsLabel.setText(clockTime.sec.format("%02d"));

        var minutesWidth = dc.getTextWidthInPixels(minutesStr, HoursFont);
        mSecondsLabel.locX = mMinutesLabel.locX + minutesWidth + 3;
    }

    hidden function updateDate(dc as Dc) as Void {
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
            mDayOfWeekStr = WatchUi.loadResource(dayStrings[mDayOfWeek - 1]).toUpper();
        }

        var month = now.month;
        if (month != mMonth) {
            mMonth = month;
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
            mMonthStr = WatchUi.loadResource(monthStrings[mMonth - 1]).toUpper();
        }

        mDateLabel.setText(Lang.format("$1$ $2$ $3$", [mDayOfWeekStr, mMonthStr, now.day.format("%d")]));
    }
}
