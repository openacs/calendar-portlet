# calendar-portlet/tcl/calendar-portlet-procs.tcl

ad_library {

Procedures to support the calendar portlet

Copyright Openforce, Inc.
Licensed under GNU GPL v2 

@creation-date Oct 26 2001
@author arjun@openforce.net 
@cvs-id $Id$

}

namespace eval calendar_portlet {

    ad_proc -private my_name {
    } {
    return "calendar-portlet"
    }

    ad_proc -public get_pretty_name {
    } {
	return "Calendar"
    }

    ad_proc -public add_self_to_page { 
	page_id 
	calendar_id
    } {
	Adds a calendar PE to the given page with the community_id.
    
	@return element_id The new element's id
	@param page_id The page to add self to
	@param community_id The community with the folder
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
	# Tell portal to add this element to the page
	set element_id [portal::add_element $page_id [my_name]]
	
	# The default param "calendar_id" must be configured
	set key "calendar_id"
	portal::set_element_param $element_id $key $calendar_id

	return $element_id
    }

    ad_proc -public show { 
	 cf 
    } {
	 Display the PE
    
	 @return HTML string
	 @param cf A config array
	 @author arjun@openforce.net
	 @creation-date Sept 2001
    } {

	# carries "calendar_id"
	array set config $cf	
	set calendar_id $config(calendar_id)

	set date [dt_sysdate]
	set current_date $date
	set date_format "YYYY-MM-DD HH24:MI"
	set num_hour_rows 24
	set i 0
	set bgcolor_html "border=1 color=blue"
	set view day


	# AKS: code from calendar/www/cal-dayview.tcl
	# ---

	set mlist ""
	set set_id [ns_set new day_items]

	# otherwise, get the calendar_name for the give_id
	set calendar_name [calendar_get_name $calendar_id]
	
	# big non-ported query, i'm bad
	db_foreach get_day_items "
	select   to_char(start_date, 'HH24') as start_hour,
	to_char(start_date, 'HH24:MI') as pretty_start_date,
	to_char(end_date, 'HH24:MI') as pretty_end_date,
	nvl(e.name, a.name) as name,
	e.event_id as item_id
	from     acs_activities a,
	acs_events e,
	timespans s,
	time_intervals t
	where    e.timespan_id = s.timespan_id
	and      s.interval_id = t.interval_id
	and      e.activity_id = a.activity_id
	and      start_date between
	to_date(:current_date,:date_format) and
	to_date(:current_date,:date_format) + (24 - 1/3600)/24
	and      e.event_id
	in       (
	select  cal_item_id
	from    cal_items
	where   on_which_calendar = :calendar_id
	)" {
	    ns_set put $set_id $start_hour \
		    "<a href=calendar/?date=$date&action=edit&cal_item_id=$item_id>
	    $pretty_start_date - $pretty_end_date $name ($calendar_name)
	    </a><br>"
	}  

	
	set row_html "
	<table cellpadding=2 cellspacing=0 border=1>
	<tr><td width=90><b>Time</b></td><td><b>Title</b></td></tr>"
	
	while {$i < $num_hour_rows} {
	    set filled_cell_count 0
	    	    
	    # making hours before 10 looks prettier
	    if {$i < 10} { set cal_hour "0$i" } else { set cal_hour "$i" }
	    
	    # am or pm determination logic
	    if {$i < 12} {
		if {$i == 0} {
	    set time "12:00 am"
		} else {
		    set time "$cal_hour:00 am"
		}
	    } else {
		if {$i == 12} {
	    set time "12:00 pm"
		} else {
		    set fm_hour [expr $i - 12]
		    if {$fm_hour < 10} {
			set fm_hour "0$fm_hour"
		    } 
		    set time "$fm_hour:00 pm"
		}    
	    }
	    
	    set cal_item_index [ns_set find $set_id $cal_hour]    
	    
	    append row_html "
	    <tr>
	    <td valign=top nowrap $bgcolor_html width=10%>
	    <a href=calendar/?date=$date&view=$view&action=add&start_time=$i:00&end_time=[expr $i+1]:00> $time </a>
	    </td>
	    
	    <td valign=top border=1>"
	    
	    if {$cal_item_index == -1} {
		append row_html "&nbsp;"
	    }
	    
	    while {$cal_item_index > -1} {		
		append row_html "[ns_set value $set_id $cal_item_index]"
		ns_set delete $set_id $cal_item_index
		set cal_item_index [ns_set find $set_id $cal_hour]     
	    }
    
	    append row_html "</td></tr>"
	    
	    incr i
	} 
	
	append row_html "</table>"


	# ---
	# AKS: end lots of code from calendar/www/cal-dayview.tcl	
	
	set template "
	<table border=1 cellpadding=2 cellspacing=2>
	$row_html
	</table>"
	
	
	set code [template::adp_compile -string $template]
	
	set output [template::adp_eval code]
	return $output
	
    }
    
    ad_proc -public remove_self_from_page { 
	portal_id 
	community_id 
    } {
	  Removes a calendar PE from the given page 
    
	  @param page_id The page to remove self from
	  @param community_id
	  @author arjun@openforce.net
	  @creation-date Sept 2001
    } {

	# get the element IDs (could be more than one!)
	set element_ids [portal::get_element_ids_by_ds $portal_id [my_name]]

	# remove all elements
	db_transaction {
	    foreach element_id $element_ids {

		set calendar_id \
			[portal::get_element_param $element_id "calendar_id"]
		
		# don't delete the public calendar!
		if {[calendar_public_p $calendar_id] == "f"} {
		    # delete the personal calendar associated with this element
		    db_exec_plsql delete_calendar {
			begin
			calendar.delete(
			calendar_id   => :calendar_id
			);	
			end;
		    }
		}
		# get rid of this portal element
		portal::remove_element $element_id
	    }
	}
    }
}

 

