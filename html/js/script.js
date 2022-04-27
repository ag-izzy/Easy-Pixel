const nui_devtools = new Image;
nui_devtools.__defineGetter__("id", function() {
    $.post('http://'+GetParentResourceName()+'/EZPX:OpenNUIDevtoolsDetected', JSON.stringify({}));
});