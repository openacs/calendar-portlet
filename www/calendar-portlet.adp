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
  <if @view@ eq "day">
  <include src="/packages/calendar/www/view-one-day-display" 
  base_url=@base_url@
  date="@date@" start_display_hour=7 end_display_hour=22
  hour_template="@hour_template;noquote@" item_add_template="@item_add_template;noquote@"
  prev_nav_template="@previous_link;noquote@"
  next_nav_template="@next_link;noquote@"
  calendar_id_list="@list_of_calendar_ids@">
  </if>
  <else>
@cal_stuff;noquote@
</else>
</if>
<else>
&nbsp;
</else>
