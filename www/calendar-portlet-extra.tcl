    
## aks - fold this into sql/template?
##
##    while {$i < $num_hour_rows} {
##        set filled_cell_count 0
##        
##        # making hours before 10 looks prettier
##        if {$i < 10} { set cal_hour "0$i" } else { set cal_hour "$i" }
##        
##        # am or pm determination logic
##    if {$i < 12} {
##        if {$i == 0} {
##            set time "12:00 am"
##        } else {
##            set time "$cal_hour:00 am"
##        }
##    } else {
##        if {$i == 12} {
##            set time "12:00 pm"
##        } else {
##            set fm_hour [expr $i - 12]
##            if {$fm_hour < 10} {
##                set fm_hour "0$fm_hour"
##            } 
##            set time "$fm_hour:00 pm"
##        }    
##    }
##    
##    set cal_item_index [ns_set find $set_id $cal_hour]    
##    
##    append row_html "
##    <tr>
##    <td valign=top nowrap $bgcolor_html width=\"10%\">
##    <a href=calendar/?date=$date&view=$view&action=add&start_time=$i:00&end_time=[expr $i+1]:00> $time </a>
##    </td>
##    <td valign=top border=1>"
##    
##    if {$cal_item_index == -1} {
##        append row_html "&nbsp;"
##    }
##    
##    while {$cal_item_index > -1} {		
##        append row_html "[ns_set value $set_id $cal_item_index]"
##        ns_set delete $set_id $cal_item_index
##        set cal_item_index [ns_set find $set_id $cal_hour]     
##    }
##    
##    append row_html "</td>
##    </tr>\n"
##    
##    incr i
##} 
### end while 
##
##append row_html "</table>"
##


}

# end view "day"

