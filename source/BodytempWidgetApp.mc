using Toybox.Application as App;

class BodytempWidgetApp extends App.AppBase {
	hidden var BodytempView;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        BodytempView = new BodytempWidgetView();
        return [ BodytempView, new BodytempWidgetDelegate() ];
    }


}