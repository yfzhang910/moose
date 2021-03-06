//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ReporterContext.h"

ReporterContextBase::ReporterContextBase(const libMesh::ParallelObject & other)
  : libMesh::ParallelObject(other)
{
}

void
ReporterContextBase::init(const ReporterMode & mode)
{
  if (mode != REPORTER_MODE_UNSET)
    _producer_enum.assign(mode);
}

const ReporterProducerEnum &
ReporterContextBase::getProducerModeEnum() const
{
  return _producer_enum;
}
