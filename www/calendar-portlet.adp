<if @config.shaded_p@ ne "t">    

  <include src="/packages/calendar/www/view-one-day-display" 
    date="@date@" start_display_hour=7 end_display_hour=22
    calendar_id_list="@calendar_list@">

</if>
<else>
  <br>
</else>
