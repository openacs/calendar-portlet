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

  <style type="text/css" media="all">
    @import "/resources/calendar/calendar.css";
  </style>

<if @config.shaded_p@ false>
  <table border="0" width="100%">
    <tr>
      <td valign="top">

	<include src="/packages/calendar/www/mini-calendar" 
          base_url="@base_url@" 
          view="@view@" 
          date="@date@" 
          page_num="@page_num@">

        <p align="left">

        <ul align="left">
          <if @create_p@><li> <a href="calendar/cal-item-new?date=@current_date@&start_time=&end_time=&time_p=1">#calendar-portlet.Add_an_item#</a></if>
          <if @admin_p@><li> <a href="calendar/calendar-item-types?calendar_id=@force_calendar_id@">#calendar-portlet.Manage_Item_Types#</a></if>
        </ul>
      </td>
      <td valign=top>

 <switch @view@>
   <case value="day">
     <include src="/packages/calendar/www/view-one-day-display" 
     date="@date@" 
     start_display_hour=7 
     end_display_hour=22
     hour_template="@hour_template;noquote@" 
     item_template="@item_template;noquote@"
     item_add_template="@item_add_template;noquote@"
     prev_nav_template="@previous_link;noquote@"
     next_nav_template="@next_link;noquote@"
     base_url="@base_url@calendar/"
     url_stub_callback="@url_stub_callback;noquote@" 
     calendar_id_list="@list_of_calendar_ids@">
   </case>

  <case value="list">
     <include src="/packages/calendar/www/view-list-display" 
     start_date=@start_date@ 
     end_date=@end_date@ 
     date=@current_date@ 
     period_days=@period_days@
     item_template="@item_template;noquote@"
     calendar_id_list=@list_of_calendar_ids@ 
     url_template="@url_template;noquote@" 
     url_stub_callback="@url_stub_callback;noquote@" 
     page_num=@page_num@
     sort_by=@sort_by@> 
  </case>
  
  <case value="week">
     <include src="/packages/calendar/www/view-week-display" 
     date="@current_date@"
     calendar_id_list=@list_of_calendar_ids@ 
     base_url="@base_url@calendar/"
     item_template="@item_template;noquote@"
     page_num=@page_num@
     prev_week_template="@prev_week_template;noquote@"
     next_week_template="@next_week_template;noquote@"
     url_stub_callback="@url_stub_callback;noquote@">
  </case>

  <case value="month">
     <include src="/packages/calendar/www/view-month-display"
     date=@current_date@
     calendar_id_list=@list_of_calendar_ids@ 
     item_template="@item_template;noquote@"
     base_url="@base_url@calendar/"
     page_num=@page_num@
     prev_month_template="@prev_month_template;noquote@"
     next_month_template="@next_month_template;noquote@">
  </case>
 </switch>
      </td>
    </tr>
  </table>
</if>
<else>
  <br>
</else>


