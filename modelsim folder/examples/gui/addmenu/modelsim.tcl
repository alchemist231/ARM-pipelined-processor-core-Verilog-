#Copyright 1991-2013 Mentor Graphics Corporation
#
#All Rights Reserved.
#
#THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE PROPERTY OF 
#MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.

proc my_buttons {args} {

   add button "Run Long" "run 2 us"
   
   add button "Run Short" "run 2 ns"

   }

proc AddMyMenus {wname} {
    global myglobalvar
    set cmd1 "echo my_own_thing $wname"
    set cmd2 "echo my_to_upper $wname"
    set cmd3 "echo my_to_lower $wname"

#              WinName      Menu               MenuItem label         Command
#              ----------   ----               --------------------   -------
add_menu       $wname       usrMenu
add_menuitem   $wname       usrMenu             "Do My Own Thing..."   $cmd1
add_separator  $wname       usrMenu             ;#------------------   --------
add_submenu    $wname       usrMenu             changeCase
add_menuitem   $wname       usrMenu.changeCase  "To Upper"             $cmd2
add_menuitem   $wname       usrMenu.changeCase  "To Lower"             $cmd3
add_submenu    $wname       usrMenu             vars
add_menucb     $wname       usrMenu.vars        "Feature One"          -variable myglobalvar -onvalue 1 -offvalue 0 -indicatoron 1
}

lappend PrefMain(user_hook) AddMyMenus my_buttons

