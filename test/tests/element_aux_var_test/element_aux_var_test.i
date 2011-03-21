[Mesh]
  dim = 2
  file = square.e
[]

[Variables]
  active = 'u'

  [./u]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  active = 'one five three coupled_nine coupled_fifteen coupled coupled_nl'

  [./one]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./five]
    order = FIRST
    family = LAGRANGE
  [../]

  [./three]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./coupled_nine]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./coupled_fifteen]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./coupled]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./coupled_nl]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  active = 'diff force'

  [./diff]
    type = Diffusion
    variable = u
  [../]

  #Coupling of nonlinear to Aux
  [./force]
    type = CoupledForce
    variable = u
    v = one
  [../]
[]

[AuxKernels]
  active = 'constant coupled_nine coupled_three coupled_fifteen coupled coupled_nl'

  #Simple Aux Kernel
  [./constant]
    variable = one
    type = ConstantAux
    value = 1
  [../]

  #Intentionally out of order to test dependancies in AuxKernels
  [./coupled_nine]
    variable = coupled_nine
    type = CoupledAux
    value = 3
    operator = '*'
    coupled = three
  [../]

  [./coupled_three]
    variable = three
    type = CoupledAux
    value = 2
    operator = '+'
    coupled = one
  [../]

  [./coupled_fifteen]
    variable = coupled_fifteen
    type = CoupledAux
    value = 5
    operator = '*'
    coupled = three
  [../]

  #Shows coupling of Element to Nodal
  [./coupled]
    variable = coupled
    type = CoupledAux
    value = 2
    coupled = five
  [../]

  #Shows coupling of Element to non-linear
  [./coupled_nl]
    variable = coupled_nl
    type = CoupledAux
    value = 2
    coupled = u
  [../]
[]

[BCs]
  active = 'left right'

  [./left]
    type = DirichletBC
    variable = u
    boundary = 1
    value = 0
  [../]

  [./right]
    type = DirichletBC
    variable = u
    boundary = 2
    value = 1
  [../]
[]

[AuxBCs]
  active = 'five'
  
  [./five]
    type = ConstantAux
    variable = five
    boundary = '1 2'
    value = 5
  [../]
[]

[Materials]
  active = empty

  [./empty]
    type = EmptyMaterial
    block = 1
  [../]
[]

[Executioner]
  type = Steady
  perf_log = true
  petsc_options = '-snes_mf_operator'
[]

[Output]
  file_base = out
  output_initial = true
  interval = 1
  exodus = true
[]
   
    
