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

	array set config $cf	

	# things we need in the config 
	# community_id and folder_id

	# get user_id from the conn at this point
	set user_id [ad_conn user_id]


	set date [dt_sysdate]
	set current_date $date
	set date_format "YYYY-MM-DD HH24:MI"

	# a big-time query from file-storage
	set query "
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
         where   on_which_calendar = $config(community_calendar_id)
         )
"
	
	set data ""
	set rowcount 0

	db_foreach select_files_and_folders $query {
	    append data "<tr><td>$name</td><td>$path</td><td>$content_size</td><td>$type</td><td>$last_modified</td>"
	    incr rowcount
	} 

	set template "
	<table border=1 cellpadding=2 cellspacing=2>
	<tr>
	<td bgcolor=#cccccc>Name</td>
	<td bgcolor=#cccccc>Action</td>
	<td bgcolor=#cccccc>Size (bytes)</td>
	<td bgcolor=#cccccc>Type</td>
	<td bgcolor=#cccccc>Modified</td>
	</tr>
	$data
	</table>"

	if {!$rowcount} {
	    set template "<i>No items in this folder</i><P><a href=\"file-storage\">more...</a>"
	}

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

 

