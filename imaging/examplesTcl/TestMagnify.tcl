catch {load vtktcl}
if { [catch {set VTK_TCL $env(VTK_TCL)}] != 0} { set VTK_TCL "../../examplesTcl" }
if { [catch {set VTK_DATA $env(VTK_DATA)}] != 0} { set VTK_DATA "../../../vtkdata" }

# Doubles the size of the image in the X and tripples in Y dimensions.
source vtkImageInclude.tcl





# Image pipeline

vtkImageReader reader
#reader DebugOn
reader SetDataByteOrderToLittleEndian
reader SetDataExtent 0 255 0 255 1 93
reader SetDataVOI 100 200 100 200 1 93
reader SetFilePrefix "$VTK_DATA/fullHead/headsq"
reader SetDataMask 0x7fff

vtkImageMagnify magnify
magnify SetInput [reader GetOutput]
magnify SetMagnificationFactors 3 2 1


vtkImageViewer viewer
#viewer DebugOn
viewer SetInput [magnify GetOutput]
viewer SetZSlice 22
viewer SetColorWindow 2000
viewer SetColorLevel 1000
[viewer GetActor2D] SetDisplayPosition -250 -180

# make interface
source WindowLevelInterface.tcl


