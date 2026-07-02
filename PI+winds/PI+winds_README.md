# PI+winds

The PI+winds experiment was run using CESM release tag 'release-cesm2.1.5' on Derecho. Ensemble members were initialized at 2024-01-01 from the corresponding ensemble member in PInudge-lessmelt (i.e. PI+winds member 1 initialized from PInudge-lessmelt member 1). PInudge-lessmelt was described and run in Gilbert et al. 2025 (DOI: [10.1088/2752-5295/ae11cb](https://doi.org/10.1088/2752-5295/ae11cb)). PI+winds is PInudge-lessmelt extended by one year and `create_cesm_run_N1_LM2006.csh` sets up and runs that additional year.

## Directories

- namelists: namelists from PI+winds ensemble member 1
- SourceMods: modified Fortran files used in PI+winds ensemble member 1

## Code files

- `create_cesm_run_N1_LM2006.csh`