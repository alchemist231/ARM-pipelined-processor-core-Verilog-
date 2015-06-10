
/*****************************************************************************
 * Copyright 1991-2013 Mentor Graphics Corporation
 *
 * All Rights Reserved.
 *
 * THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE PROPERTY OF 
 * MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.
 *
 * pli_test.c
 *
 * Simple PLI test.
 *
 * This code is written in a bottom-up manner.  Look at the bottom of the
 * file to find the entry point.
 *
 *****************************************************************************/

/*****************************************************************************
 * INCLUDES
 *****************************************************************************/

#include "acc_user.h"
#include "veriuser.h"

/*****************************************************************************
 * FUNCTION PROTOTYPES
 *****************************************************************************/

static void plit_DumpPortDetails( handle port_handle );
static void plit_DumpNetDetails( handle net_handle );

/*****************************************************************************
 * FUNCTION DEFINITIONS
 *****************************************************************************/

/*****************************************************************************
 *
 * plit_GetDelayModeStr()
 *
 * Get the string representation of the delay mode.
 *
 *****************************************************************************/

static char * plit_GetDelayModeStr( int delay_mode )
{
    char * tmpstr;

    switch ( delay_mode ) {
      case accDelayModeNone:     tmpstr = "accDelayModeNone";     break;
      case accDelayModePath:     tmpstr = "accDelayModePath";     break;
      case accDelayModeDistrib:  tmpstr = "accDelayModeDistrib";  break;
      case accDelayModeUnit:     tmpstr = "accDelayModeUnit";     break;
      case accDelayModeZero:     tmpstr = "accDelayModeZero";     break;
      case accDelayModeMTM:      tmpstr = "accDelayModeMTM";      break;
      default:                   tmpstr = "UNKNOWN";              break;
    }

    return tmpstr;
}

/*****************************************************************************
 *
 * plit_GetTimeUnitStr()
 *
 * Get the string representation of the time unit
 *
 *****************************************************************************/

static char * plit_GetTimeUnitStr( int time_unit )
{
    char * tmpstr;

    switch ( time_unit ) {
      case 2:    tmpstr = "100 s";    break;
      case 1:    tmpstr = "10 s";     break;
      case 0:    tmpstr = "1 s";      break;
      case -1:   tmpstr = "100 ms";   break;
      case -2:   tmpstr = "10 ms";    break;
      case -3:   tmpstr = "1 ms";     break;
      case -4:   tmpstr = "100 us";   break;
      case -5:   tmpstr = "10 us";    break;
      case -6:   tmpstr = "1 us";     break;
      case -7:   tmpstr = "100 ns";   break;
      case -8:   tmpstr = "10 ns";    break;
      case -9:   tmpstr = "1 ns";     break;
      case -10:  tmpstr = "100 ps";   break;
      case -11:  tmpstr = "10 ps";    break;
      case -12:  tmpstr = "1 ps";     break;
      case -13:  tmpstr = "100 fs";   break;
      case -14:  tmpstr = "10 fs";    break;
      case -15:  tmpstr = "1 fs";     break;
      default:   tmpstr = "UNKNOWN";  break;
    }

    return tmpstr;
}

/*****************************************************************************
 *
 * plit_GetDirectionStr()
 *
 * Get the string representation of the direction.
 *
 *****************************************************************************/

static char * plit_GetDirectionStr( int direction )
{
    char * tmpstr;

    switch ( direction ) {
      case accInput:   tmpstr = "accInput";    break;
      case accOutput:  tmpstr = "accOutput";   break;
      case accInout:   tmpstr = "accInout";    break;
      case accMixedIo: tmpstr = "accMixedIo";  break;
      default:         tmpstr = "UNKNOWN";     break;
    }

    return tmpstr;
}

/*****************************************************************************
 *
 * plit_DumpPortBitInfo()
 *
 * Print info about specified port's bits.
 *
 *****************************************************************************/

void plit_DumpPortBitInfo( handle port_handle )
{
    int    bitnum = 0;
    handle portbit_handle;

    for ( portbit_handle = acc_next_bit( port_handle, 0 ); portbit_handle;
         portbit_handle = acc_next_bit( port_handle, portbit_handle )) {
        bitnum++;
        io_printf( "\n  Port Bit #%d: ----------\n", bitnum );
        plit_DumpPortDetails( portbit_handle );
    }
}

/*****************************************************************************
 *
 * plit_DumpPortDetails()
 *
 * Print detailed info about specified port.
 *
 *****************************************************************************/

