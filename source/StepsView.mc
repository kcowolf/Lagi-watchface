import Toybox.Application;
import Toybox.ActivityMonitor;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class StepsView extends WatchUi.Drawable {
    private var mFont;
    private var mIconFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
        mIconFont = WatchUi.loadResource(Rez.Fonts.IconFont);
    }

    function draw(dc) {
        var steps = ActivityMonitor.getInfo().steps;
        var stepGoal = ActivityMonitor.getInfo().stepGoal;

        //dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        //dc.drawRectangle(locX, locY, width, height);

        var stepsStr = steps.format("%d");
        var stepGoalStr = stepGoal.format("%d");
        var iconDimensions = dc.getTextDimensions("B", mIconFont);
        var stepsDimensions = dc.getTextDimensions(stepsStr, mFont);
        var stepGoalDimensions = dc.getTextDimensions(stepGoalStr, mFont);

        var x = locX + ((width / 2) - ((iconDimensions[0] + stepGoalDimensions[0] + 2) / 2));
        var y = locY + ((height / 2) - (iconDimensions[1] / 2));
        dc.setColor(gAccentColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mIconFont, "B", Graphics.TEXT_JUSTIFY_LEFT);

        x += iconDimensions[0] + 2;
        y = locY + ((height / 2) - ((stepsDimensions[1] + stepGoalDimensions[1]) / 2));
        dc.setColor(gPrimaryTextColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, stepsStr, Graphics.TEXT_JUSTIFY_LEFT);

        y += stepGoalDimensions[1];
        dc.setColor(gSecondaryTextColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, stepGoalStr, Graphics.TEXT_JUSTIFY_LEFT);
    }
}