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

        var viewX = dc.getWidth() * 0.5;
        var viewY = dc.getHeight() * 0.65;
        var viewW = dc.getWidth() * 0.4;
        var viewH = dc.getHeight() * 0.20;

        //dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        //dc.drawRectangle(viewX, viewY, viewW, viewH);

        var stepsStr = steps.format("%d");
        var stepGoalStr = stepGoal.format("%d");
        var iconDimensions = dc.getTextDimensions("B", mIconFont);
        var stepsDimensions = dc.getTextDimensions(stepsStr, mFont);
        var stepGoalDimensions = dc.getTextDimensions(stepGoalStr, mFont);

        var x = viewX + ((viewW / 2) - ((iconDimensions[0] + stepGoalDimensions[0] + 2) / 2));
        var y = viewY + ((viewH / 2) - (iconDimensions[1] / 2));
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mIconFont, "B", Graphics.TEXT_JUSTIFY_LEFT);

        x += iconDimensions[0] + 2;
        y = viewY + ((viewH / 2) - ((stepsDimensions[1] + stepGoalDimensions[1]) / 2));
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, stepsStr, Graphics.TEXT_JUSTIFY_LEFT);

        y += stepGoalDimensions[1];
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, stepGoalStr, Graphics.TEXT_JUSTIFY_LEFT);
    }
}