using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Sensor as Sensor;
using Toybox.Timer;
using Toybox.SensorHistory;

class BodytempWidgetView extends Ui.View {
	hidden var mTitle = "Body";
	hidden var subTitle = "Temprature (°C)";
	hidden var f_subTitle = "Temprature (°F)";

    function initialize() {

        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
		View.setLayout(Rez.Layouts.MainLayout(dc));
    	mTitle = "Body";
    	subTitle = "Temperature (°C)";
        View.findDrawableById("title").setText(mTitle);
        View.findDrawableById("subtitle").setText(subTitle);
        View.findDrawableById("value").setText(" ");
        
    }
    
	function timerCallback() {

	}
    

	function getIterator() {
	
	    if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getTemperatureHistory)) {

	        return Toybox.SensorHistory.getTemperatureHistory({});
	    }
	    return null;
	}

    
    // Update the view
    function onUpdate(dc) {

   		var sensorIter = getIterator();
   		var temp_data = sensorIter.next().data;
   		
   		var body_temp = 0.109*temp_data + 33.07;
   		var f_body_temp = (body_temp*9)/5 + 32;
   		
    	if (body_temp != null) {
    	
			View.findDrawableById("value").setText((body_temp).format("%.1f"));
			View.findDrawableById("f_value").setText((f_body_temp).format("%.1f")+" °F");
    	
    		if (body_temp < 36) {
				View.findDrawableById("value").setColor(Gfx.COLOR_BLUE);
				View.findDrawableById("f_value").setColor(Gfx.COLOR_BLUE);
			}
			else if (body_temp >=36 && body_temp <37){
				View.findDrawableById("value").setColor(Gfx.COLOR_GREEN);
				View.findDrawableById("f_value").setColor(Gfx.COLOR_GREEN);
			}
			else if (body_temp >=37 && body_temp <38){
				View.findDrawableById("value").setColor(Gfx.COLOR_ORANGE);
				View.findDrawableById("f_value").setColor(Gfx.COLOR_ORANGE);
			}
			else if (body_temp >=38){
				View.findDrawableById("value").setColor(Gfx.COLOR_RED);
				View.findDrawableById("f_value").setColor(Gfx.COLOR_RED);
			}
			
   	    } 
   	    
   	    else {
			View.findDrawableById("title").setText(mTitle + "\nnot available");
			View.findDrawableById("value").setText(" ");
			View.findDrawableById("value").setColor(Gfx.COLOR_WHITE);
			View.findDrawableById("f_value").setColor(Gfx.COLOR_WHITE);
        }
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
}

