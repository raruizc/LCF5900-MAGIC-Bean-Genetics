# ==============================================================================
# Analytic Report: MAGIC Bean Population (Harvard Dataverse)
# Author: Ricardo Antonio Ruiz Cardozo
# Course: LCF5900 - Open Science and Reproducible Data
# Date: 2026-06-21
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. INTRODUCTION & SETUP
# This document reflects the complete workflow of open data analysis for the 
# LCF5900 course. Here, we reproduce the phenotypic and genotypic analysis of 
# the MAGIC common bean population (Phaseolus vulgaris L.) based on Diaz et al. (2020).
# ------------------------------------------------------------------------------

# Memory Cleanup
rm(list=ls(all=TRUE))
gc()

# Loading essential packages (added factoextra for PCA visualization)
required_packages <- c("tidyverse", "corrplot", "viridis", "gridExtra", "factoextra")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

library(tidyverse)
library(corrplot)
library(viridis)
library(gridExtra)
library(factoextra)

# ------------------------------------------------------------------------------
# 2. DATA IMPORT (Directly from GitHub)
# We load the raw field data, modeled genotypic effects (BLUPs), and the genetic 
# map structure obtained from the Harvard Dataverse repository via GitHub to 
# ensure full reproducibility.
# ------------------------------------------------------------------------------

# Defining the base URL of the GitHub repository (data folder)
url_base <- "https://raw.githubusercontent.com/raruizc/LCF5900-MAGIC-Bean-Genetics/main/data/"

# Building direct links for each CSV file
url_raw_data <- paste0(url_base, "01.%20MAGIC_raw_data.csv")
url_model_data <- paste0(url_base, "03.%20MAGIC_model_data.csv")
url_map_data <- paste0(url_base, "06.%20MAGIC_genetic_map.csv")

# Importing data directly from the web
dados_brutos <- read_csv(url_raw_data, na = c("NA", "", " "), show_col_types = FALSE)

# Reading modeled estimates (BLUPs/BLUEs) and cleaning column names
dados_modelados <- read_csv(url_model_data, na = c("NA", "", " "), show_col_types = FALSE) %>% 
  rename_with(trimws) 

# Reading genetic map structure
mapa_genetico <- read_csv(url_map_data, na = c("NA", "", " "), show_col_types = FALSE)


# ------------------------------------------------------------------------------
# 3. DESCRIPTIVE ANALYSIS: AGRONOMIC TRAITS ACROSS YEARS
# We evaluate the impact of environmental variance across harvest years on 
# crucial agronomic variables: Grain Yield (Yd) and 100-Seed Weight (100SdW).
# ------------------------------------------------------------------------------

