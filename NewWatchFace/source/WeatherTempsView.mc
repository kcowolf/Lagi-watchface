import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Weather;

class WeatherTempsView extends WatchUi.Drawable {
    private var mFont;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
    }

    function draw(dc) {
        var currentConditions = Weather.getCurrentConditions();
        if (currentConditions == null) {
            return;
        }

        var viewH = (dc.getHeight() / 2);
        var x = dc.getWidth() / 2;
        var y;

        var tempsStr = Lang.format("$1$ / $2$  $3$", [
            tempStr(currentConditions.lowTemperature),
            tempStr(currentConditions.highTemperature),
            tempStr(currentConditions.temperature)
        ]);

        var dimensions = dc.getTextDimensions(tempsStr, mFont);

        y = (viewH / 2) - (dimensions[1] / 2);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, tempsStr, Graphics.TEXT_JUSTIFY_CENTER);
    }

    private function tempStr(temperatureC as Numeric) as String {
        var temperatureF = (temperatureC * 1.8) + 32;
        return temperatureF.format("%d") + "°";
    }
}