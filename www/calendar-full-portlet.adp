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
  <table border=0 width="100%">
    <tr>
      <td valign=top width=180>
        @cal_nav@
        <p align="left">
        <ul align="left">
          <if @create_p@><li> <a href="calendar/cal-item-new?date=@current_date@&start_time=&end_time=&time_p=1">Add an item</a></if>
          <if @admin_p@><li> <a href="calendar/calendar-item-types?calendar_id=@force_calendar_id@">Manage Item Types</a></if>
        </ul>
      </td>
      <td valign=top>
        @cal_stuff@
      </td>
    </tr>
  </table>
</if>
<else>
  <br>
</else>

