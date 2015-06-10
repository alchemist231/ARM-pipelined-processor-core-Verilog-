
/*****************************************************************************
 *
 * Copyright 1991-2013 Mentor Graphics Corporation
 *
 * All Rights Reserved.
 *
 * THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE PROPERTY OF 
 * MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.
 *
 * Simple VPI test.
 *
 * This code is written in a bottom-up manner.  Look at the bottom of the
 * file to find the entry point.
 *
 *****************************************************************************/

/*****************************************************************************
 * INCLUDES
 *****************************************************************************/

#include "vpi_user.h"

/*****************************************************************************
 * FUNCTION PROTOTYPES
 *****************************************************************************/

static void vpit_DumpPortDetails( vpiHandle port_handle );
static void vpit_DumpNetDetails( vpiHandle net_handle );
static void vpit_DumpRegDetails( vpiHandle reg_handle );

/*****************************************************************************
 * FUNCTION DEFINITIONS
 *****************************************************************************/

/*****************************************************************************
 *
 * vpit_CheckError()
 *
 * Checks if an error was reported by the last vpi function called
 * and, if so, prints it to the specified output file.
 *
 *****************************************************************************/

static int vpit_CheckError( void )
{
    int              error_code;
    s_vpi_error_info error_info;

    error_code = vpi_chk_error( &error_info );
    if ( error_code && error_info.message ) {
        vpi_printf( "  %s\n", error_info.message );
    }

    return error_code;
}

/*****************************************************************************
 *
 * vpit_GetDelayModeStr()
 *
 * Get the string representation of the delay mode.
 *
 *****************************************************************************/

static char * vpit_GetDelayModeStr( int delay_mode )
{
    char * tmpstr;

    switch ( delay_mode ) {
      case vpiDelayModeNone:
        tmpstr = "vpiDelayModeNone";
        break;
      case vpiDelayModePath:
        tmpstr = "vpiDelayModePath";
        break;
      case vpiDelayModeDistrib:
        tmpstr = "vpiDelayModeDistrib";
        break;
      case vpiDelayModeUnit:
        tmpstr = "vpiDelayModeUnit";
        break;
      case vpiDelayModeZero:
        tmpstr = "vpiDelayModeZero";
        break;
      default:
        tmpstr = "UNKNOWN";
        break;
    }

    return tmpstr;
}

/*****************************************************************************
 *
 * vpit_GetTimeUnitStr()
 *
 * Get the string representation of the time unit
 *
 *****************************************************************************/

static char * vpit_GetTimeUnitStr( int time_unit )
{
    char * tmpstr;

    switch ( time_unit ) {
      case 2:
        tmpstr = "100 s";
        break;
      case 1:
        tmpstr = "10 s";
        break;
      case 0:
        tmpstr = "1 s";
        break;
      case -1:
        tmpstr = "100 ms";
        break;
      case -2:
        tmpstr = "10 ms";
        break;
      case -3:
        tmpstr = "1 ms";
        break;
      case -4:
        tmpstr = "100 us";
        break;
      case -5:
        tmpstr = "10 us";
        break;
      case -6:
        tmpstr = "1 us";
        break;
      case -7:
        tmpstr = "100 ns";
        break;
      case -8:
        tmpstr = "10 ns";
        break;
      case -9:
        tmpstr = "1 ns";
        break;
      case -10:
        tmpstr = "100 ps";
        break;
      case -11:
        tmpstr = "10 ps";
        break;
      case -12:
        tmpstr = "1 ps";
        break;
      case -13:
        tmpstr = "100 fs";
        break;
      case -14:
        tmpstr = "10 fs";
        break;
      case -15:
        tmpstr = "1 fs";
        break;
      default:
        tmpstr = "UNKNOWN";
        break;
    }

    return tmpstr;
}

/*****************************************************************************
 *
 * vpit_GetDirectionStr()
 *
 * Get the string representation of the direction.
 *
 *****************************************************************************/

