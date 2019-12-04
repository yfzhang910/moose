[GlobalParams]
  order = FIRST
  family = LAGRANGE
  displacements = 'disp_x disp_y'
  out_of_plane_strain = strain_zz
[]

[Mesh]
  file = 'gold/square.e'
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]

  [./strain_zz]
  [../]
[]

[Kernels]
  [./disp_x]
    type = ADStressDivergenceTensors
    variable = disp_x
    component = 0
  [../]
  [./disp_y]
    type = ADStressDivergenceTensors
    variable = disp_y
    component = 1
  [../]

  [./solid_z]
    type = ADWeakPlaneStress
    variable = strain_zz
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = 0.0
    youngs_modulus = 1
  [../]
  [./strain]
    type = ADComputePlaneSmallStrain
  [../]
  [./stress]
    type = ADComputeLinearElasticStress
  [../]
[]

[Executioner]
  type = Transient
  solve_type = NEWTON

  petsc_options_iname = '-ksp_type -pc_type -snes_type'
  petsc_options_value = 'bcgs bjacobi test'

  end_time = 1.0
[]
