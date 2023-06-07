proc parse_package {package} {
    if {![string match "#*" [string index $package 0]]} {
        puts "Error: incorrect package format"
        return
    }

    set parts [lindex [split [string range $package 1 end-2] "#"] 1]
    set parts2 [split $parts ";"]

    set package_type [lindex [split $package "#"] 1]
    if {$package_type eq "SD"} {
        parse_sd_package $parts2
    } elseif {$package_type eq "M"} {
        parse_m_package $parts2
    } else {
        puts "Error: Unknown package type"
    }
}

proc parse_sd_package {parts} {
    if {[llength $parts] != 10} {
        puts "Ошибка: некорректное количество полей в пакете SD"
        return
    }

    set data_db [dict create \
        "date" [lindex $parts 0] \
        "time" [lindex $parts 1] \
        "lat1" [expr {[lindex $parts 2] + 0.0}] \
        "lat2" [lindex $parts 3] \
        "lon1" [expr {[lindex $parts 4] + 0.0}] \
        "lon2" [lindex $parts 5] \
        "speed" [expr {[lindex $parts 6]}] \
        "course" [expr {[lindex $parts 7]}] \
        "height" [expr {[lindex $parts 8]}] \
        "sats" [expr {[lindex $parts 9]}]
    ]

    set data_out [dict create \
        "Packet type" "SD" \
        "Date" [dict get $data_db "date"] \
        "Time" [dict get $data_db "time"] \
        "Latitude" [list [dict get $data_db "lat1"] [dict get $data_db "lat2"]] \
        "Longitude" [list [dict get $data_db "lon1"] [dict get $data_db "lon2"]] \
        "Speed" "[dict get $data_db "speed"] km/h" \
        "Course" "[dict get $data_db "course"] degrees" \
        "Height" "[dict get $data_db "height"] m" \
        "Satellites" [dict get $data_db "sats"]
    ]

    dict for {key value} $data_out {
        puts "$key: $value"
    }

    return $data_db
}

proc parse_m_package {parts} {
    if {[llength $parts] != 1} {
        puts "Error: incorrect number of fields in the package M"
        return
    }

    set message [lindex $parts 0]
    puts "Package Type: M"
    puts "Message: $message"
}

set package1 "#SD#04012011;135515;5544.6025;N;03739.6834;E;35;215;110;7\r\n"
set package2 "#M#the cargo has been delivered\r\n"

parse_package $package1
puts "-----------"
parse_package $package2