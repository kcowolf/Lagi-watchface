import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

var gBackgroundColor;
var gAccentColor;
var gPrimaryTextColor;
var gSecondaryTextColor;
var gDisabledColor;
var gLineColor;

class lagi_watchfaceView extends WatchUi.WatchFace {

    function initialize() {
        onSettingsChanged();
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onSettingsChanged() as Void {
        gBackgroundColor = Application.Properties.getValue("BackgroundColor") as Number;
        gAccentColor = Application.Properties.getValue("AccentColor") as Number;
        gPrimaryTextColor = Application.Properties.getValue("PrimaryTextColor") as Number;
        gSecondaryTextColor = Application.Properties.getValue("SecondaryTextColor") as Number;
        gDisabledColor = Application.Properties.getValue("DisabledColor") as Number;
        gLineColor = Application.Properties.getValue("LineColor") as Number;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
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
}
