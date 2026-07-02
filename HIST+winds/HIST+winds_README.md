# HIST+winds

The HIST+winds experiment was run using CESM release tag 'release-cesm2.1.5' on Derecho. Ensemble members were initialized at 2024-01-01 from the corresponding ensemble member in PI+winds (i.e. HIST+winds member 1 initialized from PI+winds member 1). HIST+winds is composed of two separate CESM experiments: BHISTsmbb.HIST_UVnudge_LM (1950-2014) and BSSP370smbb.HIST_UVnudge_LM (2015-2024). BHISTsmbb.HIST_UVnudge_LM runs were set up and run using `create_cesm_run_NN_HISTLM.csh`. BSSP370smbb.HIST_UVnudge_LM was initialized from BHISTsmbb.HIST_UVnudge_LM and set up and run using `create_cesm_run_NN_SSP370LM.csh`.

## Directories

- namelists: namelists from HIST+winds
- SourceMods: modified Fortran files used in HIST+winds

## Code files

- `create_cesm_run_NN_HISTLM.csh`
- `create_cesm_run_NN_SSP370LM.csh`