static char * vpit_GetDirectionStr( int direction )
{
    char * tmpstr;

    switch ( direction ) {
      case vpiInput:
        tmpstr = "vpiInput";
        break;
      case vpiOutput:
        tmpstr = "vpiOutput";
        break;
      case vpiInout:
        tmpstr = "vpiInout";
        break;
      case vpiMixedIO:
        tmpstr = "vpiMixedIO";
        break;
      case vpiNoDirection:
        tmpstr = "vpiNoDirection";
        break;
      default:
        tmpstr = "UNKNOWN";
        break;
    }

    return tmpstr;
}

/*****************************************************************************
 *
 * vpit_DumpPortBitInfo()
 *
 * Print info about specified port's bits.
 *
 *****************************************************************************/

void vpit_DumpPortBitInfo( vpiHandle port_handle )
{
    int         bitnum = 0;
    int         error_code;
    vpiHandle   pbiter_handle;
    vpiHandle   portbit_handle;
    vpiHandle   tmphandle;

    pbiter_handle = vpi_iterate( vpiBit, port_handle );
    error_code = vpit_CheckError();
    if ( ! error_code && pbiter_handle ) {
        portbit_handle = vpi_scan( pbiter_handle );
        error_code = vpit_CheckError();
        while ( portbit_handle ) {
            bitnum++;
            vpi_printf( "\n  Port Bit #%d: ----------\n", bitnum );

            vpit_DumpPortDetails( portbit_handle );

            tmphandle = vpi_handle( vpiParent, portbit_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "    Parent        is %s",
                           vpi_get_str( vpiName, tmphandle ) );
                vpi_printf( " of type %s (%d).\n",
                           vpi_get_str( vpiType, tmphandle),
                           vpi_get( vpiType, tmphandle ) );
                vpi_free_object( tmphandle );
            }

            vpi_free_object( portbit_handle );
            portbit_handle = vpi_scan( pbiter_handle );
            error_code = vpit_CheckError();
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpPortDetails()
 *
 * Print detailed info about specified port.
 *
 *****************************************************************************/

static void vpit_DumpPortDetails( vpiHandle port_handle )
{
    char      * tmpstr;
    int         error_code;
    int         is_vector;
    int         objtype;
    int         tmpint;
    vpiHandle   tmphandle;

    objtype = vpi_get( vpiType, port_handle );

    if ( objtype == vpiPort ) {
        tmpstr = vpi_get_str( vpiName, port_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            vpi_printf( "\n  Port name is %s.\n",
                       tmpstr ? tmpstr : "<NULL>" );
        }
    }

    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Type          is %s (%d).\n",
                   vpi_get_str( vpiType, port_handle ), objtype );
    }

    tmpint = vpi_get( vpiDirection, port_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Direction     is %s.\n",
                   vpit_GetDirectionStr(tmpint) );
    }

    if ( objtype == vpiPort ) {
        tmpint = vpi_get( vpiPortIndex, port_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            vpi_printf( "    Port Index    is %d.\n", tmpint );
        }
    }

    tmpint = vpi_get( vpiLineNo, port_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Line No       is %d.\n", tmpint );
    }

    tmpstr = vpi_get_str( vpiFile, port_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    File          is %s.\n", tmpstr );
    }

    tmpint = vpi_get( vpiScalar, port_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Scalar        is %s.\n",
                   tmpint ? "TRUE" : "FALSE" );
    }

    tmpint = vpi_get( vpiSize, port_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Size          is %d.\n", tmpint );
    }

    is_vector = vpi_get( vpiVector, port_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Vector        is %s.\n",
                   is_vector ? "TRUE" : "FALSE" );
    }

    if ( objtype == vpiPort ) {
        tmphandle = vpi_handle( vpiModule, port_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            vpi_printf( "    Module        is %s",
                       vpi_get_str( vpiName, tmphandle ) );
            vpi_printf( " of type %s.\n",
                       vpi_get_str( vpiType, tmphandle ) );
            vpi_free_object( tmphandle );
        }
    }

    if ( is_vector ) {
        vpit_DumpPortBitInfo( port_handle );
    }
}

/*****************************************************************************
 *
 * vpit_DumpPortInfo()
 *
 * Print info about specified module's ports.
 *
 *****************************************************************************/

