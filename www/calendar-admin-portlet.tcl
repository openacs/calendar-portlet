# www/calendar-portlet.tcl
ad_page_contract {
    The display logic for the calendar admin portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @author Ben Adida (ben@openforce.net)
    @cvs_id $Id$
} -properties {
    
}

# get stuff out of the config array
array set config $cf
set view $config(default_view)
set list_of_calendar_ids $config(calendar_id)

if {[llength $list_of_calendar_ids] > 1} {
    return -code error "shouldn't be more than one calendar in admin!"
}

set calendar_id [lindex $list_of_calendar_ids 0]

set url "calendar/"

ad_return_template
