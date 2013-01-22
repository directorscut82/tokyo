cimport numpy as np

import_array()

##########################################################################
# BLAS LEVEL 1
##########################################################################

# Each subroutine comes in two variants:
# [sd]name and [sd]name_
# The variant with the trailing underscore skips type and dimension checks,
# calls the low-level C-routine directly and works with C types.

# vector swap: x <-> y
cdef void sswap_(int M, float *x, int dx, float *y, int dy):
    lib_sswap(M, x, dx, y, dy)

cdef void sswap(np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT:
        raise ValueError("y is not of type float")

    lib_sswap(x.shape[0], <float*>x.data, 1, <float*>y.data, 1)


cdef void dswap_(int M, double *x, int dx, double *y, int dy):
    lib_dswap(M, x, dx, y, dy)

cdef void dswap(np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE:
        raise ValueError("y is not of type double")
    lib_dswap(x.shape[0], <double*>x.data, 1, <double*>y.data, 1)

# scalar vector multiply: x *= alpha
cdef void sscal_(int N, float alpha, float *x, int dx):
    lib_sscal(N, alpha, x, dx)

cdef void sscal(float alpha, np.ndarray x):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    lib_sscal(x.shape[0], alpha, <float*>x.data, 1)


cdef void dscal_(int N, double alpha, double *x, int dx):
    lib_dscal(N, alpha, x, dx)

cdef void dscal(double alpha, np.ndarray x):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    lib_dscal(x.shape[0], alpha, <double*>x.data, 1)


# vector copy: y <- x
cdef void scopy_(int N, float *x, int dx, float *y, int dy):
    lib_scopy(N, x, dx, y, dy)

cdef void scopy2(np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT:
        raise ValueError("y is not of type float")
    lib_scopy(x.shape[0], <float*>x.data, 1, <float*>y.data, 1)

cdef np.ndarray scopy(np.ndarray x):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    y = svnewempty(x.shape[0])
    lib_scopy(x.shape[0], <float*>x.data, 1, <float*>y.data, 1)
    return y


cdef void dcopy_(int N, double *x, int dx, double *y, int dy):
    lib_dcopy(N, x, dx, y, dy)

cdef void dcopy2(np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE:
        raise ValueError("y is not of type double")
    lib_dcopy(x.shape[0], <double*>x.data, 1, <double*>y.data, 1)

cdef np.ndarray dcopy(np.ndarray x):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    y = dvnewempty(x.shape[0])
    lib_dcopy(x.shape[0], <double*>x.data, 1, <double*>y.data, 1)
    return y

def pydcopy(x):
    return dcopy(x)


# vector addition: y += alpha*x
cdef void saxpy_(int N, float alpha, float *x, int dx, float *y, int dy):
    lib_saxpy(N, alpha, x, dx, y, dy)

cdef void saxpy(float alpha, np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT:
        raise ValueError("y is not of type float")
    lib_saxpy(x.shape[0], alpha, <float*>x.data, 1, <float*>y.data, 1)


cdef void daxpy_(int N, double alpha, double *x, int dx, double *y, int dy):
    lib_daxpy(N, alpha, x, dx, y, dy)

cdef void daxpy(double alpha, np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE:
        raise ValueError("y is not of type double")
    lib_daxpy(x.shape[0], alpha, <double*>x.data, 1, <double*>y.data, 1)


# vector dot product: x'y
cdef float sdot_(int N, float *x, int dx, float *y, int dy):
    return lib_sdot(N, x, dx, y, dy)

cdef float sdot(np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT:
        raise ValueError("y is not of type float")
    return lib_sdot(x.shape[0], <float*>x.data, 1, <float*>y.data, 1)


cdef double ddot_(int N, double *x, int dx, double *y, int dy):
    return lib_ddot(N, x, dx, y, dy)

cdef double ddot(np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE:
        raise ValueError("y is not of type double")
    return lib_ddot(x.shape[0], <double*>x.data, 1, <double*>y.data, 1)


# Double precision dot product of single precision vectors: x'y
cdef double dsdot_(int N, float *x, int dx, float *y, int dy):
    return lib_dsdot(N, x, dx, y, dy)

cdef double dsdot(np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT:
        raise ValueError("y is not of type float")
    return lib_dsdot(x.shape[0], <float*>x.data, 1, <float*>y.data, 1)

# Single precision dot product (computed in double precision) of
# single precision vectors: alpha + x'y
cdef float sdsdot_(int N, float alpha, float *x, int dx, float *y, int dy):
    return lib_sdsdot(N, alpha, x, dx, y, dy)

cdef float sdsdot(float alpha, np.ndarray x, np.ndarray y):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT:
        raise ValueError("y is not of type float")
    return lib_sdsdot(x.shape[0], alpha, <float*>x.data, 1, <float*>y.data, 1)


# Euclidean norm:  ||x||_2
cdef float snrm2_(int N, float *x, int dx):
    return lib_snrm2(N, x, dx)

cdef float snrm2(np.ndarray x):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    return lib_snrm2(x.shape[0], <float*>x.data, 1)


cdef double dnrm2_(int N, double *x, int dx):
    return lib_dnrm2(N, x, dx)

cdef double dnrm2(np.ndarray x):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    return lib_dnrm2(x.shape[0], <double*>x.data, 1)

# sum of absolute values: ||x||_1
cdef float sasum_(int N, float *x, int dx):
    return lib_sasum(N, x, dx)

cdef float sasum(np.ndarray x):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    return lib_sasum(x.shape[0], <float*>x.data, 1)


cdef double dasum_(int N, double *x, int dx):
    return lib_dasum(N, x, dx)

cdef double dasum(np.ndarray x):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    return lib_dasum(x.shape[0], <double*>x.data, 1)

# index of maximum absolute value element
cdef int isamax_(int N, float *x, int dx):
    return lib_isamax(N, x, dx)

cdef int isamax(np.ndarray x):
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    return lib_isamax(x.shape[0], <float*>x.data, 1)


cdef int idamax_(int N, double *x, int dx):
    return lib_idamax(N, x, dx)

cdef int idamax(np.ndarray x):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    return lib_idamax(x.shape[0], <double*>x.data, 1)


# Generate a Givens plane rotation: [a,b,c,s] <- rotg(a,b).
cdef np.ndarray srotg_(float a, float b):
    cdef np.ndarray x = svnewempty(4)
    cdef float aa = a, bb = b, c = 0.0, s = 0.0
    lib_srotg(&aa, &bb, &c, &s)
    x[0] = aa ; x[1] = bb ; x[2] = c ; x[3] = s
    return x

cdef np.ndarray srotg(float a, float b):
    return srotg_(a, b)


cdef np.ndarray drotg_(double a, double b):
    cdef np.ndarray x = dvnewempty(4)
    cdef double aa = a, bb = b, c = 0.0, s = 0.0
    lib_drotg(&aa, &bb, &c, &s)
    x[0] = aa ; x[1] = bb ; x[2] = c ; x[3] = s
    return x

cdef np.ndarray drotg(double a, double b):
    return drotg_(a, b)


# Generate a modified Givens plane rotation.
cdef void srotmg_(float *d1, float *d2, float *x, float y, float *param):
    lib_srotmg(d1, d2, x, y, param)

cdef tuple srotmg(float d1, float d2, float x, float y, np.ndarray param):
    if param.ndim != 1: raise ValueError("param is not a vector")
    if param.shape[0] < 5:
        raise ValueError("param must have length at least 5")
    if param.descr.type_num != NPY_FLOAT:
        raise ValueError("param is not of type float")
    cdef float d1_ = d1, d2_ = d2, x_ = x
    srotmg_(&d1_, &d2_, &x_, y, <float *>param.data)
    return (d1_, d2_, x_, param)

cdef void drotmg_(double *d1, double *d2, double *x, double y, double *param):
    lib_drotmg(d1, d2, x, y, param)

cdef tuple drotmg(double d1, double d2, double x, double y, np.ndarray param):
    if param.ndim != 1: raise ValueError("param is not a vector")
    if param.shape[0] < 5:
        raise ValueError("param must have length at least 5")
    if param.descr.type_num != NPY_DOUBLE:
        raise ValueError("param is not of type double")
    cdef double d1_ = d1, d2_ = d2, x_ = x
    drotmg_(&d1_, &d2_, &x_, y, <double *>param.data)
    return (d1, d2, x, param)


# Apply a Givens plane rotation.
cdef void srot_(int N, float *x, int dx, float *y, int dy, float c, float s):
    lib_srot(N, x, dx, y, dy, c, s)

cdef void srot(np.ndarray x, np.ndarray y, float c, float s, int dx=1, int dy=1):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT:
        raise ValueError("y is not of type float")
    srot_(x.shape[0], <float *>x.data, dx, <float *>y.data, dy, c, s)
    return


cdef void drot_(int N, double *x, int dx, double *y, int dy, double c, double s):
    lib_drot(N, x, dx, y, dy, c, s)

cdef void drot(np.ndarray x, np.ndarray y, double c, double s):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE:
        raise ValueError("y is not of type double")
    drot_(x.shape[0], <double *>x.data, 1, <double *>y.data, 1, c, s)
    return


# Apply a modified Givens plane rotation.
cdef void srotm_(int N, float *x, int dx, float *y, int dy, float *param):
    lib_srotm(N, x, dx, y, dy, param)

cdef void srotm(np.ndarray x, np.ndarray y, np.ndarray param):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if param.ndim != 1: raise ValueError("param is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if param.shape[0] < 5:
        raise ValueError("param must have length at least 5")
    if param.descr.type_num != NPY_FLOAT:
        raise ValueError("param is not of type float")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT:
        raise ValueError("y is not of type float")
    srotm_(x.shape[0], <float *>x.data, 1,
                       <float *>y.data, 1, <float *>param.data)
    return

cdef void drotm_(int N, double *x, int dx, double *y, int dy, double *param):
    lib_drotm(N, x, dx, y, dy, param)

cdef void drotm(np.ndarray x, np.ndarray y, np.ndarray param):
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    if param.shape[0] < 5:
        raise ValueError("param must have length at least 5")
    if param.descr.type_num != NPY_DOUBLE:
        raise ValueError("param is not of type double")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE:
        raise ValueError("y is not of type double")
    drotm_(x.shape[0], <double *>x.data, 1,
                       <double *>y.data, 1, <double *>param.data)
    return


##########################################################################
# BLAS LEVEL 2
##########################################################################

#
# matrix times vector: A = alpha * A   x + beta * y
#                  or  A = alpha * A.T x + beta * y
#
# single precison

cdef void sgemv_(CBLAS_ORDER Order, CBLAS_TRANSPOSE TransA, int M, int N,
                    float alpha, float *A, int lda, float *x, int dx,
                    float beta, float *y, int dy):
    lib_sgemv(Order, TransA, M, N, alpha, A, lda, x, dx, beta, y, dy)


cdef void sgemv6(CBLAS_TRANSPOSE TransA, float alpha, np.ndarray A,
                      np.ndarray x, float beta, np.ndarray y):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if A.shape[0] != y.shape[0]: raise ValueError("A rows != y rows")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_FLOAT: raise ValueError("A is not of type float")
    if x.descr.type_num != NPY_FLOAT: raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT: raise ValueError("y is not of type float")

    lib_sgemv(CblasRowMajor, TransA, A.shape[0], A.shape[1], alpha, <float*>A.data,
               A.shape[1], <float*>x.data, 1, beta, <float*>y.data, 1)


cdef void sgemv5(float alpha, np.ndarray A, np.ndarray x, float beta, np.ndarray y):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if A.shape[0] != y.shape[0]: raise ValueError("A rows != y rows")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_FLOAT: raise ValueError("A is not of type float")
    if x.descr.type_num != NPY_FLOAT: raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT: raise ValueError("y is not of type float")

    lib_sgemv(CblasRowMajor, CblasNoTrans, A.shape[0], A.shape[1], alpha,
            <float*>A.data, A.shape[1], <float*>x.data, 1, beta, <float*>y.data, 1)


cdef void sgemv3(np.ndarray A, np.ndarray x, np.ndarray y):
    sgemv5(1.0, A, x, 0.0, y)


# This performs y = A*x and is different from strmv, which performs x <- A*x.
cdef np.ndarray sgemv(np.ndarray A, np.ndarray x):
    cdef np.ndarray y = svnewempty(A.shape[0])
    sgemv5(1.0, A, x, 0.0, y)
    return y

# double precision

cdef void dgemv_(CBLAS_ORDER Order, CBLAS_TRANSPOSE TransA, int M, int N,
                    double alpha, double *A, int lda, double *x, int dx,
                    double beta, double *y, int dy):
    lib_dgemv(Order, TransA, M, N, alpha, A, lda, x, dx, beta, y, dy)


cdef void dgemv6(CBLAS_TRANSPOSE TransA, double alpha, np.ndarray A,
                      np.ndarray x, double beta, np.ndarray y):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if A.shape[0] != y.shape[0]: raise ValueError("A rows != y rows")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_DOUBLE: raise ValueError("A is not of type double")
    if x.descr.type_num != NPY_DOUBLE: raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE: raise ValueError("y is not of type double")

    lib_dgemv(CblasRowMajor, TransA, A.shape[0], A.shape[1], alpha, <double*>A.data,
               A.shape[1], <double*>x.data, 1, beta, <double*>y.data, 1)


cdef void dgemv5(double alpha, np.ndarray A, np.ndarray x, double beta, np.ndarray y):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if A.shape[0] != y.shape[0]: raise ValueError("A rows != y rows")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_DOUBLE: raise ValueError("A is not of type double")
    if x.descr.type_num != NPY_DOUBLE: raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE: raise ValueError("y is not of type double")

    lib_dgemv(CblasRowMajor, CblasNoTrans, A.shape[0], A.shape[1], alpha,
            <double*>A.data, A.shape[1], <double*>x.data, 1, beta, <double*>y.data, 1)


cdef void dgemv3(np.ndarray A, np.ndarray x, np.ndarray y):
    dgemv5(1.0, A, x, 0.0, y)


# This performs y = A*x and is different from dtrmv, which performs x <- A*x.
cdef np.ndarray dgemv(np.ndarray A, np.ndarray x):
    cdef np.ndarray y = dvnewempty(A.shape[0])
    dgemv5(1.0, A, x, 0.0, y)
    return y


#
# Symmetric matrix-vector product and update. A symmetric, not packed.
#
# y <- alpha * A * x + beta * y.
#

# Single precision

cdef void ssymv_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, int N, float alpha,
                 float *A, int lda, float *x, int dx, float beta,
                 float *y, int dy):

    lib_ssymv(Order, Uplo, N, alpha, A, lda, x, dx, beta, y, dy)


cdef void ssymv6(CBLAS_ORDER Order, CBLAS_UPLO Uplo, float alpha, np.ndarray A,
                 np.ndarray x, float beta, np.ndarray y):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if A.shape[0] != y.shape[0]: raise ValueError("A rows != y rows")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_FLOAT: raise ValueError("A is not of type float")
    if x.descr.type_num != NPY_FLOAT: raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT: raise ValueError("y is not of type float")

    lib_ssymv(Order, Uplo, A.shape[0], alpha, <float*>A.data, A.shape[1],
              <float*>x.data, 1, beta, <float*>y.data, 1)


cdef void ssymv5(float alpha, np.ndarray A, np.ndarray x, float beta, np.ndarray y):

    ssymv6(CblasRowMajor, CblasLower, alpha, A, x, beta, y)


cdef void ssymv3(np.ndarray A, np.ndarray x, np.ndarray y):

    ssymv5(1.0, A, x, 0.0, y)


cdef np.ndarray ssymv(np.ndarray A, np.ndarray x):

    cdef np.ndarray y = svnewempty(A.shape[0])
    ssymv5(1.0, A, x, 0.0, y)
    return y


# Double precision

cdef void dsymv_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, int N, double alpha,
                 double *A, int lda, double *x, int dx, double beta,
                 double *y, int dy):

    lib_dsymv(Order, Uplo, N, alpha, A, lda, x, dx, beta, y, dy)


cdef void dsymv6(CBLAS_ORDER Order, CBLAS_UPLO Uplo, double alpha, np.ndarray A,
                 np.ndarray x, double beta, np.ndarray y):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if A.shape[0] != y.shape[0]: raise ValueError("A rows != y rows")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE:
        raise ValueError("y is not of type double")

    lib_dsymv(Order, Uplo, A.shape[0], alpha, <double*>A.data, A.shape[1],
              <double*>x.data, 1, beta, <double*>y.data, 1)


cdef void dsymv5(double alpha, np.ndarray A, np.ndarray x, double beta, np.ndarray y):

    dsymv6(CblasRowMajor, CblasLower, alpha, A, x, beta, y)


cdef void dsymv3(np.ndarray A, np.ndarray x, np.ndarray y):

    dsymv5(1.0, A, x, 0.0, y)


cdef np.ndarray dsymv(np.ndarray A, np.ndarray x):

    cdef np.ndarray y = dvnewempty(A.shape[0])
    dsymv5(1.0, A, x, 0.0, y)
    return y

#
# matrix-vector multiply with a triangular matrix.
#
# x <- A*x.
#

# Single precision

cdef void strmv_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE TransA,
                 CBLAS_DIAG Diag, int N, float *A, int lda, float *X, int dx):
    lib_strmv(Order, Uplo, TransA, Diag, N, A, lda, X, dx)


cdef void strmv6(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE TransA,
                 CBLAS_DIAG Diag, np.ndarray A, np.ndarray x):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_FLOAT: raise ValueError("A is not of type float")
    if x.descr.type_num != NPY_FLOAT: raise ValueError("x is not of type float")

    lib_strmv(Order, Uplo, TransA, Diag, A.shape[0], <float*>A.data, A.shape[1],
              <float*>x.data, 1)


cdef void strmv3(CBLAS_TRANSPOSE TransA, np.ndarray A, np.ndarray x):

    strmv6(CblasRowMajor, CblasLower, TransA, CblasNonUnit, A, x)


cdef void strmv(np.ndarray A, np.ndarray x):

    strmv6(CblasRowMajor, CblasLower, CblasNoTrans, CblasNonUnit, A, x)


# Double precision

cdef void dtrmv_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE TransA,
                 CBLAS_DIAG Diag, int N, double *A, int lda, double *X, int dx):
    lib_dtrmv(Order, Uplo, TransA, Diag, N, A, lda, X, dx)


cdef void dtrmv6(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE TransA,
                 CBLAS_DIAG Diag, np.ndarray A, np.ndarray x):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")

    lib_dtrmv(Order, Uplo, TransA, Diag,
              A.shape[0], <double*>A.data, A.shape[1], <double*>x.data, 1)


cdef void dtrmv3(CBLAS_TRANSPOSE TransA, np.ndarray A, np.ndarray x):

    dtrmv6(CblasRowMajor, CblasLower, TransA, CblasNonUnit, A, x)


cdef void dtrmv(np.ndarray A, np.ndarray x):

    dtrmv6(CblasRowMajor, CblasLower, CblasNoTrans, CblasNonUnit, A, x)


#
# triangular system solve: x <- inv(A) * x  or  x <- inv(A)^T * x
#

# single precision

cdef void strsv_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE TransA,
                 CBLAS_DIAG Diag, int N, float *A, int lda, float *x, int dx):
    lib_strsv(Order, Uplo, TransA, Diag, N, A, lda, x, dx)


cdef void strsv6(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE TransA,
                 CBLAS_DIAG Diag, np.ndarray A, np.ndarray x):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_FLOAT:
        raise ValueError("A is not of type float")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")

    lib_strsv(Order, Uplo, TransA, Diag,
              A.shape[0], <float*>A.data, A.shape[1], <float*>x.data, 1)


cdef void strsv3(CBLAS_TRANSPOSE TransA, np.ndarray A, np.ndarray x):

    strsv6(CblasRowMajor, CblasLower, TransA, CblasNonUnit, A, x)


cdef void strsv2(np.ndarray A, np.ndarray x):

    strsv3(CblasNoTrans, A, x)


cdef np.ndarray strsv(np.ndarray A, np.ndarray x):

    y = scopy(x)
    strsv6(CblasRowMajor, CblasLower, CblasNoTrans, CblasNonUnit, A, y)
    return y


cdef np.ndarray strsvu(np.ndarray A, np.ndarray x):

    y = scopy(x)
    strsv6(CblasRowMajor, CblasUpper, CblasNoTrans, CblasNonUnit, A, y)
    return y

# double precision

cdef void dtrsv_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE TransA,
                 CBLAS_DIAG Diag, int N, double *A, int lda, double *x, int dx):
    lib_dtrsv(Order, Uplo, TransA, Diag, N, A, lda, x, dx)


cdef void dtrsv6(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE TransA,
                 CBLAS_DIAG Diag, np.ndarray A, np.ndarray x):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if A.shape[1] != x.shape[0]: raise ValueError("A columns != x rows")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")

    lib_dtrsv(Order, Uplo, TransA, Diag,
              A.shape[0], <double*>A.data, A.shape[1], <double*>x.data, 1)


cdef void dtrsv3(CBLAS_TRANSPOSE TransA, np.ndarray A, np.ndarray x):

    dtrsv6(CblasRowMajor, CblasLower, TransA, CblasNonUnit, A, x)


cdef void dtrsv2(np.ndarray A, np.ndarray x):

    dtrsv3(CblasNoTrans, A, x)


cdef np.ndarray dtrsv(np.ndarray A, np.ndarray x):

    y = dcopy(x)
    dtrsv6(CblasRowMajor, CblasLower, CblasNoTrans, CblasNonUnit, A, y)
    return y


cdef np.ndarray dtrsvu(np.ndarray A, np.ndarray x):

    y = dcopy(x)
    dtrsv6(CblasRowMajor, CblasUpper, CblasNoTrans, CblasNonUnit, A, y)
    return y


def lowertri_solve(A,x):
    return dtrsv(A,x)


# This is necessary because lowertri_solve(A.T,x) doesn't work.
def uppertri_solve(A,x):
    return dtrsvu(A,x)

#
# vector outer-product: A = alpha * outer_product(x, y.T)
#

# Note: when calling this make sure you're working with a buffer otherwise
# a whole lot of Python stuff will be going before the call to this function
# is made in order to get the size of the arrays, there the data is located...

# single precision

cdef void sger_(CBLAS_ORDER Order, int M, int N, float alpha, float *x, int dx,
                float *y, int dy, float *A, int lda):

    lib_sger(Order, M, N, alpha, x, dx, y, dy, A, lda)


cdef void sger4(float alpha, np.ndarray x, np.ndarray y, np.ndarray A):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != A.shape[0]: raise ValueError("x rows != A rows")
    if y.shape[0] != A.shape[1]: raise ValueError("y rows != A columns")
    if A.descr.type_num != NPY_FLOAT: raise ValueError("A is not of type float")
    if x.descr.type_num != NPY_FLOAT: raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT: raise ValueError("y is not of type float")

    lib_sger(CblasRowMajor, x.shape[0], y.shape[0], alpha,
             <float*>x.data, 1, <float*>y.data, 1, <float*>A.data, A.shape[1])


cdef void sger3(np.ndarray x, np.ndarray y, np.ndarray A):
    sger4(1.0, x, y, A)


cdef np.ndarray sger(np.ndarray x, np.ndarray y):
    cdef np.ndarray A = smnewzero(x.shape[0], y.shape[0])
    sger4(1.0, x, y, A)
    return A


# double precision

cdef void dger_(CBLAS_ORDER Order, int M, int N, double alpha,
                double *x, int dx, double *y, int dy, double *A, int lda):

    lib_dger(Order, M, N, alpha, x, dx, y, dy, A, lda)


cdef void dger4(double alpha, np.ndarray x, np.ndarray y, np.ndarray A):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if y.ndim != 1: raise ValueError("y is not a vector")
    if x.shape[0] != A.shape[0]: raise ValueError("x rows != A rows")
    if y.shape[0] != A.shape[1]: raise ValueError("y rows != A columns")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE:
        raise ValueError("y is not of type double")

    lib_dger(CblasRowMajor, x.shape[0], y.shape[0], alpha,
             <double*>x.data, 1, <double*>y.data, 1,
             <double*>A.data, A.shape[1])


cdef void dger3(np.ndarray x, np.ndarray y, np.ndarray A):
    dger4(1.0, x, y, A)


cdef np.ndarray dger(np.ndarray x, np.ndarray y):
    cdef np.ndarray A = dmnewzero(x.shape[0], y.shape[0])
    dger4(1.0, x, y, A)
    return A

#
# Symmetric rank 1 update: A <- alpha * x * x.T + A
#

# single precision

cdef void ssyr_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, int N, float alpha,
                float *x, int dx, float *A, int lda):

    lib_ssyr(Order, Uplo, N, alpha, x, dx, A, lda)


cdef void ssyr_3(float alpha, np.ndarray x, np.ndarray A):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.shape[0] != A.shape[0]: raise ValueError("x rows != A rows")
    if A.descr.type_num != NPY_FLOAT:
        raise ValueError("A is not of type float")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")

    lib_ssyr(CblasRowMajor, CblasLower, x.shape[0], alpha, <float*>x.data, 1,
             <float*>A.data, A.shape[1])


cdef void ssyr_2(np.ndarray x, np.ndarray A):

    ssyr_3(1.0, x, A)


cdef np.ndarray ssyr(np.ndarray x):

    cdef np.ndarray A = smnewzero(x.shape[0], x.shape[0])
    ssyr_3(1.0, x, A)
    return A


# double precision

cdef void dsyr_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, int N, double alpha,
                double *x, int dx, double *A, int lda):

    lib_dsyr(Order, Uplo, N, alpha, x, dx, A, lda)


cdef void dsyr_3(double alpha, np.ndarray x, np.ndarray A):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.shape[0] != A.shape[0]: raise ValueError("x rows != A rows")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")

    lib_dsyr(CblasRowMajor, CblasLower, x.shape[0], alpha, <double*>x.data, 1,
             <double*>A.data, A.shape[1])


cdef void dsyr_2(np.ndarray x, np.ndarray A):

    dsyr_3(1.0, x, A)


cdef np.ndarray dsyr(np.ndarray x):

    cdef np.ndarray A = dmnewzero(x.shape[0], x.shape[0])
    dsyr_3(1.0, x, A)
    return A


#
# Symmetric rank 2 update: A <- alpha * x * y.T + alpha * y * x.T + A
#

# single precision

cdef void ssyr2_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, int N, float alpha,
                 float *x, int dx, float *y, int dy, float *A, int lda):

    lib_ssyr2(Order, Uplo, N, alpha, x, dx, y, dy, A, lda)


cdef void ssyr2_4(float alpha, np.ndarray x, np.ndarray y, np.ndarray A):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.shape[0] != A.shape[0]: raise ValueError("x rows != A rows")
    if y.shape[0] != A.shape[0]: raise ValueError("y rows != A rows")
    if A.descr.type_num != NPY_FLOAT:
        raise ValueError("A is not of type float")
    if x.descr.type_num != NPY_FLOAT:
        raise ValueError("x is not of type float")
    if y.descr.type_num != NPY_FLOAT:
        raise ValueError("y is not of type float")

    lib_ssyr2(CblasRowMajor, CblasLower, x.shape[0], alpha,
              <float*>x.data, 1, <float*>y.data, 1,
              <float*>A.data, A.shape[1]);


cdef void ssyr2_3(np.ndarray x, np.ndarray y, np.ndarray A):

    ssyr2_4(1.0, x, y, A)


cdef np.ndarray ssyr2(np.ndarray x, np.ndarray y):

    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    cdef np.ndarray A = smnewzero(x.shape[0], x.shape[0])
    ssyr2_3(x, y, A)
    return A


# double precision

cdef void dsyr2_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, int N, double alpha,
                 double *x, int dx, double *y, int dy, double *A, int lda):

    lib_dsyr2(Order, Uplo, N, alpha, x, dx, y, dy, A, lda)


