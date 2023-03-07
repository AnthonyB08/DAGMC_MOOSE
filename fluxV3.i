[Mesh]
#inactive = 'Outer_sphere Pu2392 combine'
  [Inner_sphere]
    type = FileMeshGenerator
    file = Inner.e
  []
  [Pu239]
    type = SubdomainIDGenerator
    input = Inner_sphere
    subdomain_id = '1'
  []
  [Outer_sphere]
    type = FileMeshGenerator
    file = Outer.e
  []
  [Be]
    type = SubdomainIDGenerator
    input = Outer_sphere
    subdomain_id = '2'
  []
  [combine]
    type = CombinerGenerator
    inputs = 'Pu239 Be'
  []


   second_order = true #Refine the mesh 
 []

[Problem]
  type = OpenMCCellAverageProblem
  solid_blocks = '1 2'
  initial_properties = xml
  verbose = true

  solid_cell_level = 0
  normalize_by_global_tally = true
  tally_type = mesh
  tally_name = 'flux '
  power = 100
  check_zero_tallies = false
  #mesh_template = 'Inner.e'
  tally_estimator= collision


  #check_equal_mapped_tally_volumes=true
  #check_identical_tally_cell_fills=true
  #assume_separate_tallies= true
  relaxation =robbins_monro
[]
[Executioner]
   type = Steady
   #num_steps = 1




[]

[Postprocessors]

    [k]
    type = KEigenvalue
    []
[]

[VectorPostprocessors]

   [flux_vec]
    type = LineValueSampler
    start_point = '0 0 0'
    end_point = '0 0 3.43'
    num_points = 256
    sort_by = id
    variable = flux
    execute_on = 'timestep_end final'
  []


[]

[Outputs]
  csv = true
  exodus =true 
[]
