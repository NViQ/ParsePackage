proc get_additional_parameters {value} {
    set second_byte [expr {($value >> 16) & 0xFF}]

    set bit_7 [expr {($value >> 6) & 1}] ;
    set inverted_bit_7 [expr {$bit_7 ^ 1}]

    set bits_17_20 [expr {($value >> 16) & 0xF}]
    set reversed_bits 0
    for {set i 0} {$i < 4} {incr i} {
        set bit [expr {($bits_17_20 >> $i) & 1}]
        set reversed_bits [expr {($reversed_bits << 1) | $bit}]
    }

    return [list $second_byte $inverted_bit_7 $reversed_bits]
}

set value 0x5FABFF01

set additional_params [get_additional_parameters $value]
set param1 [lindex $additional_params 0]
set param2 [lindex $additional_params 1]
set param3 [lindex $additional_params 2]

puts "First additional parameters: $param1"
puts "Second additional parameters: $param2"
puts "Third additional parameters: $param3"