# Plot 1: Yield (Yd) Boxplot
g1 <- dados_brutos %>% 
  filter(!is.na(Yd), !is.na(Year)) %>% 
  mutate(Year = as.factor(Year)) %>% 
  ggplot(aes(x = Year, y = Yd, fill = Year)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.7, color = "#2c3e50") +
  geom_jitter(width = 0.15, alpha = 0.15, color = "#7f8c8d") +
  scale_fill_viridis(discrete = TRUE, option = "viridis") +
  labs(
    title = "Grain Yield Distribution by Year",
    subtitle = "MAGIC population under drought conditions",
    x = "Harvest Year",
    y = "Yield (Yd, kg/ha)"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none", panel.grid.minor = element_blank())

# Plot 2: 100 Seed Weight Boxplot
g2 <- dados_brutos %>% 
  filter(!is.na(`100SdW`), !is.na(Year)) %>% 
  mutate(Year = as.factor(Year)) %>% 
  ggplot(aes(x = Year, y = `100SdW`, fill = Year)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.7, color = "#2c3e50") +
  geom_jitter(width = 0.15, alpha = 0.15, color = "#7f8c8d") +
  scale_fill_viridis(discrete = TRUE, option = "magma") +
  labs(
    title = "100-Seed Weight by Year",
    subtitle = "Grain size stability indicator",
    x = "Harvest Year",
    y = "100-Seed Weight (g)"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none", panel.grid.minor = element_blank())

# Rendering plots side by side
grid.arrange(g1, g2, ncol = 2)

# INTERPRETATION: The series reveals strong environmental oscillation. The year 2013 
# exhibits a wider dispersion and altered averages compared to the subsequent years, 
# highlighting the direct impact of the drought stress severity on yield components.


# ------------------------------------------------------------------------------
# 4. CORRELATION ANALYSIS: PHENOTYPIC TRAITS (BLUPs)
# To understand trait correlations (essential for crop breeding), we use the 
# BLUP values estimated for 2014 and 2013.
# ------------------------------------------------------------------------------

### --- Year 2014 Data ---
# NOTE: 'PHI' was removed because it was not evaluated in 2014 (100% NA).
# Instead, we added Iron (SdFe) and Zinc (SdZn) concentrations.
df_cor_2014 <- dados_modelados %>% 
  filter(Method == "BLUP", Year == 2014) %>% 
  select(DF, DPM, `100SdW`, Yd, SdFe, SdZn) %>% 
  mutate(across(everything(), as.numeric)) %>% 
  drop_na()

# Calculating and plotting Pearson correlation matrix
matriz_cor_2014 <- cor(df_cor_2014, use = "complete.obs")

corrplot.mixed(
  matriz_cor_2014,
  lower = "number", 
  upper = "color",
  tl.col = "black",
  tl.pos = "lt",
  diag = "n",
  bg = "transparent",
  lower.col = "black",
  number.cex = 0.9,
  upper.col = colorRampPalette(c("#e74c3c", "#ffffff", "#2980b9"))(200)
)

# INTERPRETATION (2014): There is a notable correlation between Iron (SdFe) and 
# Zinc (SdZn) accumulation in the seeds, suggesting breeding strategies could 
# simultaneously improve both micronutrients.

### --- Year 2013 Data ---
df_cor_2013 <- dados_modelados %>% 
  filter(Method == "BLUP", Year == 2013) %>% 
  select(DF, DPM, `100SdW`, PHI, Yd) %>% 
  mutate(across(everything(), as.numeric)) %>% 
  drop_na()

# Calculating and plotting Pearson correlation matrix
matriz_cor_2013 <- cor(df_cor_2013, use = "complete.obs")

corrplot.mixed(
  matriz_cor_2013,
  lower = "number", 
  upper = "color",
  tl.col = "black",
  tl.pos = "lt",
  diag = "n",
  bg = "transparent",
  lower.col = "black",
  number.cex = 0.9,
  upper.col = colorRampPalette(c("#e74c3c", "#ffffff", "#2980b9"))(200)
)

# INTERPRETATION (2013): Days to Flowering (DF) and Days to Physiological Maturity (DPM) 
# are highly correlated. Final Grain Yield (Yd) shows a strong positive association 
# with the Pod Harvest Index (PHI).


# ------------------------------------------------------------------------------
# 5. GENETIC MAP STRUCTURE ANALYSIS
# Visualizing the physical distribution of SNPs across the common bean genome.
# ------------------------------------------------------------------------------

plot_map <- mapa_genetico %>% 
  filter(!is.na(Chromosome)) %>% 
  ggplot(aes(x = Chromosome, fill = Chromosome)) +
  geom_bar(color = "#2c3e50", alpha = 0.8) +
  scale_fill_viridis(discrete = TRUE, option = "mako") +
  labs(
    title = "Molecular Marker Density per Chromosome",
    subtitle = "Total SNPs mapped in the MAGIC Population (Phaseolus vulgaris)",
    x = "Chromosomes (Reference Genome V2.1)",
    y = "Number of Markers (SNPs)"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),
    panel.grid.minor = element_blank()
  )

print(plot_map)

# INTERPRETATION: Highlights the successful genome-wide coverage achieved by the 
# GBS methodology used in this study, providing a robust framework for identifying QTLs.


# ------------------------------------------------------------------------------
# 6. DROUGHT ESCAPE MECHANISM: PHENOLOGY VS. YIELD
# Assessing the hypothesis by plotting Days to Flowering (DF) against Yield (Yd).
# ------------------------------------------------------------------------------

df_escape <- dados_modelados %>% 
  filter(Method == "BLUP", Year == 2014) %>% 
  select(Line, DF, Yd) %>% 
  drop_na()

plot_escape <- ggplot(df_escape, aes(x = DF, y = Yd)) +
  geom_point(alpha = 0.6, color = "#2980b9", size = 2.5) +
  geom_smooth(method = "lm", color = "#e74c3c", se = TRUE, alpha = 0.2) +
  labs(
    title = "Assessing Drought Escape (2014 Data)",
    subtitle = "Relationship between Flowering Time (DF) and Grain Yield (Yd)",
    x = "Days to Flowering (DF)",
    y = "Estimated Yield (Yd, BLUP in kg/ha)"
  ) +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold"))

print(plot_escape)

# INTERPRETATION: There is a negative association between flowering time and yield; 
# bean lines that flowered earlier (lower DF) tended to maintain higher productivity 
# under the stress conditions of 2014 (Drought escape).


# ------------------------------------------------------------------------------
# 7. MULTIVARIATE ANALYSIS (PCA) OF GENOTYPIC VALUES
# Principal Component Analysis (PCA) on the BLUP values from the 2014 trial.
# ------------------------------------------------------------------------------

# Preparing data for PCA
df_pca <- dados_modelados %>% 
  filter(Method == "BLUP", Year == 2014) %>% 
  select(Line, DF, DPM, `100SdW`, Yd, SdFe, SdZn) %>% 
  drop_na() %>% 
  column_to_rownames(var = "Line")

# Computing PCA
pca_res <- prcomp(df_pca, scale. = TRUE)

# Visualizing PCA Biplot using factoextra
plot_pca <- fviz_pca_biplot(pca_res, 
                            repel = TRUE, 
                            col.var = "#e74c3c", 
                            col.ind = "#34495e", 
                            alpha.ind = 0.5,
                            title = "PCA Biplot: Multivariate Trait Associations (2014 BLUPs)",
                            xlab = paste0("Dim 1 (", round(summary(pca_res)$importance[2,1]*100, 1), "%)"),
                            ylab = paste0("Dim 2 (", round(summary(pca_res)$importance[2,2]*100, 1), "%)")) +
  theme_minimal()

print(plot_pca)


# ------------------------------------------------------------------------------
# 8. BREEDING SELECTION: TOP PERFORMING GENOTYPES
# Ranking genotypes based on BLUP Estimated Breeding Values for Grain Yield.
# ------------------------------------------------------------------------------

# Selecting the top 15 genotypes
top_lines <- dados_modelados %>% 
  filter(Method == "BLUP", Year == 2014) %>% 
  select(Line, Yd) %>% 
  drop_na() %>% 
  arrange(desc(Yd)) %>% 
  slice_head(n = 15)

plot_selection <- ggplot(top_lines, aes(x = reorder(Line, Yd), y = Yd)) +
  geom_col(fill = "#27ae60", alpha = 0.85) +
  coord_flip() +
  geom_text(aes(label = round(Yd, 1)), hjust = -0.15, size = 3.5, fontface = "bold", color = "#2c3e50") +
  labs(
    title = "Top 15 MAGIC Lines for Drought Tolerance (2014)",
    subtitle = "Ranking based on BLUP Estimated Breeding Values for Grain Yield",
    x = "Genotype (MAGIC Line)",
    y = "Estimated Breeding Value for Yield (kg/ha)"
  ) +
  theme_minimal(base_size = 12) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  theme(plot.title = element_text(face = "bold"))

print(plot_selection)

# INTERPRETATION: The genotype MGC_215 stands out as the highest-yielding line 
# under the 2014 drought conditions. Ranking genotypes based on BLUPs ensures 
# that environmental noise is filtered out.


# ==============================================================================
# CONCLUSION & REFERENCES
# ==============================================================================
# The successful reconstruction of this entire analytical workflow demonstrates 
# the fundamental power of Open Science. By utilizing publicly available datasets 
# from the Harvard Dataverse, we verified the original findings and showcased a 
# complete, reproducible pipeline for agro-genomic research.
#
# Original Article: Diaz, S., Ariza-Suarez, D., Izquierdo, P. et al. (2020). 
# Genetic mapping for agronomic traits in a MAGIC population of common bean 
# under drought conditions. BMC Genomics 21, 799. 
# DOI: https://doi.org/10.1186/s12864-020-07213-6
#
# Open Data Repository: Harvard Dataverse. 
# DOI: https://doi.org/10.7910/DVN/JR4X4C
# ==============================================================================