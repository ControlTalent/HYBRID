within NHES.RAVEN_Interface.Examples;
model Bouncing_Ball_Separate_Tables
  "Bouncing Ball Example used for RAVEN Dymola Code Interface"
  parameter Real e=0.7 "coefficient of restitution";
  parameter Real g=9.81 "gravity acceleration";
  parameter Real hstart = 7.5377 "height of ball at time zero";
  parameter Real vstart = 0 "velocity of ball at time zero";
  Real h(start=hstart,fixed=true) "height of ball";
  Real v(start=vstart,fixed=true) "velocity of ball";
  Boolean flying(start=true) "true, if ball is flying";
  Boolean impact;
  Real v_new;
  Integer foo;
  parameter Integer n = 10;

  //*************************************************//
  //New vectorization for time-dependent RAVEN input;
  //Replaces 2nd vector in old table
  parameter Real wind_speeds_vec[n] = {1,2,3,4,5,6,7,8,9,10};
  Integer count(start=1);
  //Replaces 1st vector in old table, but we ignore the 0 time moment.
  parameter Real time_setpoint_vec[n] = {1,2,3,4,5,6,7,8,9,10}; //Starts at first time of event, so effectively this vector is offset from the wind speeds vector by 1 location.
  //I will try to work on that some since that's kind of annoying.
  //I will also work on making this potentially smooth, right now it's stepping between points.
  Real v_wind;
  Real time_step;
  //*************************************************//
initial equation
  time_step = time_setpoint_vec[1];
equation
  impact = h <= 0.0;
  foo = if impact then 1 else 2;
  der(v) = if flying then -g else 0;
  der(h) = v+v_wind*min(1,h);

  when {h <= 0.0 and v <= 0.0,impact} then
    v_new = if edge(impact) then -e*pre(v) else 0;
    flying = v_new > 0;
    reinit(v, v_new);
  end when;
  //Code to step in time along our vectors
  when time>time_step then
    count = pre(count)+1;
    time_step = pre(time_step) + time_setpoint_vec[count]-pre(time_step); //Must be within the when() loop and must use pre() stuff for Modelica reasons.
  end when;
    v_wind = wind_speeds_vec[count];
    //End of new code

//   annotation (uses(Modelica(version="3.2.1")),
//     experiment(StopTime=10, Interval=0.1),
//     __Dymola_experimentSetupOutput);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,56},{64,-4},{-36,-64},{-36,56}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Bouncing_Ball_Separate_Tables;