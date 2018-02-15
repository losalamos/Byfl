#ifndef PAPI_SDE_INTERFACE_H
#define PAPI_SDE_INTERFACE_H

#include<stdio.h>
#include <stddef.h>

/* interface to papi SDE functions */
typedef void* papi_handle_t;

papi_handle_t papi_sde_init(char *name_of_library, int event_count);
void papi_sde_register_counter(papi_handle_t handle, char *event_name, long long int *counter);
void papi_sde_describe_counter(papi_handle_t handle, char *event_name, char *event_description );

/* required for papi_native_avail */
void* papi_sde_hook_list_events( 
    void*   (*sym_init)( char *, int ),
    void   (*sym_reg)( void *, char *, long long * ),
    void   (*sym_desc)( void *, char *, char * ) );

#endif
