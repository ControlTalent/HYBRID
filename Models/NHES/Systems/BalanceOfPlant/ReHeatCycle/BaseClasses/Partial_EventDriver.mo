within NHES.Systems.BalanceOfPlant.ReHeatCycle.BaseClasses;
partial model Partial_EventDriver

  extends NHES.Systems.BaseClasses.Partial_EventDriver;

  RankineCycle.BaseClasses.SignalSubBus_ActuatorInput actuatorBus annotation (
      Placement(transformation(extent={{10,-120},{50,-80}}), iconTransformation(
          extent={{10,-120},{50,-80}})));
  RankineCycle.BaseClasses.SignalSubBus_SensorOutput sensorBus annotation (
      Placement(transformation(extent={{-50,-120},{-10,-80}}),
        iconTransformation(extent={{-50,-120},{-10,-80}})));

  annotation (
    defaultComponentName="ED",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));

end Partial_EventDriver;