static void plit_DumpPortDetails( handle port_handle )
{
    int        is_vector;
    int        objfulltype;
    int        objtype;
    int        tmpint;
    handle     tmphandle;
    s_location loc;

    objtype     = acc_fetch_type( port_handle );
    objfulltype = acc_fetch_fulltype( port_handle );

    io_printf( "\n  Port name is %s.\n", acc_fetch_name( port_handle ));
    io_printf( "    Type          is %s (%d).\n",
              acc_fetch_type_str(objtype), objtype );
    io_printf( "    Full Type     is %s (%d).\n",
              acc_fetch_type_str(objfulltype), objfulltype );
    tmpint = acc_fetch_direction( port_handle );
    io_printf( "    Direction     is %s.\n", plit_GetDirectionStr(tmpint) );
    if ( objfulltype != accPortBit ) {
        io_printf( "    Port Index    is %d.\n",
                  acc_fetch_index( port_handle ));
    }
    acc_fetch_location( &loc, port_handle );
    io_printf( "    Line No       is %d.\n", loc.line_no );
    io_printf( "    File          is %s.\n", loc.filename );

    switch ( objfulltype ) {
      case accScalarPort:
      case accBitSelectPort:
      case accPortBit:
        is_vector = 0;
        io_printf( "    Port Size     is Scalar.\n" );
        break;
      case accPartSelectPort:
      case accVectorPort:
      case accConcatPort:
        is_vector = 1;
        io_printf( "    Port Size     is Vector of %d bits.\n",
                  acc_fetch_size( port_handle ));
        break;
    }

    tmphandle = acc_handle_parent( port_handle );
    io_printf( "    Parent        is %s of type %s.\n",
              acc_fetch_name( tmphandle ),
              acc_fetch_type_str( acc_fetch_fulltype( tmphandle )));

    if ( is_vector ) {
        plit_DumpPortBitInfo( port_handle );
    }
}

/*****************************************************************************
 *
 * plit_DumpPortInfo()
 *
 * Print info about specified module's ports.
 *
 *****************************************************************************/

static void plit_DumpPortInfo( handle mod_handle )
{
    handle port_handle;

    for ( port_handle = acc_next_port( mod_handle, 0 ); port_handle;
         port_handle = acc_next_port( mod_handle, port_handle ) ) {
        plit_DumpPortDetails( port_handle );
    }
}

/*****************************************************************************
 *
 * plit_DumpNetBitInfo()
 *
 * Print info about specified net's bits.
 *
 *****************************************************************************/

static void plit_DumpNetBitInfo( handle net_handle )
{
    int    bitnum = 0;
    handle netbit_handle;

    for ( netbit_handle = acc_next_bit( net_handle, 0 ); netbit_handle;
         netbit_handle = acc_next_bit( net_handle, netbit_handle )) {
        bitnum++;
        io_printf( "\n  Net Bit #%d: ----------\n", bitnum );
        plit_DumpNetDetails( netbit_handle );
    }
}

/*****************************************************************************
 *
 * plit_DumpNetDetails()
 *
 * Print detailed info about specified net.
 *
 *****************************************************************************/

static void plit_DumpNetDetails( handle net_handle )
{
    handle      tmphandle;
    int         lsb;
    int         msb;
    int         objfulltype;
    int         objtype;
    int         size;
    s_location  loc;

    objtype     = acc_fetch_type( net_handle );
    objfulltype = acc_fetch_fulltype( net_handle );

    io_printf( "\n  Net name is %s.\n", acc_fetch_name( net_handle ));
    io_printf( "    Type          is %s (%d).\n",
              acc_fetch_type_str(objtype), objtype );
    io_printf( "    Full Type     is %s (%d).\n",
              acc_fetch_type_str(objfulltype), objfulltype );
    acc_fetch_location( &loc, net_handle );
    io_printf( "    Line No       is %d.\n", loc.line_no );
    io_printf( "    File          is %s.\n", loc.filename );
    io_printf( "    Full Name     is %s.\n", acc_fetch_fullname( net_handle ));

    size = acc_fetch_size( net_handle );
    if ( size > 1 ) {
        io_printf( "    Net Size      is Vector of %d bits.\n", size );
        acc_fetch_range( net_handle, &msb, &lsb );
        io_printf( "    Left  Range   is %d.\n", msb );
        io_printf( "    Right Range   is %d.\n", lsb );
    } else {
        io_printf( "    Net Size      is Scalar.\n" );
    }

    tmphandle = acc_handle_parent( net_handle );
    io_printf( "    Parent        is %s of type %s.\n",
              acc_fetch_name( tmphandle ),
              acc_fetch_type_str( acc_fetch_fulltype( tmphandle )));

    if ( size > 1 ) {
        plit_DumpNetBitInfo( net_handle );
    }
}

