#ifndef USERFORCINGFUNCTION_H_
#define USERFORCINGFUNCTION_H_

#include "Kernel.h"

//Forward Declarations
class UserForcingFunction;
class Function;

template<>
InputParameters validParams<UserForcingFunction>();

/**
 * Define the Kernel for a user defined forcing function that looks like:
 *
 * test function * forcing function
 */
class UserForcingFunction : public Kernel
{
public:

  UserForcingFunction(const std::string & name, InputParameters parameters);

protected:
  /**
   * Evaluate f at the current quadrature point.
   */
  Real f();

  /**
   * Computes test function * forcing function.
   */
  virtual Real computeQpResidual();

  Function & _func;
};

#endif //USERFORCINGFUNCTION_H_
