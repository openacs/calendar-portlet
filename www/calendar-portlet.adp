<if @config.shaded_p@ ne "t">
  <table cellpadding=2 cellspacing=0 border=0>

  <multiple name="foo">

  <tr>

  <if @foo.name@ eq "">

<!--    

<td valign=top nowrap $bgcolor_html width=\"10%\">
      <a href=calendar/?date=@date@&view=@view@&action=add&start_time=@foo.pretty_start_date@&end_time=@foo.pretty_end_date@> @foo.pretty_start_date@ <br> @foo.pretty_end_date@  </a>
    </td>
    <td bgcolor=#eeeee7> 
  
-->
    
    </td>
  </if>
  <else>
    <td valign=top nowrap $bgcolor_html width=\"10%\">
      <a href=calendar/?date=@date@&action=edit&cal_item_id=@foo.item_id@>
        @foo.pretty_start_date@ <br> @foo.pretty_end_date@ </a>
    </td>
  <td>
    <a href=calendar?date=@date@&action=edit&cal_item_id=@foo.item_id@>
      @foo.name@ <br> <small> (@foo.calendar_name@) </small>
        </a><br>
   </td>
  </else>
  </multiple>
  
  </table>
                
</if>
<else>
  <if @foo:rowcount@ gt 0>
    <small>There are some calendar items in this view - FIXME<mall>
  </if>
  <else>
    <small>No calendar items available</small>
  </else>
</else>


