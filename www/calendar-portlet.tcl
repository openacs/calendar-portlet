#
#  Copyright (C) 2001, 2002 MIT
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

# www/calendar-portlet.tcl
ad_page_contract {
    The display logic for the calendar portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @cvs_id $Id$
} -properties {
    
}

# get stuff out of the config array
array set config $cf
set view $config(default_view)
set list_of_calendar_ids $config(calendar_id)

set scoped_p $config(scoped_p)

if {$scoped_p == "t"} {
    set show_calendar_name_p 1
} else {
    set show_calendar_name_p 0
}

if {[llength $list_of_calendar_ids] > 1} {
    set force_calendar_id [calendar_have_private_p -return_id 1 [ad_conn user_id]]
} else {
    set force_calendar_id [lindex $list_of_calendar_ids 0]
}

# permissions
set create_p [ad_permission_p $force_calendar_id cal_item_create]
set edit_p [ad_permission_p $force_calendar_id cal_item_edit]
set admin_p [ad_permission_p $force_calendar_id calendar_admin]

# set up some vars
set date [ns_queryget date]
if {[empty_string_p $date]} {
    set date [dt_sysdate]
}
set current_date $date
set date_format "YYYY-MM-DD HH24:MI"

set item_template "<a href=\${url_stub}cal-item-view?show_cal_nav=0&return_url=[ns_urlencode "../"]&action=edit&cal_item_id=\$item_id>\$item</a>"

if {$create_p} {
    set hour_template "<a href=calendar/cal-item-new?date=$current_date&start_time=\$start_time&end_time=\$end_time>\$hour</a>"
    set item_add_template "<a href=calendar/cal-item-new?start_time=&end_time=&julian_date=\$julian_date>ADD</a>"
} else {
    set hour_template "\$hour"
    set item_add_template ""
}

# big switch on the view var
if { $view == "day" } {
    
    set cal_stuff [calendar::one_day_display \
            -item_template $item_template \
            -hour_template $hour_template \
            -date $current_date -start_hour 7 -end_hour 22 \
            -calendar_id_list $list_of_calendar_ids \
            -url_stub_callback "calendar_portlet_display::get_url_stub" \
            -show_calendar_name_p $show_calendar_name_p]
    
}

if {$view == "week"} {
    set cal_stuff [calendar::one_week_display \
            -item_template $item_template \
            -date $current_date \
            -calendar_id_list $list_of_calendar_ids \
            -url_stub_callback "calendar_portlet_display::get_url_stub" \
            -show_calendar_name_p $show_calendar_name_p]
}

if {$view == "month"} {
    set cal_stuff [calendar::one_month_display \
            -item_template $item_template \
            -day_template "<a href=?julian_date=\$julian_date>\$day_number</a>" \
            -date $current_date \
            -item_add_template $item_add_template \
            -calendar_id_list $list_of_calendar_ids \
            -url_stub_callback "calendar_portlet_display::get_url_stub" \
            -show_calendar_name_p $show_calendar_name_p]
}

if {$view == "list"} {
    set cal_stuff [calendar::list_display \
            -item_template $item_template \
            -date $current_date \
            -calendar_id_list $list_of_calendar_ids \
            -url_stub_callback "calendar_portlet_display::get_url_stub" \
            -show_calendar_name_p $show_calendar_name_p]
}


ad_return_template
