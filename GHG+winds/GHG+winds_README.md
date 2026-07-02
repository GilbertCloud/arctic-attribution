# GHG+winds

The GHG+winds experiment was run using CESM release tag 'release-cesm2.1.5' on Derecho. Ensemble members were initialized at 2024-01-01 from the corresponding ensemble member in PI+winds (i.e. GHG+winds member 1 initialized from PI+winds member 1). GHG+winds is composed of two separate CESM experiments: GHG_UVnudge_LM (1950-2014) and GHG_UVnudgeLM2015 (2015-2024). GHG_UVnudge_LM runs were set up and run using `create_cesm_run_N2_GHGLM.csh`. GHG_UVnudge_LM2015 was initialized from GHG_UVnudge_LM and set up and run using `create_cesm_run_N2_GHGLM2015.csh`.

## Directories

- namelists: namelists for GHG+winds
    - hist-ghg: namelists from GHG_UVnudge_LM ensemble member 1
    - ssp370-ghg: namelists from GHG_UVnudge_LM2015 ensemble member 1
- SourceMods: modified Fortran files used in GHG+winds

## Code files

- `create_cesm_run_N2_GHGLM.csh`
- `create_cesm_run_N2_GHGLM2015.csh`