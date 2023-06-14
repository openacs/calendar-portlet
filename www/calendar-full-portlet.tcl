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

# www/calendar-full-portlet.tcl
ad_page_contract {
    The display logic for the calendar portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @cvs-id $Id$
} {
    {view ""}
    {page_num:naturalnum 0}
    {date ""}
    {period_days:naturalnum,optional}
    {julian_date ""}
} -properties {

} -validate {
    valid_date -requires { date } {
        if {$date ne "" } {
            if {[catch {set date [clock format [clock scan $date] -format "%Y-%m-%d"]} err]} {
                ad_complain "Your input ($date) was not valid. It has to be in the form YYYY-MM-DD."
            }
        }
    }
}

# get stuff out of the config array
array set config $cf
if {$view eq ""} {
    set view $config(default_view)
}
set list_of_calendar_ids $config(calendar_id)

set ad_conn_url [ad_conn url]
set calendar_url [ad_conn package_url]calendar/

set scoped_p $config(scoped_p)
if {$scoped_p == "t"} {
    set show_calendar_name_p 1
} else {
    set show_calendar_name_p 0
}

# Styles for calendar
template::head::add_css -href "/resources/calendar/calendar.css"
template::head::add_css -alternate -href "/resources/calendar/calendar-hc.css" -title "highContrast"

# set the period_days for calendar's list view, therefore, we need
# to check which instance of calendar is currently displayed
if { [namespace which ::dotlrn_community::get_community_id] ne "" } {
    set community_id [dotlrn_community::get_community_id -url [ad_conn url]]
} else {
    set community_id ""
}

set calendar_id [lindex $list_of_calendar_ids 0]

#
# Get the package_id of the calendar_id
#
if {$calendar_id == 0} {

    #
    # A calendar_id 0 may happen when showcasing the portal layout in
    # "Portal Templates". This will be a dummy calendar portlet, so we
    # deactivate the UI by disabling all links and buttons.
    #
    set package_id 0
    set period_days [parameter::get -package_id $package_id -parameter ListView_DefaultPeriodDays -default 31]
    template::add_body_handler -event load -script {
        // Remove event listeners set on the mini-calendar
        for (const day of document.querySelectorAll('[id^="mini-calendar-"]')) {
            day.replaceWith(day.cloneNode(true));
        }
        // Disable all links
        for (const link of document.querySelectorAll('[name="calendar"] ~ * a')) {
            link.addEventListener('click', function (e) {
                link.removeAttribute('href');
            });
        }
        // Disable all buttons
        for (const input of document.querySelectorAll('[name="calendar"] ~ * input, [name="calendar"] ~ * button')) {
            input.disabled = true;
        }
    }

} elseif {![db_0or1row select_calendar_package_id {
    select package_id from calendars
     where calendar_id = :calendar_id
}]} {

    #
    # Could not find the supplied calendar_id, we complain in this
    # case.
    #
    ad_log error "Invalid calendar_id in portlet configuration (calendar_id '$calendar_id')"
    ad_return_complaint 1 "Invalid calendar_id in portlet configuration (calendar_id '$calendar_id')"
    ad_script_abort
}

if { ![info exists period_days] } {
    if { [info exists community_id] && $community_id ne "" } {
        set period_days [parameter::get -package_id $package_id -parameter ListView_DefaultPeriodDays -default 31]
    } else {
        foreach calendar $list_of_calendar_ids {
            # returns 1 if calendar_id is user's personal calendar
            if { [calendar::personal_p -calendar_id $calendar] } {
                db_0or1row select_calendar_package_id {select package_id from calendars where calendar_id=:calendar}
                set period_days [parameter::get -package_id $package_id -parameter ListView_DefaultPeriodDays -default 31]
                break
            }
        }
    }
}

if {[llength $list_of_calendar_ids] > 1} {
    set force_calendar_id [calendar::have_private_p -return_id 1 -calendar_id_list $list_of_calendar_ids -party_id [ad_conn user_id]]
} else {
    set force_calendar_id [lindex $list_of_calendar_ids 0]
}

# permissions
set create_p [permission::permission_p -object_id $force_calendar_id -privilege cal_item_create]
set edit_p [permission::permission_p -object_id $force_calendar_id -privilege cal_item_edit]
set admin_p [permission::permission_p -object_id $force_calendar_id -privilege calendar_admin]

if {$view eq ""} {
    set view $config(default_view)
}

# set up some vars
if {$date eq ""} {
    if {$julian_date eq ""} {
        set date [dt_sysdate]
    } else {
        set date [db_string select_from_julian "select to_date(:julian_date ,'J') from dual"]
    }
}

# global variables
set current_date $date
set date_format "YYYY-MM-DD HH24:MI"
set return_url "[ns_conn url]?[ns_conn query]"

set add_item_url [export_vars -base "calendar/cal-item-new" {{date $current_date} {time_p 1} return_url}]

if {$view eq "list"} {
    set sort_by [ns_queryget sort_by]


    set start_date [ns_fmttime [expr [ns_time]] "%Y-%m-%d 00:00"]
    set end_date [ns_fmttime [expr {[ns_time] + 60*60*24*$period_days}] "%Y-%m-%d 00:00"]

}

set export [ns_queryget export]

if { [lsearch [list csv vcalendar] $export] != -1 } {
    set user_id [ad_conn user_id]
    set package_id [ad_conn package_id]
    if {$view eq "list"} {
        calendar::export::$export -calendar_id_list $list_of_calendar_ids -view $view -date $date -start_date $start_date -end_date $end_date $user_id $package_id
    } else {
        calendar::export::$export -calendar_id_list $list_of_calendar_ids -view $view -date $date $user_id $package_id
    }
    ad_script_abort
} else {
    ad_return_template
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
