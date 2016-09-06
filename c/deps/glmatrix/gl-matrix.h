#ifndef GL_MATRIX_H
#define GL_MATRIX_H

#ifdef __cplusplus
extern "C" {
#endif

/* 
 * gl-matrix.c - High performance matrix and vector operations for OpenGL
 * Version 1.2.3
 */
 
#define GL_MATRIX_MAJOR_VERSION 1
#define GL_MATRIX_MINOR_VERSION 2
#define GL_MATRIX_MICRO_VERSION 3

#define GL_MATRIX_VERSION  "1.2.3"

/* Hex version number. A value of 0x010203 means version 1.2.3.
  useful for comparisons. e.g. GL_MATRIX_VERSION_HEX >= 0x010203 */
#define GL_MATRIX_VERSION_HEX  ((GL_MATRIX_MAJOR_VERSION << 16) | \
                              (GL_MATRIX_MINOR_VERSION << 8) | \
                              (GL_MATRIX_MICRO_VERSION))

#include "funcs.h"

#ifdef __cplusplus
}
#endif

#endif