/*****************************************************************************
 *
 * plit_DumpNetInfo()
 *
 * Print info about specified module's nets.
 *
 *****************************************************************************/

static void plit_DumpNetInfo( handle mod_handle )
{
    handle net_handle;

    for ( net_handle = acc_next_net( mod_handle, 0 ); net_handle;
         net_handle = acc_next_net( mod_handle, net_handle ) ) {
        plit_DumpNetDetails( net_handle );
    }
}

/*****************************************************************************
 *
 * plit_DumpScopeInfo()
 *
 * Print info about specified scope.
 *
 *****************************************************************************/

static void plit_DumpScopeInfo( handle mod_handle  )
{
    handle scope_handle;

    for ( scope_handle = acc_next_scope( mod_handle, 0 ); scope_handle;
         scope_handle = acc_next_scope( mod_handle, scope_handle ) ) {
        io_printf( "\nInternal scope is %s of type %s.\n",
                  acc_fetch_name( scope_handle ),
                  acc_fetch_type_str( acc_fetch_type( scope_handle )));
    }
}

/*****************************************************************************
 *
 * plit_DumpModuleInfo()
 *
 * Print info about specified module.
 *
 *****************************************************************************/

static void plit_DumpModuleInfo( handle mod_handle )
{
    int              objfulltype;
    int              objtype;
    int              tmpint;
    handle           child;
    handle           tmphandle;
    s_location       loc;
    s_timescale_info tscale;

    objtype     = acc_fetch_type( mod_handle );
    objfulltype = acc_fetch_fulltype( mod_handle );

    io_printf( "\nModule name is %s.\n", acc_fetch_name( mod_handle ) );
    io_printf( "  Type           is %s (%d).\n",
              acc_fetch_type_str(objtype), objtype );
    io_printf( "  Full Type      is %s (%d).\n",
              acc_fetch_type_str(objfulltype), objfulltype);
    io_printf( "  Cell Instance  is %s.\n",
              ( objfulltype == accCellInstance ) ? "TRUE" : "FALSE" );
    io_printf( "  Def Name       is %s.\n", acc_fetch_defname( mod_handle ) );
    tmpint = acc_fetch_delay_mode( mod_handle );
    io_printf( "  Delay Mode     is %d (%s).\n",
              tmpint, plit_GetDelayModeStr(tmpint) );
    acc_fetch_location( &loc, mod_handle );
    io_printf( "  File           is %s.\n", loc.filename );
    io_printf( "  Line No        is %d.\n", loc.line_no );
    io_printf( "  Full Name      is %s.\n", acc_fetch_fullname( mod_handle ));
    acc_fetch_timescale_info( mod_handle, &tscale );
    io_printf( "  Time Precision is %d (%s).\n",
              tscale.precision, plit_GetTimeUnitStr(tscale.precision) );
    io_printf( "  Time Unit      is %d (%s).\n",
              tscale.unit, plit_GetTimeUnitStr(tscale.unit) );
    io_printf( "  Top Module     is %s.\n",
              ( objfulltype == accTopModule ) ? "TRUE" : "FALSE" );
    if ( objfulltype != accTopModule ) {
        tmphandle = acc_handle_parent( mod_handle );
        io_printf( "  Parent         is %s of type %s.\n",
                  acc_fetch_name( tmphandle ),
                  acc_fetch_type_str( acc_fetch_fulltype( tmphandle )));
    }

    plit_DumpPortInfo( mod_handle );

    plit_DumpNetInfo( mod_handle );

    plit_DumpScopeInfo( mod_handle );

    for ( child = acc_next_child( mod_handle, 0 ); child;
          child = acc_next_child( mod_handle, child )) {
        plit_DumpModuleInfo( child );
    }
}

/*****************************************************************************
 *
 * plit_TraverseDesign()
 *
 * Traverse the design and print info about it.
 *
 *****************************************************************************/

int plit_TraverseDesign( char * user_data )
{
    handle mod_handle;

    acc_initialize();

    io_printf( "\n===========================\n" );
    io_printf( "Results of Design Traversal\n" );
    io_printf( "===========================\n" );

    for ( mod_handle = acc_next_topmod( 0 ); mod_handle;
          mod_handle = acc_next_topmod( mod_handle )) {
        plit_DumpModuleInfo( mod_handle );
    }

    acc_close();
    return 0;
}

/*****************************************************************************
 *
 * Required structure for initializing PLI routines.
 *
 *****************************************************************************/

s_tfcell veriusertfs[] =
{
    { usertask, 0, 0, 0, plit_TraverseDesign, 0, "$traverse", 0, 0, 0 },
    {0} /*** final entry must be 0 ***/
};

/*****************************************************************************/