cdef void dsyr2_4(double alpha, np.ndarray x, np.ndarray y, np.ndarray A):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if x.ndim != 1: raise ValueError("x is not a vector")
    if x.shape[0] != A.shape[0]: raise ValueError("x rows != A rows")
    if y.shape[0] != A.shape[0]: raise ValueError("y rows != A rows")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if x.descr.type_num != NPY_DOUBLE:
        raise ValueError("x is not of type double")
    if y.descr.type_num != NPY_DOUBLE:
        raise ValueError("y is not of type double")

    lib_dsyr2(CblasRowMajor, CblasLower, x.shape[0], alpha,
              <double*>x.data, 1, <double*>y.data, 1,
              <double*>A.data, A.shape[1]);


cdef void dsyr2_3(np.ndarray x, np.ndarray y, np.ndarray A):

    dsyr2_4(1.0, x, y, A)


cdef np.ndarray dsyr2(np.ndarray x, np.ndarray y):

    if x.shape[0] != y.shape[0]: raise ValueError("x rows != y rows")
    cdef np.ndarray A = dmnewzero(x.shape[0], x.shape[0])
    dsyr2_3(x, y, A)
    return A


##########################################################################
#
# BLAS LEVEL 3
#
##########################################################################


# matrix times matrix: C = alpha * A   B   + beta * C
#                  or  C = alpha * A.T B   + beta * C
#                  or  C = alpha * A   B.T + beta * C
#                  or  C = alpha * A.T B.T + beta * C
#
# single precision

