# www/calendar-portlet.tcl
ad_page_contract {
    The display logic for the calendar portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @cvs_id $Id$
} -properties {
    
}

# get stuff out of the config array
array set config $cf
set view $config(default_view)
set list_of_calendar_ids $config(calendar_id)

# ad_return_complaint 1 "$cf"

# set up some vars
set date [dt_sysdate]
set current_date $date
set date_format "YYYY-MM-DD HH24:MI"

# big switch on the view var
if { $view == "day" } {

#
#create table hours_of_the_day (
#pretty_start_date char(5),
#pretty_end_date char(5)
#);
#
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('00:00', '00:59');
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('01:00', '01:59');
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('02:00', '02:59');
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('03:00', '03:59');
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('04:00', '04:59');
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('05:00', '05:59');
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('06:00', '06:59');
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('07:00', '07:59');
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('08:00', '08:59');
#insert into hours_of_the_day (pretty_start_date, pretty_end_date) values ('09:00', '09:59');
#
#
    set list_of_calendar_ids [join $list_of_calendar_ids ", "]
   
    db_multirow -local foo select_day_items "" {}
}


ad_return_template
