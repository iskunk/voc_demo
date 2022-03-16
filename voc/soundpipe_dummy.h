/* soundpipe_dummy.h
 *
 * Minimal definitions mimicking Paul Batchelor's Soundpipe library
 * required to compile Voc
 */

#include <stdlib.h>

#ifdef USE_DOUBLE
typedef double SPFLOAT;
#else
typedef float SPFLOAT;
#endif

typedef struct
{
	int sr;  /* sample rate */
}
sp_data;

#define SP_OK 1

#define SP_RANDMAX RAND_MAX
#define sp_rand(sp) (rand())

/* end soundpipe.h */