cdef void sgemm_(CBLAS_ORDER Order, CBLAS_TRANSPOSE TransA,
                 CBLAS_TRANSPOSE TransB, int M, int N, int K, float alpha,
                 float *A, int lda, float *B, int ldb, float beta,
                 float *C, int ldc):

    lib_sgemm(Order, TransA, TransB, M, N, K, alpha,
              A, lda, B, ldb, beta, C, ldc)


cdef void sgemm7(CBLAS_TRANSPOSE TransA, CBLAS_TRANSPOSE TransB,
                 float alpha, np.ndarray A, np.ndarray B, float beta,
                 np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if TransA == CblasNoTrans:
        if A.shape[0] != C.shape[0]: raise ValueError("A rows != C cols")
    else:
        if A.shape[1] != C.shape[0]: raise ValueError("A cols != C cols")
    if TransB == CblasNoTrans:
        if B.shape[1] != C.shape[1]: raise ValueError("B cols != C rows")
    else:
        if B.shape[0] != C.shape[1]: raise ValueError("B cols != C rows")
    if TransA == CblasNoTrans:
        if TransB == CblasNoTrans:
            if A.shape[1] != B.shape[0]: raise ValueError("A cols != B rows")
        else:
            if A.shape[1] != B.shape[1]: raise ValueError("A cols != B cols")
    else:
        if TransB == CblasNoTrans:
            if A.shape[0] != B.shape[0]: raise ValueError("A rows != B rows")
        else:
            if A.shape[0] != B.shape[1]: raise ValueError("A rows != B cols")
    if A.descr.type_num != NPY_FLOAT: raise ValueError("A is not of type float")
    if B.descr.type_num != NPY_FLOAT: raise ValueError("B is not of type float")
    if C.descr.type_num != NPY_FLOAT: raise ValueError("C is not of type float")

    lib_sgemm(CblasRowMajor, TransA, TransB, C.shape[0], C.shape[1], B.shape[0],
               alpha, <float*>A.data, A.shape[1], <float*>B.data, B.shape[1],
               beta, <float*>C.data, C.shape[1])


cdef void sgemm5(float alpha, np.ndarray A, np.ndarray B,
                 float beta,  np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if A.shape[0] != C.shape[0]: raise ValueError("A rows != C columns")
    if B.shape[1] != C.shape[1]: raise ValueError("B columns != C rows")
    if A.shape[1] != B.shape[0]: raise ValueError("A columns != B rows")
    if A.descr.type_num != NPY_FLOAT: raise ValueError("A is not of type float")
    if B.descr.type_num != NPY_FLOAT: raise ValueError("B is not of type float")
    if C.descr.type_num != NPY_FLOAT: raise ValueError("C is not of type float")

    lib_sgemm(CblasRowMajor,CblasNoTrans,CblasNoTrans, C.shape[0], C.shape[1],
              B.shape[0], alpha, <float*>A.data, A.shape[1], <float*>B.data,
              B.shape[1], beta, <float*>C.data, C.shape[1])


cdef void sgemm3(np.ndarray A, np.ndarray B, np.ndarray C):
    sgemm5(1.0, A, B, 0.0, C)


cdef np.ndarray sgemm(np.ndarray A, np.ndarray B):
    cdef np.ndarray C = smnewempty(A.shape[0], B.shape[1])
    sgemm5(1.0, A, B, 0.0, C)
    return C


# matrix times matrix: C = alpha * A   B   + beta * C
#                  or  C = alpha * A.T B   + beta * C
#                  or  C = alpha * A   B.T + beta * C
#                  or  C = alpha * A.T B.T + beta * C
#
# double precision

cdef void dgemm_(CBLAS_ORDER Order, CBLAS_TRANSPOSE TransA,
                 CBLAS_TRANSPOSE TransB,
                 int M, int N, int K, double alpha, double *A, int lda,
                                                    double *B, int ldb,
                                      double beta, double *C, int ldc):

    lib_dgemm(Order, TransA, TransB, M, N, K, alpha,
              A, lda, B, ldb, beta, C, ldc)


cdef void dgemm7(CBLAS_TRANSPOSE TransA, CBLAS_TRANSPOSE TransB, double alpha,
                 np.ndarray A, np.ndarray B, double beta, np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if TransA == CblasNoTrans:
        if A.shape[0] != C.shape[0]: raise ValueError("A rows != C cols")
    else:
        if A.shape[1] != C.shape[0]: raise ValueError("A cols != C cols")
    if TransB == CblasNoTrans:
        if B.shape[1] != C.shape[1]: raise ValueError("B cols != C rows")
    else:
        if B.shape[0] != C.shape[1]: raise ValueError("B cols != C rows")
    if TransA == CblasNoTrans:
        if TransB == CblasNoTrans:
            if A.shape[1] != B.shape[0]: raise ValueError("A cols != B rows")
        else:
            if A.shape[1] != B.shape[1]: raise ValueError("A cols != B cols")
    else:
        if TransB == CblasNoTrans:
            if A.shape[0] != B.shape[0]: raise ValueError("A rows != B rows")
        else:
            if A.shape[0] != B.shape[1]: raise ValueError("A rows != B cols")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if B.descr.type_num != NPY_DOUBLE:
        raise ValueError("B is not of type double")
    if C.descr.type_num != NPY_DOUBLE:
        raise ValueError("C is not of type double")

    lib_dgemm(CblasRowMajor, TransA, TransB, C.shape[0], C.shape[1], B.shape[0],
              alpha, <double*>A.data, A.shape[1], <double*>B.data, B.shape[1],
              beta, <double*>C.data, C.shape[1])


cdef void dgemm5(double alpha, np.ndarray A, np.ndarray B,
                      double beta, np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if A.shape[0] != C.shape[0]: raise ValueError("A rows != C columns")
    if B.shape[1] != C.shape[1]: raise ValueError("B columns != C rows")
    if A.shape[1] != B.shape[0]: raise ValueError("A columns != B rows")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if B.descr.type_num != NPY_DOUBLE:
        raise ValueError("B is not of type double")
    if C.descr.type_num != NPY_DOUBLE:
        raise ValueError("C is not of type double")

    lib_dgemm(CblasRowMajor,CblasNoTrans,CblasNoTrans, C.shape[0], C.shape[1],
              B.shape[0], alpha, <double*>A.data, A.shape[1], <double*>B.data,
              B.shape[1], beta, <double*>C.data, C.shape[1])


cdef void dgemm3(np.ndarray A, np.ndarray B, np.ndarray C):
    dgemm5(1.0, A, B, 0.0, C)


cdef np.ndarray dgemm(np.ndarray A, np.ndarray B):
    cdef np.ndarray C = dmnewempty(A.shape[0], B.shape[1])
    dgemm5(1.0, A, B, 0.0, C)
    return C


# matrix times matrix: C = alpha * A   B   + beta * C
#                  or: C = alpha * B   A   + beta * C
# where A = A.T.

# single precision

cdef void ssymm_(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 int M, int N,
                 float alpha, float *A, int lda,
                              float *B, int ldb,
                 float beta,  float *C, int ldc):
    lib_ssymm(Order, Side, Uplo, M, N, alpha, A, lda, B, ldb, beta, C, ldc)


cdef void ssymm8(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 float alpha, np.ndarray A, np.ndarray B,
                 float beta,  np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if Side == CblasLeft:
        if A.shape[0] != C.shape[0]: raise ValueError("A rows != C rows")
        if B.shape[1] != C.shape[1]: raise ValueError("B cols != C cols")
        if A.shape[1] != B.shape[0]: raise ValueError("A cols != B rows")
    else:
        if B.shape[0] != C.shape[0]: raise ValueError("B rows != C rows")
        if A.shape[1] != C.shape[1]: raise ValueError("A cols != C cols")
        if B.shape[1] != A.shape[0]: raise ValueError("B cols != A rows")
    if A.descr.type_num != NPY_FLOAT:
        raise ValueError("A is not of type float")
    if B.descr.type_num != NPY_FLOAT:
        raise ValueError("B is not of type float")
    if C.descr.type_num != NPY_FLOAT:
        raise ValueError("C is not of type float")

    lib_ssymm(Order, Side, Uplo, C.shape[0], C.shape[1],
              alpha, <float*>A.data, A.shape[1],
                     <float*>B.data, B.shape[1],
              beta,  <float*>C.data, C.shape[1])


cdef void ssymm5(float alpha, np.ndarray A, np.ndarray B, float beta,
                 np.ndarray C):

    ssymm8(CblasRowMajor, CblasLeft, CblasLower, alpha, A, B, beta, C)


cdef void ssymm3(np.ndarray A, np.ndarray B, np.ndarray C):

    ssymm5(1.0, A, B, 0.0, C)


cdef np.ndarray ssymm(np.ndarray A, np.ndarray B):

    cdef np.ndarray C = smnewempty(A.shape[0], B.shape[1])
    ssymm5(1.0, A, B, 0.0, C)
    return C


# double precision

cdef void dsymm_(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 int M, int N,
                 double alpha, double *A, int lda,
                               double *B, int ldb,
                 double beta,  double *C, int ldc):
    lib_dsymm(Order, Side, Uplo, M, N, alpha, A, lda, B, ldb, beta, C, ldc)


cdef void dsymm8(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 double alpha, np.ndarray A, np.ndarray B,
                 double beta,  np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if Side == CblasLeft:
        if A.shape[0] != C.shape[0]: raise ValueError("A rows != C rows")
        if B.shape[1] != C.shape[1]: raise ValueError("B cols != C cols")
        if A.shape[1] != B.shape[0]: raise ValueError("A cols != B rows")
    else:
        if B.shape[0] != C.shape[0]: raise ValueError("B rows != C rows")
        if A.shape[1] != C.shape[1]: raise ValueError("A cols != C cols")
        if B.shape[1] != A.shape[0]: raise ValueError("B cols != A rows")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if B.descr.type_num != NPY_DOUBLE:
        raise ValueError("B is not of type double")
    if C.descr.type_num != NPY_DOUBLE:
        raise ValueError("C is not of type double")

    lib_dsymm(Order, Side, Uplo, C.shape[0], C.shape[1],
              alpha, <double*>A.data, A.shape[1],
                     <double*>B.data, B.shape[1],
              beta,  <double*>C.data, C.shape[1])


cdef void dsymm5(double alpha, np.ndarray A, np.ndarray B, double beta,
                 np.ndarray C):

    dsymm8(CblasRowMajor, CblasLeft, CblasLower, alpha, A, B, beta, C)


cdef void dsymm3(np.ndarray A, np.ndarray B, np.ndarray C):

    dsymm5(1.0, A, B, 0.0, C)


cdef np.ndarray dsymm(np.ndarray A, np.ndarray B):

    cdef np.ndarray C = dmnewempty(A.shape[0], B.shape[1])
    dsymm5(1.0, A, B, 0.0, C)
    return C


# Symmetric rank k update: C <- alpha * A * A.T + beta * C
#                      or: C <- alpha * A.T * A + beta * C
#
# single precision

cdef void ssyrk_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE Trans,
                 int N, int K, float alpha, float *A, int lda, float beta,
                 float *C, int ldc):

    lib_ssyrk(Order, Uplo, Trans, N, K, alpha, A, lda, beta, C, ldc)


cdef void ssyrk7(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE Trans,
                 float alpha, np.ndarray A, float beta, np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if C.shape[0] != C.shape[1]: raise ValueError("C rows != C cols")
    if Trans == CblasTrans:
        if A.shape[1] != C.shape[0]: raise ValueError("A cols != C rows")
        K = A.shape[0]
    else:
        if A.shape[0] != C.shape[0]: raise ValueError("A rows != C rows")
        K = A.shape[1]
    if A.descr.type_num != NPY_FLOAT:
        raise ValueError("A is not of type float")
    if C.descr.type_num != NPY_FLOAT:
        raise ValueError("C is not of type float")

    lib_ssyrk(Order, Uplo, Trans, C.shape[0], K, alpha, <float*>A.data,
              A.shape[1], beta, <float*>C.data, C.shape[1])


cdef void ssyrk5(CBLAS_TRANSPOSE Trans, float alpha, np.ndarray A, float beta,
                 np.ndarray C):

    ssyrk7(CblasRowMajor, CblasLower, Trans, alpha, A, beta, C)


cdef void ssyrk2(np.ndarray A, np.ndarray C):

    ssyrk5(CblasNoTrans, 1.0, A, 0.0, C)


cdef np.ndarray ssyrk(np.ndarray A):

    cdef np.ndarray C = smnewempty(A.shape[0], A.shape[0])
    ssyrk5(CblasNoTrans, 1.0, A, 0.0, C)
    return C


# double precision

cdef void dsyrk_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE Trans,
                 int N, int K, double alpha, double *A, int lda, double beta,
                 double *C, int ldc):

    lib_dsyrk(Order, Uplo, Trans, N, K, alpha, A, lda, beta, C, ldc)


cdef void dsyrk7(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE Trans,
                 double alpha, np.ndarray A, double beta, np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if C.shape[0] != C.shape[1]: raise ValueError("C rows != C cols")
    if Trans == CblasTrans:
        if A.shape[1] != C.shape[0]: raise ValueError("A cols != C rows")
        K = A.shape[0]
    else:
        if A.shape[0] != C.shape[0]: raise ValueError("A rows != C rows")
        K = A.shape[1]
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if C.descr.type_num != NPY_DOUBLE:
        raise ValueError("C is not of type double")

    lib_dsyrk(Order, Uplo, Trans, C.shape[0], K, alpha, <double*>A.data,
              A.shape[1], beta, <double*>C.data, C.shape[1])


cdef void dsyrk5(CBLAS_TRANSPOSE Trans, double alpha, np.ndarray A, double beta,
                 np.ndarray C):

    dsyrk7(CblasRowMajor, CblasLower, Trans, alpha, A, beta, C)


cdef void dsyrk2(np.ndarray A, np.ndarray C):

    dsyrk5(CblasNoTrans, 1.0, A, 0.0, C)


cdef np.ndarray dsyrk(np.ndarray A):

    cdef np.ndarray C = dmnewempty(A.shape[0], A.shape[0])
    dsyrk5(CblasNoTrans, 1.0, A, 0.0, C)
    return C


# Symmetric rank-2k update: C <- alpha * A * B.T + alpha * B * A.T + beta * C
#                       or: C <- alpha * A.T * B + alpha * B.T * A + beta * C
#
# single precision

cdef void ssyr2k_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE Trans, int N,
                  int K, float alpha, float *A, int lda, float *B, int ldb,
                  float beta, float *C, int ldc):

    lib_ssyr2k(Order, Uplo, Trans, N, K, alpha, A, lda, B, ldb, beta, C, ldc)


cdef void ssyr2k8(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE Trans,
                  float alpha, np.ndarray A, np.ndarray B,
                  float beta, np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if C.shape[0] != C.shape[1]: raise ValueError("C rows != C cols")
    if Trans == CblasTrans:
        if A.shape[1] != C.shape[0]: raise ValueError("A cols != C rows")
        if A.shape[0] != B.shape[0]: raise ValueError("A rows != B rows")
        if B.shape[1] != C.shape[0]: raise ValueError("C rows != B cols")
        K = A.shape[0]
    else:
        if A.shape[0] != C.shape[0]: raise ValueError("A rows != C rows")
        if A.shape[1] != B.shape[1]: raise ValueError("A cols != B cols")
        if B.shape[0] != C.shape[0]: raise ValueError("B rows != C rows")
        K = A.shape[1]
    if A.descr.type_num != NPY_FLOAT:
        raise ValueError("A is not of type float")
    if B.descr.type_num != NPY_FLOAT:
        raise ValueError("B is not of type float")
    if C.descr.type_num != NPY_FLOAT:
        raise ValueError("C is not of type float")

    lib_ssyr2k(Order, Uplo, Trans, C.shape[0], K, alpha,
               <float*>A.data, A.shape[1], <float*>B.data, B.shape[1],
               beta, <float*>C.data, C.shape[1])


cdef void ssyr2k6(CBLAS_TRANSPOSE Trans, float alpha, np.ndarray A,
                  np.ndarray B, float beta, np.ndarray C):

    ssyr2k8(CblasRowMajor, CblasLower, Trans, alpha, A, B, beta, C)


cdef void ssyr2k3(np.ndarray A, np.ndarray B, np.ndarray C):

    ssyr2k6(CblasNoTrans, 1.0, A, B, 0.0, C)


cdef np.ndarray ssyr2k(np.ndarray A, np.ndarray B):

    cdef np.ndarray C = smnewempty(A.shape[0], A.shape[0])
    ssyr2k6(CblasNoTrans, 1.0, A, B, 0.0, C)
    return C


# double precision

cdef void dsyr2k_(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE Trans, int N,
                  int K, double alpha, double *A, int lda, double *B, int ldb,
                  double beta, double *C, int ldc):

    lib_dsyr2k(Order, Uplo, Trans, N, K, alpha, A, lda, B, ldb, beta, C, ldc)


cdef void dsyr2k8(CBLAS_ORDER Order, CBLAS_UPLO Uplo, CBLAS_TRANSPOSE Trans,
                  double alpha, np.ndarray A, np.ndarray B,
                  double beta, np.ndarray C):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if C.ndim != 2: raise ValueError("C is not a matrix")
    if C.shape[0] != C.shape[1]: raise ValueError("C rows != C cols")
    if Trans == CblasTrans:
        if A.shape[1] != C.shape[0]: raise ValueError("A cols != C rows")
        if A.shape[0] != B.shape[0]: raise ValueError("A rows != B rows")
        if B.shape[1] != C.shape[0]: raise ValueError("C rows != B cols")
        K = A.shape[0]
    else:
        if A.shape[0] != C.shape[0]: raise ValueError("A rows != C rows")
        if A.shape[1] != B.shape[1]: raise ValueError("A cols != B cols")
        if B.shape[0] != C.shape[0]: raise ValueError("B rows != C rows")
        K = A.shape[1]
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if B.descr.type_num != NPY_DOUBLE:
        raise ValueError("B is not of type double")
    if C.descr.type_num != NPY_DOUBLE:
        raise ValueError("C is not of type double")

    lib_dsyr2k(Order, Uplo, Trans, C.shape[0], K, alpha,
               <double*>A.data, A.shape[1], <double*>B.data, B.shape[1],
               beta, <double*>C.data, C.shape[1])


cdef void dsyr2k6(CBLAS_TRANSPOSE Trans, double alpha, np.ndarray A,
                  np.ndarray B, double beta, np.ndarray C):

    dsyr2k8(CblasRowMajor, CblasLower, Trans, alpha, A, B, beta, C)


cdef void dsyr2k3(np.ndarray A, np.ndarray B, np.ndarray C):

    dsyr2k6(CblasNoTrans, 1.0, A, B, 0.0, C)


cdef np.ndarray dsyr2k(np.ndarray A, np.ndarray B):

    cdef np.ndarray C = dmnewempty(A.shape[0], A.shape[0])
    dsyr2k6(CblasNoTrans, 1.0, A, B, 0.0, C)
    return C


#     B = alpha * A * B  or  B = alpha * A.T * B
# or  B = alpha * B * A  or  B = alpha * B * A.T
#
# where A is triangular.

# single precision

cdef void strmm_(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 CBLAS_TRANSPOSE TransA, CBLAS_DIAG Diag, int M, int N,
                 float alpha, float *A, int lda, float *B, int ldb):

    lib_strmm(Order, Side, Uplo, TransA, Diag, M, N, alpha, A, lda, B, ldb)


cdef void strmm8(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 CBLAS_TRANSPOSE TransA, CBLAS_DIAG Diag,
                 float alpha, np.ndarray A, np.ndarray B):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if TransA == CblasTrans:
        if Side == CblasLeft:
            if A.shape[0] != B.shape[0]: raise ValueError("A rows != B rows")
        else:
            if A.shape[1] != B.shape[1]: raise ValueError("A cols != B cols")
    else:
        if Side == CblasLeft:
            if A.shape[1] != B.shape[0]: raise ValueError("A cols != B rows")
        else:
            if A.shape[0] != B.shape[1]: raise ValueError("A rows != B cols")
    if A.descr.type_num != NPY_FLOAT:
        raise ValueError("A is not of type float")
    if B.descr.type_num != NPY_FLOAT:
        raise ValueError("B is not of type float")

    lib_strmm(Order, Side, Uplo, TransA, Diag, B.shape[0], B.shape[1],
              alpha, <float*>A.data, A.shape[1], <float*>B.data, B.shape[1])


cdef void strmm5(CBLAS_SIDE Side, CBLAS_TRANSPOSE TransA,
                 float alpha, np.ndarray A, np.ndarray B):

    strmm8(CblasRowMajor, Side, CblasLower, TransA, CblasNonUnit, alpha, A, B)


cdef void strmm3(float alpha, np.ndarray A, np.ndarray B):

    strmm8(CblasRowMajor, CblasLeft, CblasLower, CblasNoTrans, CblasNonUnit,
           alpha, A, B)


cdef void strmm(np.ndarray A, np.ndarray B):

    strmm3(1.0, A, B)


# double precision

cdef void dtrmm_(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 CBLAS_TRANSPOSE TransA, CBLAS_DIAG Diag, int M, int N,
                 double alpha, double *A, int lda, double *B, int ldb):

    lib_dtrmm(Order, Side, Uplo, TransA, Diag, M, N, alpha, A, lda, B, ldb)


cdef void dtrmm8(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 CBLAS_TRANSPOSE TransA, CBLAS_DIAG Diag,
                 double alpha, np.ndarray A, np.ndarray B):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if TransA == CblasTrans:
        if Side == CblasLeft:
            if A.shape[0] != B.shape[0]: raise ValueError("A rows != B rows")
        else:
            if A.shape[1] != B.shape[1]: raise ValueError("A cols != B cols")
    else:
        if Side == CblasLeft:
            if A.shape[1] != B.shape[0]: raise ValueError("A cols != B rows")
        else:
            if A.shape[0] != B.shape[1]: raise ValueError("A rows != B cols")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if B.descr.type_num != NPY_DOUBLE:
        raise ValueError("B is not of type double")

    lib_dtrmm(Order, Side, Uplo, TransA, Diag, B.shape[0], B.shape[1],
              alpha, <double*>A.data, A.shape[1], <double*>B.data, B.shape[1])


cdef void dtrmm5(CBLAS_SIDE Side, CBLAS_TRANSPOSE TransA,
                 double alpha, np.ndarray A, np.ndarray B):

    dtrmm8(CblasRowMajor, Side, CblasLower, TransA, CblasNonUnit, alpha, A, B)


cdef void dtrmm3(double alpha, np.ndarray A, np.ndarray B):

    dtrmm8(CblasRowMajor, CblasLeft, CblasLower, CblasNoTrans, CblasNonUnit,
           alpha, A, B)


cdef void dtrmm(np.ndarray A, np.ndarray B):

    dtrmm3(1.0, A, B)


#    B = alpha * inv(A) * B  or  B = alpha * inv(A).T * B
# or B = alpha * B * inv(A)  or  B = alpha * B * inv(A).T
#
# where A is triangular.

# single precision

cdef void strsm_(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 CBLAS_TRANSPOSE TransA, CBLAS_DIAG Diag, int M, int N,
                 float alpha, float *A, int lda, float *B, int ldb):

    lib_strsm(Order, Side, Uplo, TransA, Diag, M, N, alpha, A, lda, B, ldb)


cdef void strsm8(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 CBLAS_TRANSPOSE TransA, CBLAS_DIAG Diag,
                 float alpha, np.ndarray A, np.ndarray B):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if TransA == CblasTrans:
        if Side == CblasLeft:
            if A.shape[0] != B.shape[0]: raise ValueError("A rows != B rows")
        else:
            if A.shape[1] != B.shape[1]: raise ValueError("A cols != B cols")
    else:
        if Side == CblasLeft:
            if A.shape[1] != B.shape[0]: raise ValueError("A cols != B rows")
        else:
            if A.shape[0] != B.shape[1]: raise ValueError("A rows != B cols")
    if A.descr.type_num != NPY_FLOAT:
        raise ValueError("A is not of type float")
    if B.descr.type_num != NPY_FLOAT:
        raise ValueError("B is not of type float")

    lib_strsm(Order, Side, Uplo, TransA, Diag, B.shape[0], B.shape[1],
              alpha, <float*>A.data, A.shape[1], <float*>B.data, B.shape[1])


cdef void strsm5(CBLAS_SIDE Side, CBLAS_TRANSPOSE TransA,
                 float alpha, np.ndarray A, np.ndarray B):

    strsm8(CblasRowMajor, Side, CblasLower, TransA, CblasNonUnit, alpha, A, B)


cdef void strsm3(float alpha, np.ndarray A, np.ndarray B):

    strsm8(CblasRowMajor, CblasLeft, CblasLower, CblasNoTrans, CblasNonUnit,
           alpha, A, B)


cdef void strsm(np.ndarray A, np.ndarray B):

    strsm3(1.0, A, B)


# double precision

cdef void dtrsm_(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 CBLAS_TRANSPOSE TransA, CBLAS_DIAG Diag, int M, int N,
                 double alpha, double *A, int lda, double *B, int ldb):

    lib_dtrsm(Order, Side, Uplo, TransA, Diag, M, N, alpha, A, lda, B, ldb)


cdef void dtrsm8(CBLAS_ORDER Order, CBLAS_SIDE Side, CBLAS_UPLO Uplo,
                 CBLAS_TRANSPOSE TransA, CBLAS_DIAG Diag,
                 double alpha, np.ndarray A, np.ndarray B):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if B.ndim != 2: raise ValueError("B is not a matrix")
    if A.shape[0] != A.shape[1]: raise ValueError("A rows != A cols")
    if TransA == CblasTrans:
        if Side == CblasLeft:
            if A.shape[0] != B.shape[0]: raise ValueError("A rows != B rows")
        else:
            if A.shape[1] != B.shape[1]: raise ValueError("A cols != B cols")
    else:
        if Side == CblasLeft:
            if A.shape[1] != B.shape[0]: raise ValueError("A cols != B rows")
        else:
            if A.shape[0] != B.shape[1]: raise ValueError("A rows != B cols")
    if A.descr.type_num != NPY_DOUBLE:
        raise ValueError("A is not of type double")
    if B.descr.type_num != NPY_DOUBLE:
        raise ValueError("B is not of type double")

    lib_dtrsm(Order, Side, Uplo, TransA, Diag, B.shape[0], B.shape[1],
              alpha, <double*>A.data, A.shape[1], <double*>B.data, B.shape[1])


cdef void dtrsm5(CBLAS_SIDE Side, CBLAS_TRANSPOSE TransA,
                 double alpha, np.ndarray A, np.ndarray B):

    dtrsm8(CblasRowMajor, Side, CblasLower, TransA, CblasNonUnit, alpha, A, B)


cdef void dtrsm3(double alpha, np.ndarray A, np.ndarray B):

    dtrsm8(CblasRowMajor, CblasLeft, CblasLower, CblasNoTrans, CblasNonUnit,
           alpha, A, B)


cdef void dtrsm(np.ndarray A, np.ndarray B):

    dtrsm3(1.0, A, B)


#########################################################################
#
# Utility functions I've added myself
#
#########################################################################

# Create a new empty single precision matrix
cdef np.ndarray smnewempty(int M, int N):
    cdef np.npy_intp length[2]
    length[0] = M; length[1] = N
    Py_INCREF(np.NPY_FLOAT) # This is apparently necessary
    return PyArray_EMPTY(2, length, np.NPY_FLOAT, 0)


# Create a new empty double precision matrix
cdef np.ndarray dmnewempty(int M, int N):
    cdef np.npy_intp length[2]
    length[0] = M; length[1] = N
    Py_INCREF(np.NPY_DOUBLE) # This is apparently necessary
    return PyArray_EMPTY(2, length, np.NPY_DOUBLE, 0)

# Create a new empty single precision vector
cdef np.ndarray svnewempty(int M):
    cdef np.npy_intp length[1]
    length[0] = M
    Py_INCREF(np.NPY_FLOAT) # This is apparently necessary
    return PyArray_EMPTY(1, length, np.NPY_FLOAT, 0)


# Create a new empty double precision vector
cdef np.ndarray dvnewempty(int M):
    cdef np.npy_intp length[1]
    length[0] = M
    Py_INCREF(np.NPY_DOUBLE) # This is apparently necessary
    return PyArray_EMPTY(1, length, np.NPY_DOUBLE, 0)

# Create a new zeroed single precision matrix
cdef np.ndarray smnewzero(int M, int N):
    cdef np.npy_intp length[2]
    length[0] = M; length[1] = N
    Py_INCREF(np.NPY_FLOAT) # This is apparently necessary
    return PyArray_ZEROS(2, length, np.NPY_FLOAT, 0)


# Create a new zeroed double precision matrix
cdef np.ndarray dmnewzero(int M, int N):
    cdef np.npy_intp length[2]
    length[0] = M; length[1] = N
    Py_INCREF(np.NPY_DOUBLE) # This is apparently necessary
    return PyArray_ZEROS(2, length, np.NPY_DOUBLE, 0)


# Create a new zeroed single precision vector
cdef np.ndarray svnewzero(int M):
    cdef np.npy_intp length[1]
    length[0] = M
    Py_INCREF(np.NPY_FLOAT) # This is apparently necessary
    return PyArray_ZEROS(1, length, np.NPY_FLOAT, 0)


# Create a new zeroed double precision vector
cdef np.ndarray dvnewzero(int M):
    cdef np.npy_intp length[1]
    length[0] = M
    Py_INCREF(np.NPY_DOUBLE) # This is apparently necessary
    return PyArray_ZEROS(1, length, np.NPY_DOUBLE, 0)

# Set a matrix to all zeros: must be floats in contiguous memory.
cdef void smsetzero(np.ndarray A):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if A.descr.type_num != NPY_FLOAT: raise ValueError("A is not of type float")

    cdef float *ptr = <float*>A.data
    cdef unsigned int i
    for i in range(A.shape[0]*A.shape[1]):
        ptr[0] = 0.0
        ptr += 1

# Set a matrix to all zeros: must be doubles in contiguous memory.
cdef void dmsetzero(np.ndarray A):

    if A.ndim != 2: raise ValueError("A is not a matrix")
    if A.descr.type_num != NPY_DOUBLE: raise ValueError("A is not of type double")

    cdef double *ptr = <double*>A.data
    cdef unsigned int i
    for i in range(A.shape[0]*A.shape[1]):
        ptr[0] = 0.0
        ptr += 1


# Set a vector to all zeros: ust be floats in contiguous memory.
cdef void svsetzero(np.ndarray x):

    if x.ndim != 1: raise ValueError("A is not a vector")
    if x.descr.type_num != NPY_FLOAT: raise ValueError("x is not of type float")

    cdef float *ptr = <float*>x.data
    cdef unsigned int i
    for i in range(x.shape[0]):
        ptr[0] = 0.0
        ptr += 1

# Set a vector to all zeros: ust be doubles in contiguous memory.
cdef void dvsetzero(np.ndarray x):

    if x.ndim != 1: raise ValueError("A is not a vector")
    if x.descr.type_num != NPY_DOUBLE: raise ValueError("x is not of type double")

    cdef double *ptr = <double*>x.data
    cdef unsigned int i
    for i in range(x.shape[0]):
        ptr[0] = 0.0
        ptr += 1


# Just pretend the matrices are vectors and call the BLAS daxpy routine
# Y += a * X
# single precision
cdef void smaxpy(float alpha, np.ndarray X, np.ndarray Y):

    if X.ndim != 2: raise ValueError("A is not a matrix")
    if Y.ndim != 2: raise ValueError("A is not a matrix")
    if X.shape[0] != Y.shape[0]: raise ValueError("X rows != Y rows")
    if X.shape[1] != Y.shape[1]: raise ValueError("X columns != Y columns")
    if X.descr.type_num != NPY_FLOAT: raise ValueError("X is not of type float")
    if Y.descr.type_num != NPY_FLOAT: raise ValueError("Y is not of type float")

    cdef unsigned int N = X.shape[0]*X.shape[1]

    lib_saxpy(N, alpha, <float*>X.data, 1, <float*>Y.data, 1)


# Just pretend the matrices are vectors and call the BLAS daxpy routine
# Y += a * X
# double precision
cdef void dmaxpy(double alpha, np.ndarray X, np.ndarray Y):

    if X.ndim != 2: raise ValueError("A is not a matrix")
    if Y.ndim != 2: raise ValueError("A is not a matrix")
    if X.shape[0] != Y.shape[0]: raise ValueError("X rows != Y rows")
    if X.shape[1] != Y.shape[1]: raise ValueError("X columns != Y columns")
    if X.descr.type_num != NPY_DOUBLE: raise ValueError("X is not of type double")
    if Y.descr.type_num != NPY_DOUBLE: raise ValueError("Y is not of type double")

    cdef unsigned int N = X.shape[0]*X.shape[1]

    lib_daxpy(N, alpha, <double*>X.data, 1, <double*>Y.data, 1)


