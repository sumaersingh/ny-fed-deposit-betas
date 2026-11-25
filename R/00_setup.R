# 00_setup.R
# Loads packages, defines every path the project uses, and creates the
# output folders. Every other script starts by sourcing this file, so paths
# are defined in one place only. No data work happens here.

# ---- Check the working directory -------------------------------------------
# All paths below are relative to the project root. Opening
# ny-fed-deposit-betas.Rproj in RStudio sets the working directory to the
# root. We check for run_all.R as a marker so a wrong working directory fails
# loudly here, not later with a confusing "file not found".
if (!file.exists("run_all.R")) {
  stop("Working directory is not the project root. ",
       "Open ny-fed-deposit-betas.Rproj in RStudio and try again.")
}

# ---- Packages ---------------------------------------------------------------
# data.table and ggplot2 are used in almost every script, so we attach them.
library(data.table)
library(ggplot2)

# These are needed later (haven for the NY Fed fallback panel, fixest and
# modelsummary for Phase 10). We only check they are installed, without
# attaching them, so they do not slow down every run. Naming each one in its
# own requireNamespace() call also lets renv find them and record them in
# renv.lock. If one is missing, run renv::restore().
stopifnot(
  requireNamespace("haven", quietly = TRUE),
  requireNamespace("fixest", quietly = TRUE),
  requireNamespace("modelsummary", quietly = TRUE)
)

# ---- Paths ------------------------------------------------------------------
paths <- list(
  raw_ffiec = file.path("data", "raw", "ffiec"),
  raw_fred  = file.path("data", "raw", "fred"),
  clean     = file.path("data", "clean"),
  figures   = file.path("output", "figures"),
  tables    = file.path("output", "tables")
)

# data/raw and data/clean are gitignored, so a fresh clone does not have
# them. Create any that are missing. showWarnings = FALSE keeps this quiet
# when the folder already exists.
for (p in paths) dir.create(p, recursive = TRUE, showWarnings = FALSE)

# ---- Helpers ----------------------------------------------------------------
# Shared helper functions go here as later scripts need them.

message("Setup done. Working directory: ", getwd())