static void vpit_DumpPortInfo( vpiHandle mod_handle )
{
    int         error_code;
    vpiHandle   piter_handle;
    vpiHandle   port_handle;

    piter_handle = vpi_iterate( vpiPort, mod_handle );
    error_code  = vpit_CheckError();
    if ( ! error_code && piter_handle ) {
        port_handle = vpi_scan( piter_handle );
        error_code = vpit_CheckError();
        while ( port_handle ) {
            vpit_DumpPortDetails( port_handle );
            vpi_free_object( port_handle );
            port_handle = vpi_scan( piter_handle );
            error_code = vpit_CheckError();
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpNetBitInfo()
 *
 * Print info about specified net's bits.
 *
 *****************************************************************************/

static void vpit_DumpNetBitInfo( vpiHandle net_handle )
{
    int         bitnum = 0;
    int         error_code;
    int         objtype;
    vpiHandle   nbiter_handle;
    vpiHandle   netbit_handle;
    vpiHandle   tmphandle;

    nbiter_handle = vpi_iterate( vpiBit, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code && nbiter_handle ) {
        netbit_handle = vpi_scan( nbiter_handle );
        error_code = vpit_CheckError();
        while ( netbit_handle ) {
            bitnum++;
            vpi_printf( "\n  Net Bit #%d: ----------\n", bitnum );

            vpit_DumpNetDetails( netbit_handle );

            tmphandle = vpi_handle( vpiParent, netbit_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                objtype = vpi_get( vpiType, tmphandle );
                vpi_printf( "    Parent        is %s",
                           vpi_get_str( vpiName, tmphandle ) );
                vpi_printf( " of type %s (%d).\n",
                           vpi_get_str( vpiType, tmphandle ), objtype );
                vpi_free_object( tmphandle );
            }

            vpi_free_object( netbit_handle );
            netbit_handle = vpi_scan( nbiter_handle );
            error_code = vpit_CheckError();
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpNetDetails()
 *
 * Print detailed info about specified net.
 *
 *****************************************************************************/

static void vpit_DumpNetDetails( vpiHandle net_handle )
{
    char      * tmpstr;
    vpiHandle   tmphandle;
    int         error_code;
    int         is_vector;
    int         objtype;
    int         tmpint;
    s_vpi_value value_info;

    tmpstr = vpi_get_str( vpiName, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "\n  Net name is %s.\n",
                   tmpstr ? tmpstr : "<NULL>" );
    }

    objtype = vpi_get( vpiType, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Type          is %s (%d).\n",
                   vpi_get_str( vpiType, net_handle ), objtype );
    }

    tmpint = vpi_get( vpiLineNo, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Line No       is %d.\n", tmpint );
    }

    tmpstr = vpi_get_str( vpiFile, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    File          is %s.\n", tmpstr );
    }

    tmpstr = vpi_get_str( vpiFullName, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Full Name     is %s.\n",
                   tmpstr ? tmpstr : "<NULL>" );
    }

    tmpint = vpi_get( vpiNetType, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Net Type      is %s.\n",
                   vpi_get_str( vpiNetType, net_handle ) );
    }

    tmpint = vpi_get( vpiScalar, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Scalar        is %s.\n",
                   tmpint ? "TRUE" : "FALSE" );
    }

    tmpint = vpi_get( vpiSize, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Size          is %d.\n", tmpint );
    }

    is_vector = vpi_get( vpiVector, net_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Vector        is %s.\n",
                   is_vector ? "TRUE" : "FALSE" );
    }

    if ( is_vector ) {
        tmphandle = vpi_handle( vpiLeftRange, net_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            value_info.format = vpiIntVal;
            vpi_get_value( tmphandle, &value_info );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "    Left  Range   is %d.\n",
                           value_info.value.integer );
            }
            vpi_free_object( tmphandle );
        }

        tmphandle = vpi_handle( vpiRightRange, net_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            value_info.format = vpiIntVal;
            vpi_get_value( tmphandle, &value_info );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "    Right Range   is %d.\n",
                           value_info.value.integer );
            }
            vpi_free_object( tmphandle );
        }
    }

    if ( objtype == vpiNetBit ) {
        tmphandle = vpi_handle( vpiIndex, net_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            value_info.format = vpiIntVal;
            vpi_get_value( tmphandle, &value_info );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "    Index value   is %d.\n",
                           value_info.value.integer );
            }
            vpi_free_object( tmphandle );
        }
    } else {
        tmphandle = vpi_handle( vpiModule, net_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            vpi_printf( "    Module        is %s",
                       vpi_get_str( vpiName, tmphandle ) );
            vpi_printf( " of type %s (%d).\n",
                       vpi_get_str( vpiType, tmphandle ),
                       vpi_get( vpiType, tmphandle ) );
            vpi_free_object( tmphandle );
        }
        if ( is_vector ) {
            vpit_DumpNetBitInfo( net_handle );
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpNetInfo()
 *
 * Print info about specified module's nets.
 *
 *****************************************************************************/

static void vpit_DumpNetInfo( vpiHandle mod_handle )
{
    int         error_code;
    vpiHandle   niter_handle;
    vpiHandle   net_handle;

    niter_handle = vpi_iterate( vpiNet, mod_handle );
    error_code  = vpit_CheckError();
    if ( ! error_code && niter_handle ) {
        net_handle = vpi_scan( niter_handle );
        error_code = vpit_CheckError();
        while ( net_handle ) {
            vpit_DumpNetDetails( net_handle );
            vpi_free_object( net_handle );
            net_handle = vpi_scan( niter_handle );
            error_code = vpit_CheckError();
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpRegBitInfo()
 *
 * Print info about specified reg's bits.
 *
 *****************************************************************************/

static void vpit_DumpRegBitInfo( vpiHandle reg_handle )
{
    int         bitnum = 0;
    int         error_code;
    int         objtype;
    vpiHandle   rbiter_handle;
    vpiHandle   regbit_handle;
    vpiHandle   tmphandle;

    rbiter_handle = vpi_iterate( vpiBit, reg_handle );
    error_code = vpit_CheckError();
    if ( ! error_code && rbiter_handle ) {
        regbit_handle = vpi_scan( rbiter_handle );
        error_code = vpit_CheckError();
        while ( regbit_handle ) {
            bitnum++;
            vpi_printf( "\n  Reg Bit #%d: ----------\n", bitnum );

            vpit_DumpRegDetails( regbit_handle );

            tmphandle = vpi_handle( vpiParent, regbit_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                objtype = vpi_get( vpiType, tmphandle );
                vpi_printf( "    Parent        is %s",
                           vpi_get_str( vpiName, tmphandle ) );
                vpi_printf( " of type %s (%d).\n",
                           vpi_get_str( vpiType, tmphandle ), objtype );
                vpi_free_object( tmphandle );
            }

            vpi_free_object( regbit_handle );
            regbit_handle = vpi_scan( rbiter_handle );
            error_code = vpit_CheckError();
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpRegDetails()
 *
 * Print detailed info about specified reg.
 *
 *****************************************************************************/

static void vpit_DumpRegDetails( vpiHandle reg_handle )
{
    char      * tmpstr;
    vpiHandle   tmphandle;
    int         error_code;
    int         objtype;
    int         tmpint;
    int         is_vector;
    s_vpi_value value_info;

    tmpstr = vpi_get_str( vpiName, reg_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "\n  Reg name is %s.\n", tmpstr ? tmpstr : "<NULL>" );
    }

    objtype = vpi_get( vpiType, reg_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Type          is %s (%d).\n",
                   vpi_get_str( vpiType, reg_handle ), objtype );
    }

    tmpint = vpi_get( vpiLineNo, reg_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Line No       is %d.\n", tmpint );
    }

    tmpstr = vpi_get_str( vpiFile, reg_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    File          is %s.\n", tmpstr );
    }

    tmpstr = vpi_get_str( vpiFullName, reg_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Full Name     is %s.\n",
                   tmpstr ? tmpstr : "<NULL>" );
    }

    tmpint = vpi_get( vpiScalar, reg_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Scalar        is %s.\n",
                   tmpint ? "TRUE" : "FALSE" );
    }

    tmpint = vpi_get( vpiSize, reg_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Size          is %d.\n", tmpint );
    }

    is_vector = vpi_get( vpiVector, reg_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Vector        is %s.\n",
                   is_vector ? "TRUE" : "FALSE" );
    }

    if ( is_vector ) {
        tmphandle = vpi_handle( vpiLeftRange, reg_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            value_info.format = vpiIntVal;
            vpi_get_value( tmphandle, &value_info );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "    Left  Range   is %d.\n",
                           value_info.value.integer );
            }
            vpi_free_object( tmphandle );
        }

        tmphandle = vpi_handle( vpiRightRange, reg_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            value_info.format = vpiIntVal;
            vpi_get_value( tmphandle, &value_info );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "    Right Range   is %d.\n",
                           value_info.value.integer );
            }
            vpi_free_object( tmphandle );
        }
    }

    if ( objtype == vpiRegBit ) {
        tmphandle = vpi_handle( vpiIndex, reg_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            value_info.format = vpiIntVal;
            vpi_get_value( tmphandle, &value_info );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "    Index value   is %d.\n",
                           value_info.value.integer );
            }
            vpi_free_object( tmphandle );
        }
    }

    if ( objtype == vpiReg ) {
        tmphandle = vpi_handle( vpiScope, reg_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            vpi_printf( "    Scope         is %s",
                       vpi_get_str( vpiName, tmphandle ) );
            vpi_printf( " of type %s (%d).\n",
                       vpi_get_str( vpiType, tmphandle ),
                       vpi_get( vpiType, tmphandle ) );
            vpi_free_object( tmphandle );
        }

        tmphandle = vpi_handle( vpiModule, reg_handle );
        error_code = vpit_CheckError();
        if ( ! error_code ) {
            vpi_printf( "    Module        is %s",
                       vpi_get_str( vpiName, tmphandle ) );
            vpi_printf( " of type %s (%d).\n",
                       vpi_get_str( vpiType, tmphandle ),
                       vpi_get( vpiType, tmphandle ) );
            vpi_free_object( tmphandle );
        }

        if ( is_vector ) {
            vpit_DumpRegBitInfo( reg_handle );
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpRegInfo()
 *
 * Print info about specified scope's regs.
 *
 *****************************************************************************/

static void vpit_DumpRegInfo( vpiHandle scope_handle )
{
    int         error_code;
    vpiHandle   riter_handle;
    vpiHandle   reg_handle;

    /* Print info about all registers declared in the module. */

    riter_handle = vpi_iterate( vpiReg, scope_handle );
    error_code   = vpit_CheckError();
    if ( ! error_code && riter_handle ) {
        reg_handle = vpi_scan( riter_handle );
        error_code = vpit_CheckError();
        while ( reg_handle ) {
            vpit_DumpRegDetails( reg_handle );
            vpi_free_object( reg_handle );
            reg_handle = vpi_scan( riter_handle );
            error_code = vpit_CheckError();
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpVarDetails()
 *
 * Print detailed info about specified variable.
 *
 *****************************************************************************/

static void vpit_DumpVarDetails( vpiHandle var_handle )
{
    char      * tmpstr;
    vpiHandle   tmphandle;
    int         error_code;
    int         objtype;
    int         tmpint;

    tmpstr = vpi_get_str( vpiName, var_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "\n  Variable name is %s.\n",
                   tmpstr ? tmpstr : "<NULL>" );
    }

    objtype = vpi_get( vpiType, var_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Type          is %s (%d).\n",
                   vpi_get_str( vpiType, var_handle ), objtype );
    }

    tmpint = vpi_get( vpiLineNo, var_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Line No       is %d.\n", tmpint );
    }

    tmpstr = vpi_get_str( vpiFile, var_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    File          is %s.\n", tmpstr );
    }

    tmpstr = vpi_get_str( vpiFullName, var_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Full Name     is %s.\n",
                   tmpstr ? tmpstr : "<NULL>" );
    }

    tmpint = vpi_get( vpiSize, var_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Size          is %d.\n", tmpint );
    }

    tmpint = vpi_get( vpiArray, var_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        vpi_printf( "    Array         is %s.\n", tmpint ? "TRUE" : "FALSE" );
    }

    tmphandle = vpi_handle( vpiScope, var_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        objtype = vpi_get( vpiType, tmphandle );
        vpi_printf( "    Scope         is %s",
                   vpi_get_str( vpiName, tmphandle ) );
        vpi_printf( " of type %s (%d).\n",
                   vpi_get_str( vpiType, tmphandle ),
                   vpi_get( vpiType, tmphandle ) );
        vpi_free_object( tmphandle );
    }

    tmphandle = vpi_handle( vpiModule, var_handle );
    error_code = vpit_CheckError();
    if ( ! error_code ) {
        objtype = vpi_get( vpiType, tmphandle );
        vpi_printf( "    Module        is %s",
                   vpi_get_str( vpiName, tmphandle ) );
        vpi_printf( " of type %s (%d).\n",
                   vpi_get_str( vpiType, tmphandle ),
                   vpi_get( vpiType, tmphandle ) );
        vpi_free_object( tmphandle );
    }
}

/*****************************************************************************
 *
 * vpit_DumpVarInfo()
 *
 * Print info about specified scope's variables.
 *
 *****************************************************************************/

static void vpit_DumpVarInfo( vpiHandle scope_handle )
{
    int         error_code;
    vpiHandle   viter_handle;
    vpiHandle   var_handle;

    /* Print info about all variables declared in the module. */

    viter_handle = vpi_iterate( vpiVariables, scope_handle );
    error_code   = vpit_CheckError();
    if ( ! error_code && viter_handle ) {
        var_handle = vpi_scan( viter_handle );
        error_code = vpit_CheckError();
        while ( var_handle ) {
            vpit_DumpVarDetails( var_handle );
            vpi_free_object( var_handle );
            var_handle = vpi_scan( viter_handle );
            error_code = vpit_CheckError();
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpScopeInfo()
 *
 * Print info about specified scope.
 *
 *****************************************************************************/

static void vpit_DumpScopeInfo( vpiHandle parent )
{
    char      * tmpstr;
    int         error_code;
    vpiHandle   scope_handle;
    vpiHandle   siter_handle;

    siter_handle = vpi_iterate( vpiInternalScope, parent );
    error_code   = vpit_CheckError();
    if ( ! error_code && siter_handle ) {
        scope_handle = vpi_scan( siter_handle );
        error_code = vpit_CheckError();
        while ( scope_handle ) {

            tmpstr = vpi_get_str( vpiName, scope_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "\nInternal scope is %s",
                           tmpstr ? tmpstr : "<NULL>" );
                vpi_printf( " of type %s (%d).\n",
                           vpi_get_str( vpiType, scope_handle ),
                           vpi_get( vpiType, scope_handle ) );
            }

            vpit_DumpRegInfo( scope_handle );

            vpit_DumpVarInfo( scope_handle );

            vpi_free_object( scope_handle );
            scope_handle = vpi_scan( siter_handle );
            error_code = vpit_CheckError();
        }
    }
}

/*****************************************************************************
 *
 * vpit_DumpModuleInfo()
 *
 * Print info about specified module.
 *
 *****************************************************************************/

static void vpit_DumpModuleInfo( vpiHandle parent )
{
    char      * tmpstr;
    int         error_code;
    int         is_top_module;
    int         objtype;
    int         tmpint;
    vpiHandle   miter_handle;
    vpiHandle   mod_handle;
    vpiHandle   tmphandle;

    miter_handle = vpi_iterate( vpiModule, parent );
    error_code  = vpit_CheckError();
    if ( ! error_code && miter_handle ) {

        mod_handle = vpi_scan( miter_handle );
        error_code = vpit_CheckError();
        while ( mod_handle ) {
            tmpstr = vpi_get_str( vpiName, mod_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "\nModule name is %s.\n",
                           tmpstr ? tmpstr : "<NULL>" );
            }

            objtype = vpi_get( vpiType, mod_handle );
            error_code = vpit_CheckError();
            tmpstr = vpi_get_str( vpiType, mod_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "  Type           is %s (%d).\n", tmpstr, objtype);
            }

            tmpint = vpi_get( vpiCellInstance, mod_handle );
            error_code = vpit_CheckError();
            if ( tmpint >= 0 ) {
                vpi_printf( "  Cell Instance  is %s.\n",
                           tmpint ? "TRUE" : "FALSE" );
            }

            tmpstr = vpi_get_str( vpiDefFile, mod_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "  Def File       is %s.\n",
                           tmpstr ? tmpstr : "<NULL>" );
            }

            tmpstr = vpi_get_str( vpiDefName, mod_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "  Def Name       is %s.\n",
                           tmpstr ? tmpstr : "<NULL>" );
            }

            tmpint = vpi_get( vpiDefDelayMode, mod_handle );
            error_code = vpit_CheckError();
            if ( tmpint >= 0 ) {
                vpi_printf( "  Def Delay Mode is %d (%s).\n",
                           tmpint, vpit_GetDelayModeStr(tmpint) );
            }

            tmpstr = vpi_get_str( vpiFile, mod_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "  File           is %s.\n",
                           tmpstr ? tmpstr : "<NULL>" );
            }

            tmpstr = vpi_get_str( vpiFullName, mod_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "  Full Name      is %s.\n",
                           tmpstr ? tmpstr : "<NULL>" );
            }

            tmpint = vpi_get( vpiProtected, mod_handle );
            error_code = vpit_CheckError();
            if ( tmpint >= 0 ) {
                vpi_printf( "  Protected      is %s.\n",
                           tmpint ? "TRUE" : "FALSE" );
            }

            tmpint = vpi_get( vpiTimePrecision, mod_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "  Time Precision is %d (%s).\n", tmpint,
                           vpit_GetTimeUnitStr(tmpint) );
            }

            tmpint = vpi_get( vpiTimeUnit, mod_handle );
            error_code = vpit_CheckError();
            if ( ! error_code ) {
                vpi_printf( "  Time Unit      is %d (%s).\n", tmpint,
                           vpit_GetTimeUnitStr(tmpint) );
            }

            is_top_module = vpi_get( vpiTopModule, mod_handle );
            error_code = vpit_CheckError();
            if ( is_top_module >= 0 ) {
                vpi_printf( "  Top Module     is %s.\n",
                           is_top_module ? "TRUE" : "FALSE" );
            }

            if ( ! is_top_module ) {
                tmphandle = vpi_handle( vpiModule, mod_handle );
                error_code = vpit_CheckError();
                if ( ! error_code ) {
                    vpi_printf( "  Module         is %s",
                               vpi_get_str( vpiName, tmphandle ) );
                    vpi_printf( " of type %s (%d).\n",
                               vpi_get_str( vpiType, tmphandle ),
                               vpi_get( vpiType, tmphandle ) );
                    vpi_free_object( tmphandle );
                }
            }

            vpit_DumpPortInfo( mod_handle );

            vpit_DumpNetInfo( mod_handle );

            vpit_DumpRegInfo( mod_handle );

            vpit_DumpVarInfo( mod_handle );

            vpit_DumpScopeInfo( mod_handle );

            vpit_DumpModuleInfo( mod_handle );

            vpi_free_object( mod_handle );
            mod_handle = vpi_scan( miter_handle );
            error_code = vpit_CheckError();
        }
    }
}

