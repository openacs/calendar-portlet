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

# ad_return_complaint 1 "$cf"

# set up some vars
set date [ns_queryget date]
if {[empty_string_p $date]} {
    set date [dt_sysdate]
}
set current_date $date
set date_format "YYYY-MM-DD HH24:MI"

# big switch on the view var
if { $view == "day" } {
    
    set cal_stuff [calendar::one_day_display -date $current_date]
    
}


ad_return_template
