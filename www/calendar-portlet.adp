<if @config.shaded_p@ ne "t">    
  <if @view@ eq "list">
  <include src="view-list-display" 
  start_date=@start_date@ 
  end_date=@end_date@ 
  date=@date@ 
  period_days=@period_days@
  calendar_id_list=@calendar_list@ 
  sort_by=@sort_by@> 
  </if>


  <if @view@ eq "day">
  <include src="/packages/calendar/www/view-one-day-display" 
  date="@date@" start_hour=0 end_hour=23
  calendar_id_list="@calendar_list@">
  </if>

  <if @view@ eq "week">
  <include src="/packages/calendar/www/view-week-display" 
  date="@date@"
  calendar_id_list="@calendar_list@">
  </if>


  <if @view@ eq "month">
  <include src="/packages/calendar/www/view-month-display"
  date=@date@
  calendar_id_list= @calendar_list@>
  </if>
</if>
<else>
  <br>
</else>
