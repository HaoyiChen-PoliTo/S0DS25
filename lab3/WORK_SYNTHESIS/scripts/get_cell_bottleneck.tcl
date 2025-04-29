proc get_cell_bottleneck {cellName slackThreshold} {
    set paths [get_timing_paths -through $cellName -max_paths 10000 -slack_lesser_than $slackThreshold]

    set path_count 0
    set path_cost 0.0
    set endpoint_cost 0.0
    array set endpoint_slack_map {}

    foreach_in_collection path $paths {
        incr path_count
        set path_slack [get_attribute $path slack]
        set path_cost [expr {$path_cost + ($slackThreshold - $path_slack)}]

        set endpoint [get_attribute $path endpoint]
        set endpoint_name [get_attribute $endpoint full_name]

        if {![info exists endpoint_slack_map($endpoint_name)]} {
            set endpoint_slack_map($endpoint_name) $path_slack
        } elseif {$path_slack < $endpoint_slack_map($endpoint_name)} {
            set endpoint_slack_map($endpoint_name) $path_slack
        }
    }

    foreach endpoint_name [array names endpoint_slack_map] {
        set endpoint_slack $endpoint_slack_map($endpoint_name)
        set endpoint_cost [expr {$endpoint_cost + ($slackThreshold - $endpoint_slack)}]
    }

    return [list "Path Count" $path_count "Path Cost" $path_cost "Endpoint Cost" $endpoint_cost]
}