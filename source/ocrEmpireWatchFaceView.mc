import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.SensorHistory;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Activity;

class ocrEmpireWatchFaceView extends WatchUi.WatchFace {
    private var backgroundBitmap;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        backgroundBitmap = View.findDrawableById("BackgroundImage");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Clear the screen
        dc.clear();

        // Draw the background image first
        if (backgroundBitmap != null) {
            backgroundBitmap.draw(dc);
        }

        // Get the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour.format("%02d"), clockTime.min.format("%02d")]);
        var timeLabel = View.findDrawableById("TimeLabel") as Text;
        timeLabel.setText(timeString);

        // Get activity info
        var activityInfo = ActivityMonitor.getInfo();

        // Get and show calories
        var caloriesLabel = View.findDrawableById("CaloriesLabel") as Text;
        if (activityInfo != null && activityInfo.calories != null) {
            var calories = activityInfo.calories;
            caloriesLabel.setText("🔥 " + formatNumber(calories));
        } else {
            caloriesLabel.setText("🔥 --");
        }

        // Get and show battery level
        var weeklyRunsLabel = View.findDrawableById("WeeklyRunsLabel") as Text;
        var stats = System.getSystemStats();
        if (stats != null) {
            var battery = stats.battery;
            weeklyRunsLabel.setText("🔋 " + battery.format("%d") + "%");
        } else {
            weeklyRunsLabel.setText("🔋 --");
        }

        // Get and show steps with icon
        var stepsLabel = View.findDrawableById("StepsLabel") as Text;
        if (activityInfo != null && activityInfo.steps != null) {
            var steps = activityInfo.steps;
            var formattedSteps = formatNumber(steps);
            stepsLabel.setText("👣 " + formattedSteps);
        } else {
            stepsLabel.setText("👣 --");
        }

        // Get and show the current heart rate with icon
        var heartRateLabel = View.findDrawableById("HeartRateLabel") as Text;
        var hrIterator = ActivityMonitor.getHeartRateHistory(1, true);
        if (hrIterator != null) {
            var sample = hrIterator.next();
            if (sample != null && sample.heartRate != null) {
                heartRateLabel.setText("♥ " + sample.heartRate.toString());
            } else {
                heartRateLabel.setText("♥ --");
            }
        } else {
            heartRateLabel.setText("♥ --");
        }

        // Get and format the current date
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$ $2$", [today.day_of_week.substring(0, 3).toUpper(), today.day.format("%02d")]);
        var dateLabel = View.findDrawableById("DateLabel") as Text;
        dateLabel.setText(dateString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Format a number with thousands separator
    function formatNumber(number) {
        if (number == null) {
            return "";
        }
        
        var result = "";
        var numStr = number.toString();
        var len = numStr.length();
        
        for (var i = 0; i < len; i++) {
            if (i > 0 && (len - i) % 3 == 0) {
                result += ",";
            }
            result += numStr.substring(i, i + 1);
        }
        
        return result;
    }

    // Get the current heart rate
    function getHeartRate() {
        var hrIterator = null;
        if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getHeartRateHistory)) {
            hrIterator = Toybox.SensorHistory.getHeartRateHistory({});
        }
        return hrIterator;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        backgroundBitmap = null;
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }
}
