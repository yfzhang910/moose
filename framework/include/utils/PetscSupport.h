#ifndef PETSCSUPPORT_H_
#define PETSCSUPPORT_H_

#ifdef LIBMESH_HAVE_PETSC

#include "libmesh.h"

//libMesh includes
#include "petsc_vector.h"
#include "getpot.h"
#include "transient_system.h"
#include "petsc_nonlinear_solver.h"

namespace Moose 
{
  namespace PetscSupport
  {
//    void petscParseOptions(GetPot & input_file);
  
//    PetscErrorCode petscConverged(KSP ksp,PetscInt n,PetscReal rnorm,KSPConvergedReason *reason,void *dummy);
//    PetscErrorCode petscNonlinearConverged(SNES snes,PetscInt it,PetscReal xnorm,PetscReal pnorm,PetscReal fnorm,SNESConvergedReason *reason,void *dummy);
    
//    void petscSetDefaults(MooseSystem &moose_system, Executioner *executioner);
    
//    PetscErrorCode petscPhysicsBasedLineSearch(SNES snes,void *lsctx,Vec x,Vec f,Vec g,Vec y,Vec w, PetscReal fnorm,PetscReal *ynorm,PetscReal *gnorm,PetscTruth *flag);
//    PetscErrorCode dampedCheck(SNES snes, Vec x, Vec y, Vec w, void *lsctx, PetscTruth * changed_y, PetscTruth * changed_w);
  }
}

namespace MoosePetscSupport = Moose::PetscSupport;

#endif //LIBMESH_HAVE_PETSC

#endif //PETSCSUPPORT_H_
