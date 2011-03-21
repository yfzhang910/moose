#ifndef PARALLELUNIQUEID_H_
#define PARALLELUNIQUEID_H_

#include "libmesh_common.h"
#include "threads.h"

#ifdef LIBMESH_HAVE_TBB_API
#include "tbb/concurrent_queue.h"
#include "tbb/tbb_thread.h"
#endif

typedef
  unsigned int THREAD_ID;

class ParallelUniqueId
{
public:

  ParallelUniqueId()
  {
#ifdef LIBMESH_HAVE_TBB_API
    ids.pop(id);
#else
    id = 0;
#endif
  }

  ~ParallelUniqueId()
  {
#ifdef LIBMESH_HAVE_TBB_API
    ids.push(id);
#endif
  }

  /**
   * Must be called by main thread _before_ any threaded computation!
   * Do NOT call _in_ a worker thread!
   */
  static void initialize()
  {
#ifdef LIBMESH_HAVE_TBB_API
    if(!initialized)
    {
      initialized = true;
      for(unsigned int i=0; i<libMesh::n_threads(); ++i)
        ids.push(i);
    }
#endif
  }
  
  static void reinitialize()
  {
#ifdef LIBMESH_HAVE_TBB_API
    initialized = false;
    ids.clear();
    initialize();
#endif
  }
  
  THREAD_ID id;

protected:
#ifdef LIBMESH_HAVE_TBB_API
  static tbb::concurrent_bounded_queue<unsigned int> ids;
  static bool initialized;
#endif
};

#endif // PARALLELUNIQUEID_H
