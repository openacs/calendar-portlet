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

if {$create_p} {
    set item_template "<a href=calendar/?show_cal_nav=0&return_url=[ns_urlencode "../"]&action=edit&cal_item_id=\$item_id>\$item</a>"
} else {
    set item_template "\$item"
}

if {$create_p} {
    set hour_template "<a href=calendar/?show_cal_nav=0&date=$current_date&force_calendar_id=$force_calendar_id&action=add&return_url=[ns_urlencode "../"]&start_time=\$start_time&end_time=\$end_time>\$hour</a>"
    set item_add_template "<a href=calendar/?return_url=../&show_cal_nav=0&action=add&force_calendar_id=$force_calendar_id&start_time=&end_time=&julian_date=\$julian_date>ADD</a>"
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
            -calendar_id_list $list_of_calendar_ids]
    
}

if {$view == "week"} {
    set cal_stuff [calendar::one_week_display \
            -item_template $item_template \
            -date $current_date \
            -calendar_id_list $list_of_calendar_ids]
}

if {$view == "month"} {
    set cal_stuff [calendar::one_month_display \
            -item_template $item_template \
            -day_template "<a href=?julian_date=\$julian_date>\$day_number</a>" \
            -date $current_date \
            -item_add_template $item_add_template \
            -calendar_id_list $list_of_calendar_ids]
}

if {$view == "list"} {
    set cal_stuff [calendar::list_display \
            -item_template {<a href=calendar/?show_cal_nav=0&return_url=../&action=edit&cal_item_id=$item_id>$item</a>} \
            -date $current_date \
            -calendar_id_list $list_of_calendar_ids]
}


ad_return_template
