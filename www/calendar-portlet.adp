<%

    #
    #  Copyright (C) 2001, 2002 MIT
    #
    #  This file is part of dotLRN.
    #
    #  dotLRN is free software; you can redistribute it and/or modify it under the
    #  terms of the GNU General Public License as published by the Free Software
    #  Foundation; either version 2 of the License, or (at your option) any later
    #  version.
    #
    #  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
    #  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    #  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
    #  details.
    #

%>

<if @config.shaded_p@ ne "t">

 <switch @view@>
   <case value="day">
     <include src="/packages/calendar/www/view-one-day-display" 
     return_url="@return_url;noquote@"
     date="@date@" 
     start_display_hour=7 
     end_display_hour=22
     page_num=@page_num@
     calendar_url="@calendar_url@"
     calendar_id_list="@list_of_calendar_ids@">
   </case>

    <case value="list">
      <include src="/packages/calendar/www/view-list-display" 
      return_url="@return_url;noquote@"
      start_date=@start_date@ 
      end_date=@end_date@ 
      date=@current_date@ 
      period_days=@period_days@
      item_template="@item_template;noquote@"
      calendar_id_list=@list_of_calendar_ids@ 
      page_num=@page_num@
      calendar_url="@calendar_url@"
      sort_by=@sort_by@> 
    </case>
   
    <case value="week">
      <include src="/packages/calendar/www/view-week-display" 
      return_url="@return_url;noquote@"
      date="@current_date@"
      calendar_id_list=@list_of_calendar_ids@ 
      calendar_url="@calendar_url@"
      page_num=@page_num@
    </case>

    <case value="month">
      <include src="/packages/calendar/www/view-month-display"
      return_url="@return_url;noquote@"
      date=@current_date@
      calendar_id_list=@list_of_calendar_ids@ 
      page_num=@page_num@
      calendar_url="@calendar_url@"
    </case>
  </switch>
</if>
<else>
  <small>
    #new-portal.when_portlet_shaded#
  </small>
</else>
