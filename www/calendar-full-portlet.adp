<%

    #
    #  Copyright (C) 2001, 2002 OpenForce, Inc.
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
<p>
<ul>
<if @create_p@><li> <a href=calendar/?force_calendar_id=@force_calendar_id@&date=@current_date@&action=add&start_time=&end_time=&return_url=@encoded_return_url@&show_cal_nav=0>Add an item</a></if>
<if @admin_p@><li> <a href="calendar/calendar-item-types?calendar_id=@force_calendar_id@">Manage Item Types</a></if>
</ul>
</td>
<td valign=top>
@cal_stuff@
</td>
</tr>
</table>
</if>
