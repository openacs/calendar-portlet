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

if {[llength $list_of_calendar_ids] > 1} {
    set force_calendar_id [calendar_have_private_p -return_id 1 [ad_conn user_id]]
} else {
    set force_calendar_id [lindex $list_of_calendar_ids 0]
}

# set up some vars
set date [ns_queryget date]
if {[empty_string_p $date]} {
    set date [dt_sysdate]
}
set current_date $date
set date_format "YYYY-MM-DD HH24:MI"

# big switch on the view var
if { $view == "day" } {
    
    set cal_stuff [calendar::one_day_display \
            -item_template {<a href=calendar/?show_cal_nav=0&return_url=../&action=edit&cal_item_id=$item_id>$item</a>} \
            -hour_template "<a href=calendar/?show_cal_nav=0&date=$current_date&action=add&force_calendar_id=$force_calendar_id&return_url=../&start_time=\$start_time&end_time=\$end_time>\$hour</a>" \
            -date $current_date -start_hour 7 -end_hour 22 \
            -calendar_id_list $list_of_calendar_ids]
    
}

if {$view == "week"} {
    set cal_stuff [calendar::one_week_display \
            -item_template {<a href=calendar/?show_cal_nav=0&return_url=../&action=edit&cal_item_id=$item_id>$item</a>} \
            -date $current_date \
            -calendar_id_list $list_of_calendar_ids]
}

if {$view == "month"} {
    set cal_stuff [calendar::one_month_display \
            -item_template {<a href=calendar/?show_cal_nav=0&return_url=../&action=edit&cal_item_id=$item_id>$item</a>} \
            -day_template "<a href=?julian_date=\$julian_date>\$day_number</a>" \
            -date $current_date \
            -item_add_template "<a href=calendar/?show_cal_nav=0&action=add&start_time=&end_time=&force_calendar_id=$force_calendar_id&julian_date=\$julian_date>ADD</a>" \
            -calendar_id_list $list_of_calendar_ids]
}

if {$view == "list"} {
    set cal_stuff [calendar::list_display \
            -item_template {<a href=calendar/?show_cal_nav=0&return_url=../&action=edit&cal_item_id=$item_id>$item</a>} \
            -date $current_date \
            -calendar_id_list $list_of_calendar_ids]
}


ad_return_template
