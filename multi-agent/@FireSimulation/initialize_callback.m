function initialize_callback(app,event)
app.InitializefirstLampLabel.Text = "Initializing";
app.InitializefirstLamp.Color = [1 0 0];
flag.wind_average = app.windaverageCheckBox.Value;
flag.debug = 0;
flag.ns = app.SpreadingEditField_2.Value;
flag.nf = app.FlyingEditField_2.Value;

app.step_end = app.SimstepEditField.Value; % Description
app.unum = app.FirefightersEditField.Value;
if isempty(app.map.W)
  app.map.set_target();
end
wind_data = app.WinddataEditField.Value;
app.map.setup_wind(wind_data);
app.map.set_gridcell_model();

app.step_end = 240;
app.TimeSlider.Limits = [0,app.SimstepEditField.Value];
app.InitializefirstLampLabel.Text = "Ready";
app.InitializefirstLamp.Color = [0 1 0];
end