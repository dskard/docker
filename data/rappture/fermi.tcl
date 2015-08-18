# ----------------------------------------------------------------------
#  EXAMPLE: Fermi-Dirac function in Tcl.
#
#  This simple example shows how to use Rappture within a simulator
#  written in Tcl.
# ======================================================================
#  AUTHOR:  Michael McLennan, Purdue University
#  Copyright (c) 2004-2007  Purdue Research Foundation
#
#  See the file "license.terms" for information on usage and
#  redistribution of this file, and for a DISCLAIMER OF ALL WARRANTIES.
# ======================================================================
package require Rappture

# open the XML file containing the run parameters
set driver [Rappture::library [lindex $argv 0]]

set T [$driver get input.(temperature).current]
set T [Rappture::Units::convert $T -to K -units off]
set Ef [$driver get input.(Ef).current]
set Ef [Rappture::Units::convert $Ef -to eV -units off]

set kT [expr {8.61734e-5 * $T}]
set Emin [expr {$Ef - 10*$kT}]
set Emax [expr {$Ef + 10*$kT}]

set E $Emin
set dE [expr {0.005*($Emax-$Emin)}]

# Label output graph with title, x-axis label,
# y-axis lable, and y-axis units
$driver put -append no output.curve(f12).about.label "Fermi-Dirac Factor"
$driver put -append no output.curve(f12).xaxis.label "Fermi-Dirac Factor"
$driver put -append no output.curve(f12).yaxis.label "Energy"
$driver put -append no output.curve(f12).yaxis.units "eV"

while {$E < $Emax} {
    set f [expr {1.0/(1.0 + exp(($E - $Ef)/$kT))}]
    set progress [expr {(($E - $Emin)/($Emax - $Emin)*100)}]
    Rappture::Utils::progress $progress -mesg "Iterating"
    $driver put -append yes output.curve(f12).component.xy "$f $E\n"
    set E [expr {$E + $dE}]
}

# save the updated XML describing the run...
Rappture::result $driver
exit 0
