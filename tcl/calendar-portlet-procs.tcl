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

    ad_proc -private my_package_key {
    } {
        return "calendar-portlet"
    }

    ad_proc -private my_name {
    } {
        return "calendar_portlet"
    }

    ad_proc -public get_pretty_name {
    } {
	return [ad_parameter \
                -package_id [apm_package_id_from_key [my_package_key]] \
                "pretty_name"]
    }

    ad_proc -public link {
    } {
	return "calendar"
    }

    ad_proc -public add_self_to_page { 
	portal_id 
	calendar_id
    } {
	Adds a calendar PE to the given page with the community_id.
    
	@return element_id The new element's id
	@param portal_id The page to add self to
	@param calendar_id The new calendar_id to add
	@author arjun@openforce.net
	@creation-date Sept 2001
    } {
        return [portal::add_element_or_append_id -portal_id $portal_id \
                -portlet_name [my_name] \
                -value_id $calendar_id \
                -key calendar_id]
    }

    ad_proc -public remove_self_from_page {
	portal_id
	community_id
    } {
	  Removes a calendar PE from the given page
    
	  @param portal_id The page to remove self from
	  @param community_id
	  @author arjun@openforce.net
	  @creation-date Sept 2001
    } {
        # it's more simple not to use portal::remove_element_or_remove_id here

	# get the element IDs (could be more than one!)
	set element_ids [portal::get_element_ids_by_ds $portal_id \
		[my_name]]

	# remove all elements
	db_transaction {
	    foreach element_id $element_ids {

		set calendar_id \
			[portal::get_element_param $element_id "calendar_id"]
		
		set g_cal_id \
			[portal::get_element_param $element_id "group_calendar_id"]

		# don't delete the public calendar!
		if {[calendar_public_p $calendar_id] == "f"} {

                ns_log notice "aks15 in calendar_portlet remove_self_from_page $calendar_id/$element_id/$g_cal_id"

		    # delete the personal calendar associated with this element
		    db_exec_plsql delete_calendar {
			begin
			calendar.delete(
			calendar_id => :calendar_id
			);
			end;
		    }
		}
		# get rid of this portal element
		portal::remove_element $element_id
	    }
	}

    }


    ad_proc -public make_self_available {
 	page_id
    } {
 	Wrapper for the portal:: proc
 	
 	@param page_id
 	@author arjun@openforce.net
 	@creation-date Nov 2001
    } {
 	portal::make_datasource_available \
 		$page_id [portal::get_datasource_id [my_name]]
    }

    ad_proc -public make_self_unavailable {
	page_id
    } {
	Wrapper for the portal:: proc
	
	@param page_id
	@author arjun@openforce.net
	@creation-date Nov 2001
    } {
	portal::make_datasource_unavailable \
		$page_id [portal::get_datasource_id [my_name]]
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
        # no return call required with the helper proc
        portal::show_proc_helper \
                -package_key [my_package_key] \
                -config_list $cf
    }

    ad_proc -public edit { 
	element_id
    } {
	 Display the PE's edit page
    
	 @return HTML string
	 @param cf A config array
	 @author arjun@openforce.net
	 @creation-date Nov 2001
    } {
	
	set calendar_id [portal::get_element_param $element_id "calendar_id"]
	set current_view [portal::get_element_param $element_id "default_view"]
	
	switch $current_view {
	    "day" {
		set html "Set default view to:<P>
		<input type=hidden name=element_id value=$element_id>
		<input type=hidden name=key value=default_view>
		<input type=radio name=value value=day checked>day</LABEL>
		<input type=radio name=value value=week>week</LABEL>
		<input type=radio name=value value=month>month</LABEL>
		<input type=radio name=value value=list>list</LABEL>
		<input type=submit value=\"Update\">"
	    }
	    "week" {
		set html "Set default view to:<P>
		<input type=hidden name=element_id value=$element_id>
		<input type=hidden name=key value=default_view>
		<input type=radio name=value value=day>day</LABEL>
		<input type=radio name=value value=week checked>week</LABEL>
		<input type=radio name=value value=month>month</LABEL>
		<input type=radio name=value value=list>list</LABEL>
		<input type=submit value=\"Update\">"
	    }
	    "month" {
		set html "Set default view to:<P>
		<input type=hidden name=element_id value=$element_id>
		<input type=hidden name=key value=default_view>
		<input type=radio name=value value=day>day</LABEL>
		<input type=radio name=value value=week>week</LABEL>
		<input type=radio name=value value=month checked>month</LABEL>
		<input type=radio name=value value=list>list</LABEL>
		<input type=submit value=\"Update\">"
		
	    }
	    "list" {
		set html "Set default view to:<P>
		<input type=hidden name=element_id value=$element_id>
		<input type=hidden name=key value=default_view>
		<input type=radio name=value value=day>day</LABEL>
		<input type=radio name=value value=week checked>week</LABEL>
		<input type=radio name=value value=month>month</LABEL>
		<input type=radio name=value value=list checked>list</LABEL>
		<input type=submit value=\"Update\">"
	    }

	    return $html
	}
    }

   
    
}
