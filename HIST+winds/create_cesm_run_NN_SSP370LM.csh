#!/bin/csh -fv

#*****************************************************************
# Create, setup, build, & run CESM2 case
#
# Usage:
#	./create_cesm_run_NN_SSP337LM.csh
#
# Notes:
# 	SSP-370 everything (CMIP6 smbb forcing), winds are historical
# 	Initialized from HIST_UVnudge_LM
#****************************************************************

## Set option variables in this section
# Set case parameters & name
set CASETITLE=HIST_UVnudge_LM
set RES=f09_g17
set COMPSET=BSSP370smbb
set COMPSET_SHORT=b
set STARTDATE=2015-01-01

set REFCASE=${COMPSET_SHORT}.e21.BHISTsmbb.${RES}.HIST_UVnudge_LM.
set REFDATE=2015-01-01
set REFDIR=/glade/derecho/scratch/glydia/archive

set PROJ=$PROJECT
echo $PROJ
set CONT_RUN=FALSE

## Set path variables in this section
set CESMDIR=/glade/work/glydia/cesm_tags/cesm2.1.5
set MODSDIR=/glade/u/home/glydia/mods

# Set array variables for looping through ensemble members
set NNN_arr=( 001 002 003 )

## Loop through all ensemble members
foreach i ( 1 2 3 )
	## Set option variables specific to ensemble member
	# Set ensemble number case name
	set NNN=$NNN_arr[$i]
	set CASENAME=${COMPSET_SHORT}.e21.${COMPSET}.${RES}.${CASETITLE}.${NNN}
	set REFCASENAME=${REFCASE}${NNN}
	echo $CASENAME

	# Set case path variable
	set CASEDIR=/glade/u/home/glydia/derecho_cases/$CASENAME

	## If CONTINUE_RUN is false
	if ($CONT_RUN == FALSE) then
		## Create case
		cd $CESMDIR/cime/scripts

		./create_newcase --case $CASEDIR --res $RES --compset $COMPSET --project $PROJ --run-unsupported

		cd $CASEDIR

		## Do XMLCHANGE options here

		# Optimize run
		cp $MODSDIR/env_mach_pes.xml .
		cp $MODSDIR/env_build.xml .

		# Runtime variables
		./xmlchange STOP_OPTION="nyears",RESUBMIT=0,STOP_N=5,JOB_WALLCLOCK_TIME=10:57:00,REST_N=5,REST_OPTION="nyears",CONTINUE_RUN=$CONT_RUN
		./xmlquery STOP_OPTION,RESUBMIT,STOP_N,JOB_WALLCLOCK_TIME,REST_N,REST_OPTION,CONTINUE_RUN

		# Any other xmlchanges...
		./xmlchange RUN_TYPE=hybrid,RUN_REFCASE=$REFCASENAME,RUN_REFDATE=$REFDATE,GET_REFCASE=FALSE,CLM_NAMELIST_OPTS='',RUN_STARTDATE=$STARTDATE
		./xmlquery RUN_TYPE,RUN_REFCASE,RUN_REFDATE,RUN_STARTDATE

		./xmlchange CICE_MXBLCKS=2,CICE_BLCKX=5,CICE_BLCKY=96,CICE_DECOMPTYPE="cartesian",CICE_DECOMPSETTING="slenderX2"
		./xmlquery CICE_AUTO_DECOMP,CICE_MXBLCKS,CICE_BLCKX,CICE_BLCKY,CICE_DECOMPTYPE,CICE_DECOMPSETTING

		## Setup case
		./case.setup

		# Copy restart files
		cp $REFDIR/$REFCASENAME/rest/$REFDATE-00000/* /glade/derecho/scratch/$USER/$CASENAME/run/

		## Do NAMELIST modifications here
		cp /glade/u/home/glydia/derecho_case_scripts/namelists/NN_LM/user_nl_cam .
		cp /glade/u/home/glydia/derecho_case_scripts/namelists/NN_LM/user_nl_clm .
		cp /glade/u/home/glydia/derecho_case_scripts/namelists/NN_LM/user_nl_cice .
		cp /glade/u/home/glydia/derecho_case_scripts/namelists/NN_LM/user_nl_pop .

		./preview_namelists

		## Build case
		qcmd -- ./case.build

		## Submit case to queue
		./case.submit
	endif

	## If CONTINUE_RUN is true
	if ($CONT_RUN == TRUE) then
		cd $CASEDIR

		cp /glade/u/home/glydia/derecho_case_scripts/namelists/NN_LM/user_nl_cam .

		# Do XMLCHANGE options for CONTINUE_RUN
		./xmlquery JOB_QUEUE,JOB_WALLCLOCK_TIME
		./xmlchange JOB_WALLCLOCK_TIME=4:00:00
		./xmlquery JOB_QUEUE,JOB_WALLCLOCK_TIME

		# Do XMLCHANGE options for CONTINUE_RUN - 5 years - adjust stop_n/rest_n/resubmit based on 
		./xmlquery STOP_N,STOP_OPTION,RESUBMIT,REST_N,CONTINUE_RUN
		./xmlchange STOP_N=5,STOP_OPTION="nyears",RESUBMIT=0,REST_N=5,REST_OPTION="nyears",CONTINUE_RUN=$CONT_RUN
		./xmlquery STOP_N,STOP_OPTION,RESUBMIT,REST_N,REST_OPTION,CONTINUE_RUN

		./preview_namelists

		./case.submit

	endif

end
