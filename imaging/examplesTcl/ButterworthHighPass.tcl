catch {load vtktcl}
if { [catch {set VTK_TCL $env(VTK_TCL)}] != 0} { set VTK_TCL "../../examplesTcl" }
if { [catch {set VTK_DATA $env(VTK_DATA)}] != 0} { set VTK_DATA "../../../vtkdata" }

# This script shows the result of an ideal highpass filter in  spatial domain

source vtkImageInclude.tcl

# Image pipeline

vtkImageReader reader
reader SetDataByteOrderToLittleEndian
reader SetDataExtent 0 255 0 255 1 93
reader SetFilePrefix "$VTK_DATA/fullHead/headsq"
reader SetDataMask 0x7fff
#reader DebugOn

vtkImageFFT fft
fft SetFilteredAxes $VTK_IMAGE_X_AXIS $VTK_IMAGE_Y_AXIS
fft SetInput [reader GetOutput]
#fft DebugOn

vtkImageButterworthHighPass highPass
highPass SetInput [fft GetOutput]
highPass SetOrder 2
highPass SetXCutOff 0.2
highPass SetYCutOff 0.2
highPass ReleaseDataFlagOff
#highPass DebugOn

vtkImageRFFT rfft
rfft SetFilteredAxes $VTK_IMAGE_X_AXIS $VTK_IMAGE_Y_AXIS
rfft SetInput [highPass GetOutput]
#fft DebugOn

vtkImageExtractComponents real
real SetInput [rfft GetOutput]
real SetComponents 0



vtkImageViewer viewer
viewer SetInput [real GetOutput]
viewer SetZSlice 22
viewer SetColorWindow 500
viewer SetColorLevel 0
#viewer DebugOn


# make interface
source WindowLevelInterface.tcl







