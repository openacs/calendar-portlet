--
-- /calendar-portlet/sql/oracle/calendar-portlet-create.sql
--

-- Creates calendar portlet

-- Copyright (C) 2001 OpenForce, Inc.
-- @author Arjun Sanyal (arjun@openforce.net)
-- @creation-date 2001-26-10

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

declare
  ds_id portal_datasources.datasource_id%TYPE;
begin
  ds_id := portal_datasource.new(
    name             => 'calendar-portlet',
    link             => 'calendar',
    description      => 'Displays the calendar ',
    content	     => 'calendar_portlet::show',
    edit_content     => 'calendar_portlet::edit',
    configurable_p   => 't'
  );


  -- for the personal calendar

  -- calendar_id must be configured 
  portal_datasource.set_def_param (
	  datasource_id => ds_id,
	  config_required_p => 't',
	  configured_p => 'f',
	  key => 'calendar_id',
	  value => ''
);

  -- shaded_p 
  portal_datasource.set_def_param (
	datasource_id => ds_id,
	config_required_p => 't',
	configured_p => 't',
	key => 'shaded_p',
	value => 'f'
);	


  -- defaul_view see cal-table-create.sql
  portal_datasource.set_def_param (
	datasource_id => ds_id,
	config_required_p => 't',
	configured_p => 't',
	key => 'default_view',
	value => 'day'
);	


-- XXX community calendars

--
--
--  portal_datasource.set_def_param (
--	  datasource_id => ds_id,
--	  config_required_p => 't',
--	  configured_p => 'f',
--	  key => 'folder_id',
--	  value => ''
--);	
--

end;
/
show errors

