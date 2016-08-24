# 1phase convective flux
[Mesh]
  type = GeneratedMesh
  dim = 1
  nx = 50
  xmin = 0
  xmax = 1
[]

[Adaptivity]
  active = ''
  max_h_level = 1
  [./Markers]
    [./error_frac]
      indicator = ind
      type = ErrorFractionMarker
      refine = 0.1
      coarsen = 0.1
    [../]
  [../]
  [./Indicators]
    [./ind]
      type = GradientJumpIndicator
      variable = temp
    [../]
  [../]
[]

[GlobalParams]
  PorousFlowDictator = dictator
[]

[Variables]
  [./temp]
    initial_condition = 200
  [../]
  [./pp]
  [../]
[]

[ICs]
  [./pp]
    type = FunctionIC
    variable = pp
    function = '1-x'
  [../]
[]

[BCs]
  [./pp0]
    type = PresetBC
    variable = pp
    boundary = left
    value = 1
  [../]
  [./pp1]
    type = PresetBC
    variable = pp
    boundary = right
    value = 0
  [../]
  [./spit_heat]
    type = PresetBC
    variable = temp
    boundary = left
    value = 300
  [../]
  [./suck_heat]
    type = PresetBC
    variable = temp
    boundary = right
    value = 200
  [../]
[]

[Kernels]
  [./mass_dot]
    type = PorousFlowMassTimeDerivative
    fluid_component = 0
    variable = pp
  [../]
  [./advection]
    type = PorousFlowAdvectiveFlux
    fluid_component = 0
    variable = pp
    gravity = '0 0 0'
  [../]
  [./energy_dot]
    type = PorousFlowEnergyTimeDerivative
    variable = temp
  [../]
  [./convection]
    type = PorousFlowConvectiveFlux
    variable = temp
    gravity = '0 0 0'
  [../]
[]

[UserObjects]
  [./dictator]
    type = PorousFlowDictator
    porous_flow_vars = 'temp pp'
    number_fluid_phases = 1
    number_fluid_components = 1
  [../]
[]

[Materials]
  [./temperature]
    type = PorousFlowTemperature
    temperature = temp
  [../]
  [./nnn]
    type = PorousFlowNodeNumber
    on_initial_only = true
  [../]
  [./porosity]
    type = PorousFlowPorosityConst
    porosity = 0.2
  [../]
  [./rock_heat]
    type = PorousFlowMatrixInternalEnergy
    specific_heat_capacity = 1.0
    density = 125
  [../]
  [./visc0]
    type = PorousFlowViscosityConst
    viscosity = 4.4
    phase = 0
  [../]
  [./visc_all]
    type = PorousFlowJoiner
    material_property = PorousFlow_viscosity
  [../]
  [./permeability]
    type = PorousFlowPermeabilityConst
    permeability = '1.1 0 0 0 2 0 0 0 3'
  [../]
  [./relperm]
    type = PorousFlowRelativePermeabilityCorey
    n_j = 2
    phase = 0
  [../]
  [./massfrac]
    type = PorousFlowMassFraction
  [../]
  [./relperm_all]
    type = PorousFlowJoiner
    material_property = PorousFlow_relative_permeability
  [../]
  [./PS]
    type = PorousFlow1PhaseP_VG
    porepressure = pp
    al = 1.3
    m = 0.6
  [../]
  [./fluid_density]
    type = PorousFlowDensityConstBulk
    density_P0 = 1E3
    bulk_modulus = 100.0
    phase = 0
  [../]
  [./dens_all]
    type = PorousFlowJoiner
    include_old = true
    material_property = PorousFlow_fluid_phase_density
  [../]
  [./dens_qp_all]
    type = PorousFlowJoiner
    material_property = PorousFlow_fluid_phase_density_qp
    at_qps = true
  [../]
  [./fluid_energy]
    type = PorousFlowInternalEnergyIdeal
    specific_heat_capacity = 2
    phase = 0
  [../]
  [./energy_all]
    type = PorousFlowJoiner
    include_old = true
    material_property = PorousFlow_fluid_phase_internal_energy_nodal
  [../]
  [./fluid_enthalpy]
    type = PorousFlowEnthalpy
    phase = 0
  [../]
  [./enthalpy_all]
    type = PorousFlowJoiner
    material_property = PorousFlow_fluid_phase_enthalpy_nodal
  [../]
[]

[Preconditioning]
  [./andy]
    type = SMP
    full = true
    petsc_options_iname = '-ksp_type -pc_type -snes_atol -snes_rtol -snes_max_it'
    petsc_options_value = 'gmres bjacobi 1E-15 1E-10 10000'
  [../]
[]

[Executioner]
  type = Transient
  solve_type = Newton
  dt = 0.01
  end_time = 0.6
[]

[Outputs]
  file_base = convect_1d
  exodus = true
  interval = 10
[]
