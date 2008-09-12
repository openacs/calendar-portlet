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
<if @config.shaded_p@ false>

  <include src="/packages/calendar/www/navbar"
    date="@date@"
    period_days="@period_days@"
    base_url="@ad_conn_url@"
    page_num="@page_num@"
    view="@view@">

  <table id="valign-hack" border="0" width="100%">
    <tr>
      <td valign="top" style="width: 200px">

	<include src="/packages/calendar/www/mini-calendar" 
          view="@view@" 
          date="@date@" 
          page_num="@page_num@">
 
		<if @create_p@> 
			<a href="@add_item_url@" title="#calendar-portlet.Add_an_item#" class="button">#calendar-portlet.Add_an_item#</a>
		</if>
		<if @admin_p@>
			<a href="calendar/calendar-item-types?calendar_id=@force_calendar_id@" title="#calendar-portlet.Manage_Item_Types#" class="button">#calendar-portlet.Manage_Item_Types#</a>
		</if>

      </td>

      <td valign=top>


 <switch @view@>
   <case value="day">
     <include src="/packages/calendar/www/view-one-day-display" 
     date="@date@" 
     start_display_hour=7 
     end_display_hour=22
     page_num=@page_num@
     calendar_id_list=@list_of_calendar_ids@ 
     calendar_url="@calendar_url@"
     return_url="@return_url;noquote@">
   </case>

  <case value="list">
     <include src="/packages/calendar/www/view-list-display" 
     start_date=@start_date@ 
     end_date=@end_date@ 
     date=@current_date@ 
     period_days=@period_days@
     calendar_id_list=@list_of_calendar_ids@ 
     page_num=@page_num@
     calendar_url="@calendar_url@"
     return_url="@return_url;noquote@">
  </case>
  
  <case value="week">
     <include src="/packages/calendar/www/view-week-display" 
     date="@current_date@"
     calendar_id_list=@list_of_calendar_ids@ 
     page_num=@page_num@
     return_url="@return_url;noquote@"
     calendar_url="@calendar_url@"
     export=@export@>
 </case>

  <case value="month">
     <include src="/packages/calendar/www/view-month-display"
     date=@current_date@
     calendar_id_list=@list_of_calendar_ids@ 
     page_num=@page_num@
     show_calendar_name_p="@show_calendar_name_p;noquote@"
     return_url="@return_url;noquote@"
     calendar_url="@calendar_url@"
     export=@export@>
  </case>
 </switch>
      </td>
    </tr>
  </table>

</if>
<else>
  <small>
    #new-portal.when_portlet_shaded#
  </small>
</else>
