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

  <table width="95%">

    <tr>
      <td valign=top width=150>
      <include src="/packages/calendar/www/mini-calendar" base_url="@base_url@/view" view="@view@" date="@date@">
  </center>
  <p>
      <a href="@base_url@cal-item-new?julian_date=@julian_date@" title="#calendar.Add_Item#"><img border=0 align="left" valign="top" src="/shared/images/add.gif" alt="#calendar.Add_Item#">#calendar.Add_Item#</a>
  <p>
  <include src="/packages/calendar/www/cal-options" calendar_list="@calendar_list@" base_url="@base_url@">	

      </td>	

      <td valign=top> 
      
  <if @view@ eq "list">
  <include src="/packages/calendar/www/view-list-display" 
  base_url=@base_url@
  start_date=@start_date@ 
  end_date=@end_date@ 
  date=@date@ 
  period_days=@period_days@
  calendar_id_list=@calendar_list@ 
  hour_template="@hour_template;noquote@" item_add_template="@item_add_template;noquote@"
  sort_by=@sort_by@> 
  </if>


  <if @view@ eq "day">
  <include src="/packages/calendar/www/view-one-day-display" 
  base_url=@base_url@
  date="@date@" start_hour=0 end_hour=23
  hour_template="@hour_template;noquote@" item_add_template="@item_add_template;noquote@"
  calendar_id_list="@calendar_list@">
  </if>

  <if @view@ eq "week">
  <include src="/packages/calendar/www/view-week-display" 
  base_url=@base_url@
  date="@date@"
  hour_template="@hour_template;noquote@" item_add_template="@item_add_template;noquote@"
  calendar_id_list="@calendar_list@">
  </if>


  <if @view@ eq "month">
  <include src="/packages/calendar/www/view-month-display"
  base_url=@base_url@
  date=@date@
  hour_template="@hour_template;noquote@" item_add_template="@item_add_template;noquote@"
  calendar_id_list= @calendar_list@>
  </if>
      </td>
    </tr>
  </table>
</if>
<else>
  <br>
</else>


