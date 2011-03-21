#ifndef FUNCTIONDIRICHLETBC_H_
#define FUNCTIONDIRICHLETBC_H_

#include "NodalBC.h"

//Forward Declarations
class FunctionDirichletBC;
class Function;

template<>
InputParameters validParams<FunctionDirichletBC>();

/**
 * Defines a boundary condition that forces the value to be a user specified
 * function at the boundary.
 */
class FunctionDirichletBC : public NodalBC
{
public:
  FunctionDirichletBC(const std::string & name, InputParameters parameters);

protected:
  /**
   * Evaluate the function at the current quadrature point and timestep.
   */
  Real f();

  /**
   * returns (u - the function)
   */
  virtual Real computeNodeResidual();

private:
  Function & _func;
};

#endif //FUNCTIONDIRICHLETBC_H_
