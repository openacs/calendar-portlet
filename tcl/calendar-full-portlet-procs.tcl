# calendar-portlet/tcl/calendar-portlet-procs.tcl

ad_library {

Procedures to support the calendar portlet

Copyright Openforce, Inc.
Licensed under GNU GPL v2 

@creation-date Oct 26 2001
@author arjun@openforce.net 
@cvs-id $Id$

}

namespace eval calendar_full_portlet {

    ad_proc -private my_package_key {
    } {
        return "calendar-portlet"
    }

    ad_proc -private my_name {
    } {
        return "calendar_full_portlet"
    }

    ad_proc -public get_pretty_name {
    } {
        return [ad_parameter \
                -package_id [apm_package_id_from_key [my_package_key]] \
                "full_portlet_pretty_name"]
    }

    ad_proc -public link {
    } {
	return "calendar"
    }

    ad_proc -public add_self_to_page { 
        {-page_id ""}
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
                -page_id $page_id \
                -portlet_name [my_name] \
                -value_id $calendar_id \
                -key calendar_id]
    }

    ad_proc -public remove_self_from_page {
	portal_id
        package_id
    } {
	  Removes a calendar PE from the given page
    
	  @param portal_id The page to remove self from
	  @param community_id
	  @author arjun@openforce.net
	  @creation-date Sept 2001
    } {
        ## YOWSA (ben)
        # calendar portlet should NOT be creating and deleting calendars!
        # I've taken out a chunk of code here that was removing calendars. No way! (ben).
        
        # get rid of this portal element
        # This automatically removes all element params
        portal::remove_element_or_remove_id -portal_id $portal_id -portlet_name [my_name] -key calendar_id -value_id $package_id
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
                -config_list $cf \
                -template_src "calendar-full-portlet"
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
	# We're going to have to replace this stuff with real templated stuff
    }

   
    
}
