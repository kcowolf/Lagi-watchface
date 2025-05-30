import Toybox.Application;
import Toybox.ActivityMonitor;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class StepsView extends WatchUi.Drawable {
    private var mFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
    }

    function draw(dc) {
        var steps = ActivityMonitor.getInfo().steps;
        var stepGoal = ActivityMonitor.getInfo().stepGoal;

        var viewX = dc.getWidth() / 2;
        var viewY = dc.getHeight() * 0.6;
        var viewH = dc.getHeight() - viewY;
        var x;
        var y;

        var stepsStr = steps.format("%d");
        var stepGoalStr = stepGoal.format("%d");
        var stepsDimensions = dc.getTextDimensions(stepsStr, mFont);
        var stepGoalDimensions = dc.getTextDimensions(stepGoalStr, mFont);

        x = viewX + ((dc.getWidth() - viewX) / 2);
        y = viewY + ((viewH / 2) - ((stepsDimensions[1] + stepGoalDimensions[1]) / 2));
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, stepsStr, Graphics.TEXT_JUSTIFY_CENTER);

        y += stepGoalDimensions[1];
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, stepGoalStr, Graphics.TEXT_JUSTIFY_CENTER);
    }
}