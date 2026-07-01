# arctic-attribution

[![DOI](https://zenodo.org/badge/1286435231.svg)](https://zenodo.org/badge/latestdoi/1286435231)

This repository contains the run scripts, namelists, and code modifications for all of the experiments in the paper "Internal and anthropogenic contributions to recent (1950-2024) Arctic temperature and sea ice change" by Ash L. Gilbert, Jennifer E. Kay, and Edward Blanchard-Wrigglesworth submitted to _Environmental Research: Climate_.

For information about creating the ERA5 reanalysis files for wind nudging, see https://github.com/GilbertCloud/ERA5_CESM2_nudgingfiles.

Created by Ash Gilbert (ash.gilbert@colorado.edu) and contact them for any questions.

## Structure

All folders contain their own READMEs with more detail

- PI+winds: contains the run scripts, namelists, and code modifications for the PI+winds runs
- GHG+winds: contains the run scripts, namelists, and code modifications for the GHG+winds runs
- HIST+winds: contains the run scripts, namelists, and code modifications for the HIST+winds runs
- processing_code: contains all Jupyter notebooks for processing single-variable timeseries to plottable data 
- plotting_code: contains all Jupyter notebooks for making paper plots 