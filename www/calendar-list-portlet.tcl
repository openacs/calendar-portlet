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
} {
    {view ""}
    {page_num ""}
    {date ""}
    {julian_date ""}
    {period_days:optional}
    {sort_by ""}
} -properties {
    
}  -validate {
    valid_date -requires { date } {
        if {![string equal $date ""]} {
            if {[catch {set date [clock format [clock scan $date] -format "%Y-%m-%d"]} err]} {
                ad_complain "Your input was not valid. It has to be in the form YYYYMMDD."
            }
        }
    }
}

set calendar_url [ad_conn package_url]calendar/

# get stuff out of the config array
array set config $cf
if {[empty_string_p $view]} {
    set view $config(default_view)
}
set list_of_calendar_ids $config(calendar_id)

# Set the first list entry to calendar_id. Will not be used if under
# dotlrn. Otherwise the list will actually contain only one calendar_id
# (the first one, though)
set calendar_id [lindex $list_of_calendar_ids 0]
# Get the package_id depending on which calender_id was set
db_0or1row select_calendar_package_id {select package_id from calendars where calendar_id=:calendar_id}

if { ![info exists period_days] } {
    set period_days [parameter::get -package_id $package_id -parameter ListView_DefaultPeriodDays -default 31]
}

set scoped_p $config(scoped_p)
if {$scoped_p == "t"} {
    set show_calendar_name_p 1
} else {
    set show_calendar_name_p 0
}

if {[llength $list_of_calendar_ids] > 1} {
    set force_calendar_id [calendar::have_private_p -return_id 1 -calendar_id_list $list_of_calendar_ids -party_id [ad_conn user_id]]
} else {
    set force_calendar_id [lindex $list_of_calendar_ids 0]
}

# set up some vars
if {[empty_string_p $date]} {
    if {[empty_string_p $julian_date]} {
        set date [dt_sysdate]
    } else {
        set date [db_string select_from_julian "select to_date(:julian_date ,'J') from dual"]
    }
}

set current_date $date
set date_format "YYYY-MM-DD HH24:MI"
set return_url "[ns_conn url]?[ns_conn query]"

# List view only
set sort_by [ns_queryget sort_by]

set start_date [ns_fmttime [expr [ns_time]] "%Y-%m-%d 00:00"]
set end_date [ns_fmttime [expr {[ns_time] + 60*60*24*$period_days}] "%Y-%m-%d 00:00"]

# Stylesheet
template::head::add_css -href "/resources/calendar/calendar.css"
template::head::add_css -alternate -href "/resources/calendar/calendar-hc.css" -title "highContrast"

ad_return_template