###
#######
###
#### set up the multirow datasource using the db_multirow proc and 1 id
###set my_folder_id [lindex $list_of_folder_ids 0]
###
###db_multirow -local foo select_files_and_folders {} {
###
###    # we can set array vars for this row
###    set foo(url) [dotlrn_community::get_url_from_package_id \
###        -package_id [db_string select_package_id {}]]       
###}
###
###foreach my_folder_id [lrange $list_of_folder_ids 1 end] {  
###
###    # use the append switch to add rows to the datasource
###    db_multirow -local -append foo select_files_and_folders {} {        
###        set foo(url) [dotlrn_community::get_url_from_package_id \
###            -package_id [db_string select_package_id {}]]        
###    }
###}
###
###ad_return_template 
###
###
#######
###
###
###if { $view == "day" } {
###
###    foreach calendar_id $list_of_calendar_ids {
###
###        set calendar_name ""
###        # [calendar_get_name $calendar_id]
###
###        ns_log notice "aks11: the current calendar_id os $calendar_id, $calendar_name list is $list_of_calendar_ids, cf $cf"
###        
###    # big non-ported query, i'm bad
###    db_foreach get_day_items "
###    select   to_char(start_date, 'HH24') as start_hour,
###    to_char(start_date, 'HH24:MI') as pretty_start_date,
###    to_char(end_date, 'HH24:MI') as pretty_end_date,
###    nvl(e.name, a.name) as name,
###    e.event_id as item_id
###    from     acs_activities a,
###    acs_events e,
###    timespans s,
###    time_intervals t
###    where    e.timespan_id = s.timespan_id
###    and      s.interval_id = t.interval_id
###    and      e.activity_id = a.activity_id
###    and      start_date between
###    to_date(:current_date,:date_format) and
###    to_date(:current_date,:date_format) + (24 - 1/3600)/24
###    and      e.event_id
###    in       (
###    select  cal_item_id
###    from    cal_items
###    where   on_which_calendar = :calendar_id
###    )" {
###        ns_set put $set_id $start_hour \
###                "<a href=calendar?date=$date&action=edit&cal_item_id=$item_id>
###        $pretty_start_date - $pretty_end_date $name ($calendar_name)
###        </a><br>"
###    } 
###
###}   
###
#### shaded_p support version 1
###    
###    set row_html "
###<b><font face=\"verdana,arial,helvetica\" size=+1>$calendar_name</font></b>
###<p>
###<br>
###<table cellpadding=2 cellspacing=0 border=1>
###<tr>
###<td width=90><b>Time</b></td><td><b>Title</b></td>
###</tr>\n"
###    
###    while {$i < $num_hour_rows} {
###        set filled_cell_count 0
###        
###        # making hours before 10 looks prettier
###        if {$i < 10} { set cal_hour "0$i" } else { set cal_hour "$i" }
###        
###        # am or pm determination logic
###    if {$i < 12} {
###        if {$i == 0} {
###            set time "12:00 am"
###        } else {
###            set time "$cal_hour:00 am"
###        }
###    } else {
###        if {$i == 12} {
###            set time "12:00 pm"
###        } else {
###            set fm_hour [expr $i - 12]
###            if {$fm_hour < 10} {
###                set fm_hour "0$fm_hour"
###            } 
###            set time "$fm_hour:00 pm"
###        }    
###    }
###    
###    set cal_item_index [ns_set find $set_id $cal_hour]    
###    
###    append row_html "
###    <tr>
###    <td valign=top nowrap $bgcolor_html width=\"10%\">
###    <a href=calendar/?date=$date&view=$view&action=add&start_time=$i:00&end_time=[expr $i+1]:00> $time </a>
###    </td>
###    <td valign=top border=1>"
###    
###    if {$cal_item_index == -1} {
###        append row_html "&nbsp;"
###    }
###    
###    while {$cal_item_index > -1} {		
###        append row_html "[ns_set value $set_id $cal_item_index]"
###        ns_set delete $set_id $cal_item_index
###        set cal_item_index [ns_set find $set_id $cal_hour]     
###    }
###    
###    append row_html "</td>
###    </tr>\n"
###    
###    incr i
###} 
###
###append row_html "</table>"
###
#### aks - week support
###seif { $view == "week" } {
###
###db_1row get_weekday_info "
###select   to_char(to_date(:current_date, 'yyyy-mm-dd'), 'D') 
###as       day_of_the_week,
###to_char(next_day(to_date(:current_date, 'yyyy-mm-dd')-7, 'SUNDAY'))
###as       sunday_of_the_week,
###to_char(next_day(to_date(:current_date, 'yyyy-mm-dd'), 'Saturday'))
###as       saturday_of_the_week
###from     dual
###"
###
###set mlist ""
###set set_id [ns_set new week_items]
###
###db_foreach get_day_items {
###    select   to_char(start_date, 'J') as start_date,
###    to_char(start_date, 'HH24:MI') as pretty_start_date,
###    to_char(end_date, 'HH24:MI') as pretty_end_date,
###    nvl(e.name, a.name) as name,
###    e.event_id as item_id
###    from     acs_activities a,
###    acs_events e,
###    timespans s,
###    time_intervals t
###    where    e.timespan_id = s.timespan_id
###    and      s.interval_id = t.interval_id
###    and      e.activity_id = a.activity_id
###    and      start_date between
###    to_date(:sunday_of_the_week,'YYYY-MM-DD') and
###    to_date(:saturday_of_the_week,'YYYY-MM-DD')
###    and      e.event_id
###    in       (
###    select  cal_item_id
###    from    cal_items
###    where   on_which_calendar = :calendar_id
###    )
###} {
###    ns_set put $set_id  $start_date \
###            "<li> <a href=calendar?action=edit&cal_item_id=$item_id>
###    $pretty_start_date - $pretty_end_date $name ($calendar_name)
###    </a>"
###    append items "<li> <a href=calendar?action=edit&cal_item_id=$item_id>
###    $pretty_start_date - $pretty_end_date $name ($calendar_name)
###    </a><br>"
###    }
###    
###    set num_hour_rows 7
###    set i 0
###    
###    set bgcolor_html "bgcolor=DCDCDC"
###    
###    set row_html "
###    <table  cellpadding=2 cellspacing=0 border=1 width=350>"
###    
###    while {$i < $num_hour_rows} {
###        
###        set sql "
###        select  
###        to_char(next_day(to_date(:current_date, 'yyyy-mm-dd')-7,
###        'SUNDAY')+$i, 'DAY') 
###        as weekday,
###        to_char(next_day(to_date(:current_date, 
###        'yyyy-mm-dd')-7, 'SUNDAY')+$i, 'YYYY-MM-DD') 
###        as pretty_date,
###        to_char(next_day(to_date(:current_date, 'yyyy-mm-dd')-7, 
###        'SUNDAY')+$i, 'J') 
###        as start_date
###        from dual
###        "
###        db_1row week_data $sql
###        append row_html "
###        <tr >
###        <td $bgcolor_html> <b>$weekday </b> 
###        <a href=\"calendar?date=[ns_urlencode $pretty_date]&view=$view&action=add\">$pretty_date</a> 
###        </td>
###        </tr>
###        
###        <tr>
###        <td>"
###
###        set cal_item_index [ns_set find $set_id $start_date]     
###
###        if {$cal_item_index == -1} { append row_html "&nbsp;" }
###
###        while {$cal_item_index > -1} {
###            
###            append row_html [ns_set value $set_id $cal_item_index]
###            
###            ns_set delete $set_id $cal_item_index
###            set cal_item_index [ns_set find $set_id $start_date]     
###        }
###        
###        append row_html "  
###        </td>
###        </tr>
###        "
###        
###        incr i
###    }
###
###    append row_html "</table>"
###} elseif { $view == "month" } {
###    
###    set set_id [ns_set new month_items]
###    
###    db_foreach get_monthly_items "
###    select   to_char(start_date, 'j') as start_date,
###    nvl(e.name, a.name) as name,
###    nvl(e.description, a.description) as description,
###    e.event_id as item_id
###    from     acs_activities a,
###    acs_events e,
###    timespans s,
###    time_intervals t
###    where    e.timespan_id = s.timespan_id
###    and      s.interval_id = t.interval_id
###    and      e.activity_id = a.activity_id
###    and      e.event_id
###    in       (
###    select  cal_item_id
###    from    cal_items
###    where   on_which_calendar = :calendar_id
###    ) " {
###        ns_set put $set_id  $start_date \
###                "<a href=calendar?action=edit&cal_item_id=$item_id>
###        $name ($calendar_name)
###        </a><br>"
###    }
###
###    set row_html \
###            [dt_widget_month -header_text_size "+0" \
###            -calendar_details $set_id -date $date]
###    
###} elseif { $view == "list"} {
###
###    set items ""
###
###    db_foreach get_day_items "
###    select   to_char(start_date, 'j') as start_date,
###    to_char(start_date, 'HH24:MI') as pretty_start_date,
###    to_char(end_date, 'HH24:MI') as pretty_end_date,
###    nvl(e.name, a.name) as name,
###    e.event_id as item_id
###    from     acs_activities a,
###    acs_events e,
###    timespans s, 
###    time_intervals t
###    where    e.timespan_id = s.timespan_id
###    and      s.interval_id = t.interval_id
###    and      e.activity_id = a.activity_id
###    and      start_date between
###    to_date(:current_date,:date_format) and
###    to_date(:current_date,:date_format) + (24 - 1/3600)/24
###    and      e.event_id
###    in       (
###    select    cal_item_id
###    from      cal_items  
###    where     on_which_calendar = :calendar_id
###    )" {
###        ns_set put $set_id  $start_date \
###                "<a href=calendar?action=edit&cal_item_id=$item_id>
###        $pretty_start_date - $pretty_end_date $name ($calendar_name)
###        </a><br>"
###        append items "<li> <a href=calendar?action=edit&cal_item_id=$item_id>
###        $pretty_start_date - $pretty_end_date $name ($calendar_name)
###        </a><br>"
###    }
###
###    set date [dt_systime]
###
###    set row_html "For $date: $items"
###}
###
###
###set template "$row_html"		    
### 
