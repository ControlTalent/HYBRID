within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SteamTurbine_L2_ClosedFeedHeat_Test_b_SFR
  import NHES;

  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L2_ClosedFeedHeat BOP(
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp
      CS(data(
        p_steam=11000000,
        T_Steam_Ref=648.15,
        Q_Nom=100e6,
        T_Feedwater=548.15,
        p_steam_vent=15000000,
        m_flow_feed_nom=50)),
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Turbine_2
      data(
      p_steam_vent=15000000,
      T_Steam_Ref=648.15,
      Q_Nom=100e6,
      T_Feedwater=548.15,
      p_steam=11000000,
      p_in_nominal=13500000,
      V_tee=50,
      valve_TCV_mflow=100,
      valve_TCV_dp_nominal=100000,
      valve_TBV_mflow=4,
      valve_TBV_dp_nominal=2000000,
      InternalBypassValve_p_spring=6500000,
      InternalBypassValve_K(unit="1/(m.kg)") = 6000,
      InternalBypassValve_tau(unit="1/s"),
      HPT_p_exit_nominal=4000000,
      HPT_T_in_nominal=648.15,
      HPT_nominal_mflow=120,
      LPT_T_in_nominal=533.15,
      LPT_nominal_mflow=100,
      firstfeedpump_p_nominal=3500000,
      secondfeedpump_p_nominal=7000000,
      controlledfeedpump_mflow_nominal=180,
      MainFeedHeater_K_tube(unit="1/m4") = 3500,
      MainFeedHeater_K_shell(unit="1/m4"),
      BypassFeedHeater_K_tube(unit="1/m4") = 3500,
      BypassFeedHeater_K_shell(unit="1/m4")),
    port_a_nominal(
      m_flow=67,
      p=3400000,
      h=3e6),
    port_b_nominal(p=3500000, h=1e6),
    init(
      tee_p_start=800000,
      moisturesep_p_start=700000,
      FeedwaterMixVolume_p_start=100000,
      HPT_T_b_start=578.15,
      MainFeedHeater_p_start_shell=100000,
      MainFeedHeater_h_start_shell_inlet=2e6,
      MainFeedHeater_h_start_shell_outlet=1.8e6,
      MainFeedHeater_dp_init_shell=90000,
      MainFeedHeater_m_start_tube=67,
      MainFeedHeater_m_start_shell=67,
      BypassFeedHeater_h_start_tube_inlet=1.1e6,
      BypassFeedHeater_h_start_tube_outlet=1.2e6,
      BypassFeedHeater_m_start_tube=67,
      BypassFeedHeater_m_start_shell=4))
    annotation (Placement(transformation(extent={{0,-30},{60,30}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-18,-22},{-38,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-38,2},{-18,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-52,-60},{-8,-30}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-52,30},{-6,60}})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/200,
    offset=4e8,
    startTime=350,
    amplitude=2e8)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=11000000,
    T_start=373.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=25),
    Q_gen=400e6)
    annotation (Placement(transformation(extent={{-70,-8},{-50,12}})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-29,41.1},{-29,30},{-28,30},{-28,14},{-27.95,14},{-27.95,12.05}},
                                                                   color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-30,-48.9},{-30,-32},{-28,-32},{-28,-11.95},{-28.05,-11.95}},
                                                           color={0,0,0}));
  connect(stateSensor.port_a, BOP.port_b)
    annotation (Line(points={{-18,-12},{0,-12}},   color={0,127,255}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-18,12},{0,12}},   color={0,127,255}));
  connect(BOP.portElec_b, sinkElec.port)
    annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
  connect(volume.port_b, stateSensor1.port_a) annotation (Line(points={{-54,2},
          {-48,2},{-48,10},{-38,10},{-38,12}}, color={0,127,255}));
  connect(stateSensor.port_b, volume.port_a) annotation (Line(points={{-38,-12},
          {-58,-12},{-58,-10},{-80,-10},{-80,2},{-66,2}}, color={0,127,255}));
  annotation (experiment(
      StopTime=300,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end SteamTurbine_L2_ClosedFeedHeat_Test_b_SFR;