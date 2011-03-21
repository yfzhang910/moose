#ifndef AUXILIARYSYSTEM_H_
#define AUXILIARYSYSTEM_H_

#include <set>
#include "SubProblem.h"

// libMesh include
#include "equation_systems.h"
#include "explicit_system.h"
#include "transient_system.h"

#include "numeric_vector.h"

class Problem;
class AuxKernel;

namespace Moose {

class ImplicitSystem;

class AuxiliarySystem : public SubProblemTempl<TransientExplicitSystem>
{
public:
  AuxiliarySystem(Problem & problem, ImplicitSystem & nl, const std::string & name);

  virtual void addVariable(const std::string & var_name, const FEType & type, const std::set< subdomain_id_type > * const active_subdomains = NULL);

  void addKernel(const std::string & kernel_name, const std::string & name, InputParameters parameters);

  void addBoundaryCondition(const std::string & bc_name, const std::string & name, InputParameters parameters);

  virtual void reinitElem(const Elem * elem, THREAD_ID tid);

  virtual void compute();

  std::map<std::string, Moose::Variable *>::iterator varsBegin(THREAD_ID tid = 0) { return _vars[tid].begin(); }
  std::map<std::string, Moose::Variable *>::iterator varsEnd(THREAD_ID tid = 0) { return _vars[tid].end(); }

protected:
  ImplicitSystem & _nl;

  // holders
  std::vector<std::map<std::string, Variable *> > _nodal_vars;
  std::vector<std::vector<AuxKernel *> > _nodal_kernels;

  std::map<unsigned int, std::vector<AuxKernel *> > _nodal_bcs;

  // elemental
  std::vector<std::map<std::string, Variable *> > _elem_vars;
  std::vector<std::vector<AuxKernel *> > _elem_kernels;

  // data
  struct AuxData
  {
    Real _current_volume;

    friend class ::AuxKernel;
  };

  std::vector<AuxData> _data;

  friend class ::AuxKernel;
  friend class ComputeNodalAuxThread;
  friend class ComputeElemAuxThread;
};

}

#endif /* EXPLICITSYSTEM_H_ */
