import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.Weather;

class WeatherView extends WatchUi.Drawable {
    private var mFont;
    private var mIconFont;
    private var mCondition;
    private var mDayConditionStr;
    private var mNightConditionStr;

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
        mFont = WatchUi.loadResource(Rez.Fonts.SecondsFont);
        mIconFont = WatchUi.loadResource(Rez.Fonts.WeatherIconFont);
    }

    function draw(dc) {
        var currentConditions = Weather.getCurrentConditions();
        if (currentConditions == null) {
            return;
        }

        /*
            A 65 61453 clear day
            B 66 61458 fog
            C 67 61459 cloudy
            D 68 61461 wintry mix
            E 69 61465 heavy rain
            F 70 61466 rain
            G 71 61467 snow
            H 72 61468 chance of rain
            I 73 61470 thunderstorm
            J 74 61520 windy
            K 75 61526 tornado
            L 76 61563 unknown
            M 77 61589 clear night
        */

        if (mCondition != currentConditions.condition) {
            mCondition = currentConditions.condition;
            switch (mCondition)
            {
                case Toybox.Weather.CONDITION_CLEAR:
                case Toybox.Weather.CONDITION_FAIR:
                case Toybox.Weather.CONDITION_MOSTLY_CLEAR:
                case Toybox.Weather.CONDITION_PARTLY_CLEAR:
                    mDayConditionStr = "A";
                    mNightConditionStr = "M";
                    break;
                case Toybox.Weather.CONDITION_DUST:
                case Toybox.Weather.CONDITION_FOG:
                case Toybox.Weather.CONDITION_HAZE:
                case Toybox.Weather.CONDITION_HAZY:
                case Toybox.Weather.CONDITION_MIST:
                case Toybox.Weather.CONDITION_SAND:
                case Toybox.Weather.CONDITION_SANDSTORM:
                case Toybox.Weather.CONDITION_SMOKE:
                case Toybox.Weather.CONDITION_VOLCANIC_ASH:
                    mDayConditionStr = "B";
                    mNightConditionStr = "B";
                    break;
                case Toybox.Weather.CONDITION_CLOUDY:
                case Toybox.Weather.CONDITION_PARTLY_CLOUDY:
                case Toybox.Weather.CONDITION_MOSTLY_CLOUDY:
                case Toybox.Weather.CONDITION_THIN_CLOUDS:
                    mDayConditionStr = "C";
                    mNightConditionStr = "C";
                    break;
                case Toybox.Weather.CONDITION_FREEZING_RAIN:
                case Toybox.Weather.CONDITION_HEAVY_RAIN_SNOW:
                case Toybox.Weather.CONDITION_LIGHT_RAIN_SNOW:
                case Toybox.Weather.CONDITION_RAIN_SNOW:
                case Toybox.Weather.CONDITION_SLEET:
                case Toybox.Weather.CONDITION_WINTRY_MIX:
                    mDayConditionStr = "D";
                    mNightConditionStr = "D";
                    break;
                case Toybox.Weather.CONDITION_HAIL:
                case Toybox.Weather.CONDITION_HEAVY_RAIN:
                case Toybox.Weather.CONDITION_HEAVY_SHOWERS:
                case Toybox.Weather.CONDITION_HURRICANE:
                case Toybox.Weather.CONDITION_TROPICAL_STORM:
                    mDayConditionStr = "E";
                    mNightConditionStr = "E";
                    break;
                case Toybox.Weather.CONDITION_DRIZZLE:
                case Toybox.Weather.CONDITION_LIGHT_RAIN:
                case Toybox.Weather.CONDITION_LIGHT_SHOWERS:
                case Toybox.Weather.CONDITION_RAIN:
                case Toybox.Weather.CONDITION_SCATTERED_SHOWERS:
                case Toybox.Weather.CONDITION_SHOWERS:
                case Toybox.Weather.CONDITION_UNKNOWN_PRECIPITATION:
                    mDayConditionStr = "F";
                    mNightConditionStr = "F";
                case Toybox.Weather.CONDITION_FLURRIES:
                case Toybox.Weather.CONDITION_HEAVY_SNOW:
                case Toybox.Weather.CONDITION_ICE:
                case Toybox.Weather.CONDITION_ICE_SNOW:
                case Toybox.Weather.CONDITION_LIGHT_SNOW:
                case Toybox.Weather.CONDITION_SNOW:
                    mDayConditionStr = "G";
                    mNightConditionStr = "G";
                    break;
                case Toybox.Weather.CONDITION_CHANCE_OF_RAIN_SNOW:
                case Toybox.Weather.CONDITION_CHANCE_OF_SHOWERS:
                case Toybox.Weather.CONDITION_CHANCE_OF_SNOW:
                case Toybox.Weather.CONDITION_CHANCE_OF_THUNDERSTORMS:
                case Toybox.Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN:
                case Toybox.Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN_SNOW:
                case Toybox.Weather.CONDITION_CLOUDY_CHANCE_OF_SNOW:
                    mDayConditionStr = "H";
                    mNightConditionStr = "H";
                    break;
                case Toybox.Weather.CONDITION_THUNDERSTORMS:
                case Toybox.Weather.CONDITION_SCATTERED_THUNDERSTORMS:
                    mDayConditionStr = "I";
                    mNightConditionStr = "I";
                    break;
                case Toybox.Weather.CONDITION_SQUALL:
                case Toybox.Weather.CONDITION_WINDY:
                    mDayConditionStr = "J";
                    mNightConditionStr = "J";
                    break;
                case Toybox.Weather.CONDITION_TORNADO:
                    mDayConditionStr = "K";
                    mNightConditionStr = "K";
                    break;
                case Toybox.Weather.CONDITION_UNKNOWN:
                default:
                    mDayConditionStr = "L";
                    mNightConditionStr = "L";
                    break;
            }
        }

        var viewX = dc.getWidth()* 0.1;
        var viewY = dc.getHeight()* 0.15;
        var viewW = dc.getWidth() * 0.4;
        var viewH = dc.getHeight() * 0.20;

        //dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        //dc.drawRectangle(viewX, viewY, viewW, viewH);

        var highLowtempsStr = Lang.format("$1$ $2$", [
            tempStr(currentConditions.lowTemperature),
            tempStr(currentConditions.highTemperature)
        ]);

        var currentTempStr = tempStr(currentConditions.temperature);

        var highLowDimensions = dc.getTextDimensions(highLowtempsStr, mFont);
        var currentTempDimensions = dc.getTextDimensions(currentTempStr, mFont);
        var iconDimensions = dc.getTextDimensions(mDayConditionStr, mIconFont);

        var x = viewX + (viewW / 2) - ((iconDimensions[0] + currentTempDimensions[0] + 2) / 2);
        var y = viewY + (viewH / 2) - ((iconDimensions[1] + highLowDimensions[1]) / 2);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mIconFont, mDayConditionStr, Graphics.TEXT_JUSTIFY_LEFT);

        x += iconDimensions[0] + 2;
        y += ((iconDimensions[1] / 2) - (currentTempDimensions[1] / 2));
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, currentTempStr, Graphics.TEXT_JUSTIFY_LEFT);

        x = viewX + (viewW / 2) - (highLowDimensions[0] / 2);
        y = viewY + (viewH / 2) - ((iconDimensions[1] + highLowDimensions[1]) / 2) + iconDimensions[1];
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, mFont, highLowtempsStr, Graphics.TEXT_JUSTIFY_LEFT);
    }

    private function tempStr(temperatureC as Numeric) as String {
        var temperatureF = (temperatureC * 1.8) + 32;
        return temperatureF.format("%d") + "°";
    }
}