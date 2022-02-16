#include <stdlib.h>
//#include <libguile.h>
#include "io.h"

static void
inner_main (void *data, int argc, char **argv)
{
  //scm_c_primitive_load("io.scm");
  scm_eval_string(scm_from_locale_string(guile));

  scm_shell (argc, argv);
}

int
main (int argc, char **argv)
{
  scm_boot_guile (argc, argv, inner_main, 0);
  return 0; /* never reached */
}
