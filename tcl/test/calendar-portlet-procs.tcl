ad_library {
    Automated tests.
    @author Mounir Lallali
    @creation-date 14 December 2005

}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_calendar_portlet_display_day {

    Test Display a Day in Calendar

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url

        set date [template::util::date::today]
        set date [template::util::date::get_property display_date $date]

        set response [calendar_portlet::twt::display_day $date]
        aa_display_result -response $response -explanation {Webtest for displaying a current day in the calendar}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_calendar_portlet_display_week {

    Test Display a Week in Calendar

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url

        # Get Start and End date Week
        set date [template::util::date::today]
        set year [template::util::date::get_property year $date]
        set number_week [expr {[clock format [clock scan now] -format %W]-1}]

        set start_end_date_week [calendar_portlet::twt::get_start_end_week_date $number_week $year]

        lassign $start_end_date_week start_date_week end_date_week

        # Display week
        set response [calendar_portlet::twt::display_week $start_date_week $end_date_week ]
        aa_display_result -response $response -explanation {Webtest for displaying a current week in the calendar}

        twt::user::logout
    }
}


aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_calendar_portlet_display_month {

    Test Display a Month in Calendar

    @author Mounir Lallali
} {
    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url

        set date [template::util::date::today]

        set response [calendar_portlet::twt::display_month $date]
        aa_display_result -response $response -explanation {Webtest for displaying a current month in the calendar}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_calendar_portlet_item_add {

    Test Add an Item in Calendar

    @author Mounir Lallali
} {

    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url

        set item_title [ad_generate_random_string]
        set item_description [ad_generate_random_string]

        set date [template::util::date::today]
        set item_date [template::util::date::get_property linear_date_no_time $date]

        set response [calendar_portlet::twt::item_add $item_title $item_description $item_date]
        aa_display_result -response $response -explanation {Webtest for addting an item in the calendar}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_calendar_portlet_item_edit {

    Test Edit an Item in Calendar

    @author Mounir Lallali
} {

    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url

        set item_title [ad_generate_random_string]
        set item_description [ad_generate_random_string]

        set date [template::util::date::today]
        set item_date [template::util::date::get_property linear_date_no_time $date]

        calendar_portlet::twt::item_add $item_title $item_description $item_date

        set item_new_title [ad_generate_random_string]
        set item_new_description [ad_generate_random_string]

        set response [calendar_portlet::twt::item_edit $item_title $item_new_title $item_new_description $item_date]
        aa_display_result -response $response -explanation {Webtest for editing an item in the calendar}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_calendar_portlet_item_delete {

    Test Delete an Item in Calendar

    @author Mounir Lallali
} {

    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url

        set item_title [ad_generate_random_string]
        set item_description [ad_generate_random_string]

        set date [template::util::date::today]
        set item_date [template::util::date::get_property linear_date_no_time $date]

        calendar_portlet::twt::item_add $item_title $item_description $item_date

        set item_new_title [ad_generate_random_string]
        set item_new_description [ad_generate_random_string]

        set response [calendar_portlet::twt::item_delete $item_title]
        aa_display_result -response $response -explanation {Webtest for deleting an item in the calendar}

        twt::user::logout
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_calendar_portlet_item_display_list {

    Test Display an Item List in Calendar

    @author Mounir Lallali
} {

    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url

        set item_title_1 [ad_generate_random_string]
        set item_description_1 [ad_generate_random_string]

        set item_title_2 [ad_generate_random_string]
        set item_description_2 [ad_generate_random_string]

        set item_title_3 [ad_generate_random_string]
        set item_description_3 [ad_generate_random_string]

        set date [template::util::date::today]
        set item_date [template::util::date::get_property linear_date_no_time $date]

        calendar_portlet::twt::item_add $item_title_1 $item_description_1 $item_date
        calendar_portlet::twt::follow_calendar_link

        calendar_portlet::twt::item_add $item_title_2 $item_description_2 $item_date
        calendar_portlet::twt::follow_calendar_link

        calendar_portlet::twt::item_add $item_title_3 $item_description_3 $item_date

        set response [calendar_portlet::twt::item_display_list $item_title_1 $item_title_2 $item_title_3]
        aa_display_result -response $response -explanation {Webtest for displaying an item list in the calendar}

        twt::user::logout
    }
}


aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_request_notification {

    Test Request a Notification for Calendar

    @author Mounir Lallali
} {

    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url

        set item_title [ad_generate_random_string]
        set item_description [ad_generate_random_string]

        set date [template::util::date::today]
        set item_date [template::util::date::get_property linear_date_no_time $date]

        calendar_portlet::twt::item_add $item_title $item_description $item_date

        set response [calendar_portlet::twt::request_notification]
        aa_display_result -response $response -explanation {Webtest for requesting a notification for calendar}
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_unsubscribe {

    Test Unsubscribe a Notification for Calendar

    @author Mounir Lallali
} {

    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url

        set item_title [ad_generate_random_string]
        set item_description [ad_generate_random_string]

        set date [template::util::date::today]
        set item_date [template::util::date::get_property linear_date_no_time $date]

        calendar_portlet::twt::item_add $item_title $item_description $item_date

        calendar_portlet::twt::request_notification
        set response [calendar_portlet::twt::unsubscribe]
        aa_display_result -response $response -explanation {Webtest for unsubscribing a notification for calendar}
    }
}

aa_register_case -cats {web smoke} -libraries tclwebtest tclwebtest_display_date {

    Test Display a Date in The Calendar

    @author Mounir Lallali
} {

    aa_run_with_teardown -test_code {

        tclwebtest::cookies clear
        # Login user
        array set user_info [acs::test::user::create -admin]
        twt::user::login $user_info(email) $user_info(password)

        calendar_portlet::twt::go_to_dotlrn_calendar_page_url
        set date [template::util::date::today]

        set response [calendar_portlet::twt::display_date $date]
        aa_display_result -response $response -explanation {Webtest for unsubscribing a notification for calendar}

    }
}

aa_register_case -procs {
        calendar_full_portlet::link
        calendar_admin_portlet::link
        calendar_list_portlet::link
        calendar_portlet::link
        calendar_full_portlet::get_pretty_name
        calendar_admin_portlet::get_pretty_name
        calendar_list_portlet::get_pretty_name
        calendar_portlet::get_pretty_name
    } -cats {
        api
        production_safe
    } calendar_portlet_links_names {
        Test diverse link and name procs.
} {
    set pretty_name     [parameter::get_from_package_key \
                            -package_key [calendar_portlet::my_package_key] \
                            -parameter pretty_name]
    set fp_pretty_name  [parameter::get_from_package_key \
                            -package_key [calendar_full_portlet::my_package_key] \
                            -parameter full_portlet_pretty_name]
    aa_equals "Calendar full portlet link"          "[calendar_full_portlet::link]" ""
    aa_equals "Calendar admin portlet link"         "[calendar_admin_portlet::link]" ""
    aa_equals "Calendar list portlet link"          "[calendar_list_portlet::link]" ""
    aa_equals "Calendar portlet link"               "[calendar_portlet::link]" ""
    aa_equals "Calendar full portlet pretty name"   "[calendar_full_portlet::get_pretty_name]" "$fp_pretty_name"
    aa_equals "Calendar admin portlet pretty name"  "[calendar_admin_portlet::get_pretty_name]" "#calendar-portlet.admin_pretty_name#"
    aa_equals "Calendar list portlet pretty name"   "[calendar_list_portlet::get_pretty_name]" "\#calendar-portlet.Schedule\#"
    aa_equals "Calendar portlet pretty name"        "[calendar_portlet::get_pretty_name]" "$pretty_name"
}

aa_register_case -procs {
        calendar_portlet::add_self_to_page
        calendar_portlet::remove_self_from_page
        calendar_list_portlet::add_self_to_page
        calendar_list_portlet::remove_self_from_page
        calendar_full_portlet::add_self_to_page
        calendar_full_portlet::remove_self_from_page
        calendar_admin_portlet::add_self_to_page
        calendar_admin_portlet::remove_self_from_page
    } -cats {
        api
    } calendar_portlet_add_remove_from_page {
        Test add/remove portlet procs.
} {
    #
    # Helper proc to check portal elements
    #
    proc portlet_exists_p {portal_id portlet_name} {
        return [db_0or1row portlet_in_portal {
            select 1 from dual where exists (
              select 1
                from portal_element_map pem,
                     portal_pages pp
               where pp.portal_id = :portal_id
                 and pp.page_id = pem.page_id
                 and pem.name = :portlet_name
            )
        }]
    }
    #
    # Start the tests
    #
    aa_run_with_teardown -rollback -test_code {
        #
        # Create a community.
        #
        # As this is running in a transaction, it should be cleaned up
        # automatically.
        #
        set community_id [dotlrn_community::new -community_type dotlrn_community -pretty_name foo]
        set calendar_id [calendar::new -owner_id [ad_conn user_id] -calendar_name foo]
        if {$community_id ne ""} {
            aa_log "Community created: $community_id"
            set portal_id [dotlrn_community::get_admin_portal_id -community_id $community_id]
            set package_id [dotlrn::instantiate_and_mount $community_id [calendar_portlet::my_package_key]]
            #
            # calendar_portlet
            #
            set portlet_name [calendar_portlet::get_my_name]
            #
            # Add portlet.
            #
            calendar_portlet::add_self_to_page -portal_id $portal_id -calendar_id $calendar_id
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            calendar_portlet::remove_self_from_page -portal_id $portal_id -calendar_id $calendar_id
            aa_false "Portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            calendar_portlet::add_self_to_page -portal_id $portal_id -calendar_id $calendar_id
            aa_true "Portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # calendar_list_portlet
            #
            set portlet_name [calendar_list_portlet::get_my_name]
            #
            # Add portlet.
            #
            calendar_list_portlet::add_self_to_page -portal_id $portal_id -calendar_id $calendar_id
            aa_true "List portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            calendar_list_portlet::remove_self_from_page $portal_id $calendar_id
            aa_false "List portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            calendar_list_portlet::add_self_to_page -portal_id $portal_id -calendar_id $calendar_id
            aa_true "List portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # calendar_full_portlet
            #
            set portlet_name [calendar_full_portlet::get_my_name]
            #
            # Add portlet.
            #
            calendar_full_portlet::add_self_to_page -portal_id $portal_id -calendar_id $calendar_id
            aa_true "Full portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            calendar_full_portlet::remove_self_from_page -portal_id $portal_id -calendar_id $calendar_id
            aa_false "Full portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            calendar_full_portlet::add_self_to_page -portal_id $portal_id -calendar_id $calendar_id
            aa_true "Full portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # admin_portlet
            #
            set portlet_name [calendar_admin_portlet::get_my_name]
            #
            # Add portlet.
            #
            calendar_admin_portlet::add_self_to_page -portal_id $portal_id -calendar_id $calendar_id
            aa_true "Admin portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Remove portlet.
            #
            calendar_admin_portlet::remove_self_from_page $portal_id
            aa_false "Admin portlet is in community portal after removal" "[portlet_exists_p $portal_id $portlet_name]"
            #
            # Add portlet.
            #
            calendar_admin_portlet::add_self_to_page -portal_id $portal_id -calendar_id $calendar_id
            aa_true "Admin portlet is in community portal after addition" "[portlet_exists_p $portal_id $portlet_name]"
        } else {
            aa_error "Community creation failed"
        }
    }
}

aa_register_case -procs {
    calendar_admin_portlet::show
    calendar_admin_portlet::get_my_name
    calendar_full_portlet::show
    calendar_full_portlet::get_my_name
    calendar_list_portlet::show
    calendar_list_portlet::get_my_name
    calendar_portlet::show
    calendar_portlet::get_my_name
    calendar::new
} -cats {
    api
    smoke
} calendar_render_portlet {
    Test the rendering of the portlets
} {
    set orig_user_id [ad_conn user_id]
    set user [acs::test::user::create]
    set user_id [dict get $user user_id]
    ad_conn -set user_id $user_id

    aa_run_with_teardown -rollback -test_code {
        set package_id [site_node::instantiate_and_mount \
                             -package_key calendar \
                             -node_name __test_calendar_portlet]

        set calendar_id [calendar::new \
                             -owner_id $user_id -private_p t \
                             -calendar_name __test_portlet_calendar \
                             -package_id $package_id]

        aa_section "Admin Portlet"

        foreach default_view {day list week month} {
            set cf [list \
                        calendar_id $calendar_id \
                        default_view $default_view
                   ]

            set portlet [acs_sc::invoke \
                             -contract portal_datasource \
                             -operation Show \
                             -impl [calendar_admin_portlet::get_my_name] \
                             -call_args [list $cf]]

            aa_log "Portlet returns: [ns_quotehtml $portlet]"

            aa_false "View: $default_view - No error was returned" {
                [string first "Error in include template" $portlet] >= 0
            }

            aa_false "View: $default_view - No unresolved message keys" {
                [string first "MESSAGE KEY MISSING: " $portlet] >= 0
            }

            aa_true "View: $default_view - Portlet contains something" {
                [string length [string trim $portlet]] > 0
            }
        }

        foreach shaded_p {true false} {
            set section_name "Standard Portlet"
            if {$shaded_p} {
                append section_name " (shaded)"
            }
            aa_section $section_name

            foreach default_view {day list week month} {
                set cf [list \
                            calendar_id $calendar_id \
                            default_view $default_view \
                            shaded_p $shaded_p
                       ]

                set portlet [acs_sc::invoke \
                                 -contract portal_datasource \
                                 -operation Show \
                                 -impl [calendar_portlet::get_my_name] \
                                 -call_args [list $cf]]

                aa_log "Portlet returns: [ns_quotehtml $portlet]"

                aa_false "View: $default_view - No error was returned" {
                    [string first "Error in include template" $portlet] >= 0
                }

                aa_false "View: $default_view - No unresolved message keys" {
                    [string first "MESSAGE KEY MISSING: " $portlet] >= 0
                }

                aa_true "View: $default_view - Portlet contains something" {
                    [string length [string trim $portlet]] > 0
                }
            }

            set section_name "List Portlet"
            if {$shaded_p} {
                append section_name " (shaded)"
            }
            aa_section $section_name

            foreach default_view {day list week month} {
                set cf [list \
                            calendar_id $calendar_id \
                            default_view $default_view \
                            scoped_p false \
                            shaded_p $shaded_p \
                           ]

                set portlet [acs_sc::invoke \
                                 -contract portal_datasource \
                                 -operation Show \
                                 -impl [calendar_list_portlet::get_my_name] \
                                 -call_args [list $cf]]

                aa_log "Portlet returns: [ns_quotehtml $portlet]"

                aa_false "View: $default_view - No error was returned" {
                    [string first "Error in include template" $portlet] >= 0
                }

                aa_false "View: $default_view - No unresolved message keys" {
                    [string first "MESSAGE KEY MISSING: " $portlet] >= 0
                }

                aa_true "View: $default_view - Portlet contains something" {
                    [string length [string trim $portlet]] > 0
                }
            }

            set section_name "Full Portlet"
            if {$shaded_p} {
                append section_name " (shaded)"
            }
            aa_section $section_name

            foreach default_view {day list week month} {
                set cf [list \
                            calendar_id $calendar_id \
                            default_view $default_view \
                            scoped_p false \
                            shaded_p $shaded_p \
                           ]

                set portlet [acs_sc::invoke \
                                 -contract portal_datasource \
                                 -operation Show \
                                 -impl [calendar_full_portlet::get_my_name] \
                                 -call_args [list $cf]]

                aa_log "Portlet returns: [ns_quotehtml $portlet]"

                aa_false "View: $default_view - No error was returned" {
                    [string first "Error in include template" $portlet] >= 0
                }

                aa_false "View: $default_view - No unresolved message keys" {
                    [string first "MESSAGE KEY MISSING: " $portlet] >= 0
                }

                aa_true "View: $default_view - Portlet contains something" {
                    [string length [string trim $portlet]] > 0
                }
            }

        }
    } -teardown_code {
        ad_conn -set user_id $orig_user_id
        if {[info exists user_id]} {
            acs::test::user::delete -user_id $user_id
        }
    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