/*****************************************************************************
 *
 * vpit_TraverseDesign()
 *
 * Traverse the design and print info about it.
 *
 *****************************************************************************/

PLI_INT32 vpit_TraverseDesign( PLI_BYTE8 *user_data )
{

    vpi_printf( "\n===========================\n" );
    vpi_printf( "Results of Design Traversal\n" );
    vpi_printf( "===========================\n" );

    vpit_DumpModuleInfo( 0 );

    return 0;
}

/*****************************************************************************
 *
 * vpit_RegisterTfs
 *
 * Registers test functions with the simulator.
 *
 *****************************************************************************/

void vpit_RegisterTfs( void )
{
    s_vpi_systf_data systf_data;
    vpiHandle        systf_handle;

    systf_data.type        = vpiSysTask;
    systf_data.sysfunctype = 0;
    systf_data.tfname      = "$traverse";
    systf_data.calltf      = vpit_TraverseDesign;
    systf_data.compiletf   = 0;
    systf_data.sizetf      = 0;
    systf_data.user_data   = 0;
    systf_handle = vpi_register_systf( &systf_data );
    vpi_free_object( systf_handle );
}

/*****************************************************************************
 *
 * Required structure for initializing VPI routines.
 *
 *****************************************************************************/

void (*vlog_startup_routines[])() = {
    vpit_RegisterTfs,
    0
};

/*****************************************************************************/
