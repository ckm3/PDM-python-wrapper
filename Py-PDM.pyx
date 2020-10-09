#cython: language_level=3

import numpy as np
cimport numpy as np
np.import_array()
from libc.stdlib cimport free


cdef extern from "PyPDM.c":
    int pdm2(int ne, double datx[], double daty[], double sig[], double f_min, double f_max, double delf)
    double* f_array
    double* theta_array
    int nf


def pdm(int data_number, np.ndarray x , np.ndarray y, np.ndarray s, double f_min, double f_max, double delf):
    cdef double [:] x2 = x
    cdef double [:] y2 = y
    cdef double [:] s2 = s

    pdm2(data_number, &x2[0], &y2[0], &s2[0], f_min, f_max, delf)

    freq_np_array = np.asarray(<double[:nf]> f_array)
    theta_np_array = np.asarray(<double[:nf]> theta_array)

    return freq_np_array, theta_np_array

