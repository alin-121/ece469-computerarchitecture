onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /alustim/A
add wave -noupdate -radix binary /alustim/B
add wave -noupdate -radix binary /alustim/result
add wave -noupdate /alustim/cntrl
add wave -noupdate /alustim/negative
add wave -noupdate /alustim/zero
add wave -noupdate /alustim/overflow
add wave -noupdate /alustim/carry_out
add wave -noupdate /alustim/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45300000350 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 485
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {40049549158 ps} {61155286886 ps}
