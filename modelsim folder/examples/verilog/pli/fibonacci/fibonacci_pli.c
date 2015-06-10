/*
 * Copyright 1991-2013 Mentor Graphics Corporation
 * All Rights Reserved.
 * THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE
 * PROPERTY OF MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO
 * LICENSE TERMS.
 * Simple Verilog PLI Example - C function to compute fibonacci seq.
 */
#include "veriuser.h"
#include "acc_user.h"
#include <stdlib.h>
extern int fibonacci(int);
int fseq_sizetf()
{
    return(32);
}

int fseq_calltf()
{
    int N, result;
    N = tf_getp(1);
    result = fibonacci(N);
    tf_putp(0, result);
    return(0);
}


int fseq_checktf()
{
    int err = 0;
    if (tf_nump() != 1) {
        tf_error("$fibonacci requires exactly 1 argument.\n");
        err = 1;
    }
    if (tf_typep(1) == tf_nullparam) {
        tf_error("$fibonacci cannot have a NULL argument.\n");
        err = 1;
    }
    if (tf_sizep(1) > 8) {
        tf_error("$fibonacci input no larger than 8-bits.\n");
        err = 1;
    }
    if (err) {
        tf_message(ERR_ERROR, "", "", "");
    }
    return(0);
}

int fibonacci (int N)
{
    int index;
	int retval = 0;
    int *fseq = malloc((N + 1) * sizeof (int));
    if (N == 0) {
        fseq[0] = 0;
    }
    else if (N == 1) {
        fseq[0] = 0;
        fseq[1] = 1;
    }
    else if (N >= 2) {
        fseq[0] = 0;
        fseq[1] = 1;
        for(index = 2; index <= N; index++)
            fseq[index] = fseq[index - 2] + fseq[index - 1];
    }
    else {
        fseq[N] = -1;
    }

	retval = fseq[N];
	if (fseq) {
		free(fseq);
	}
	return retval;
}

s_tfcell veriusertfs[] =
{
    {userfunction,      /* type of PLI routine - usertask or userfunction */
     0,                 /* user_data value */
     fseq_checktf,      /* checktf() routine */
     fseq_sizetf,       /* sizetf() routine */
     fseq_calltf,       /* calltf() routine */
     0,                 /* misctf() routine */
     "$fibonacci"       /* "$tfname" system task/function name */
    },
    {0}                 /* final entry must be 0 */
};
