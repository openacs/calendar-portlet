<if @config.shaded_p@ ne "t">
<table border=0 width=100%>
<tr>
<td valign=top width=180>
@cal_nav@
<p>
<ul>
<if @create_p@><li> <a href=calendar/?force_calendar_id=@force_calendar_id@&date=@current_date@&action=add&start_time=&end_time=&return_url=../&show_cal_nav=0>Add an item</a></if>
<if @admin_p@><li> <a href="calendar/calendar-item-types?calendar_id=@force_calendar_id@">Manage Item Types</a></if>
</ul>
</td>
<td valign=top>
@cal_stuff@
</td>
</tr>
</table>
</if>
