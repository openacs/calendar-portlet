--
-- /calendar-portlet/sql/oracle/calendar-portlet-drop.sql
--

-- Drops calendar portlet

-- Copyright (C) 2001 Openforce, Inc. 
-- @author Arjun Sanyal (arjun@openforce.net)
-- @creation-date 2001-30-09

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

declare  
  ds_id portal_datasources.datasource_id%TYPE;
begin

  begin 
    select datasource_id into ds_id
      from portal_datasources
     where name = 'calendar-portlet';
   exception when no_data_found then
     ds_id := null;
  end;

  if ds_id is not null then
    portal_datasource.delete(ds_id);
  end if;

end;
/
show errors;

