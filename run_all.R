# run_all.R
# Rebuilds every table and figure from the raw files in data/raw/.
# Run it from a fresh R session with the project open in RStudio.
# The Python download step is separate and is not run from here.

source(file.path("R", "00_setup.R"))

# Each later wave adds one line here, in this order:
# source(file.path("R", "01_read_raw.R"))
# source(file.path("R", "02_ytd_fix.R"))
# source(file.path("R", "03_aggregate.R"))
# source(file.path("R", "04_fed_funds.R"))
# source(file.path("R", "05_betas.R"))
# source(file.path("R", "06_figures.R"))
# source(file.path("R", "07_validate.R"))
