# 🧬 Scientific Reproducibility: MAGIC Common Bean Population

[![Open Science](https://img.shields.io/badge/Open%20Science-LCF5900-blue)](#)
[![R](https://img.shields.io/badge/Language-R-276DC3)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success)](#)

This repository contains the data, scripts, and reports generated for the **LCF5900 - Open Science and Reproducible Data** course. 

The main objective of this project is to demonstrate the practical viability of scientific reproducibility through the re-analysis of open data. To achieve this, we recreated the phenotypic and genotypic analyses of a MAGIC (*Multiparent Advanced Generation Intercross*) population of common bean (*Phaseolus vulgaris L.*) evaluated under drought conditions.

## 📄 About the Original Study
The entire analytical workflow was based on the raw data publicly shared by the authors of the following peer-reviewed article:
> **Diaz, S., Ariza-Suarez, D., Izquierdo, P. et al. (2020).** *Genetic mapping for agronomic traits in a MAGIC population of common bean (Phaseolus vulgaris L.) under drought conditions.* BMC Genomics 21, 799. 

The original datasets were obtained directly from the **Harvard Dataverse** repository.

## 📂 Repository Structure

This repository is organized to facilitate navigation and code execution:

```text
📦 LCF5900-MAGIC-Bean-Genetics
 ┣ 📂 data               # Raw .csv files downloaded from Harvard Dataverse
 ┃ ┣ 📜 01. MAGIC_raw_data.csv
 ┃ ┣ 📜 03. MAGIC_model_data.csv
 ┃ ┗ 📜 06. MAGIC_genetic_map.csv
 ┣ 📂 scripts            # Pure R scripts for data analysis
 ┃ ┗ 📜 analise_magic.R
 ┣ 📂 report             # Dynamic reports and final outputs
 ┃ ┣ 📜 MAGIC_Report.Rmd # Full workflow in RMarkdown
 ┃ ┣ 📜 MAGIC_Report.pdf # Final report (PDF format)
 ┃ ┗ 📜 MAGIC_Report.html# Interactive report (HTML format)
 ┗ 📜 README.md          # This file
```
## 📊 Analyses Performed

1. **Descriptive analysis:** boxplots of the effect of environmental variance (harvest years) on grain yield and seed weight.
2. **Phenotypic correlations (BLUPs):** Pearson correlation matrices showing trade-offs between phenology, yield and micronutrient accumulation (iron and zinc).
3. **Drought escape mechanism:** linear regression showing the negative relationship between days to flowering and yield under terminal drought.
4. **Principal Component Analysis (PCA):** multivariate biplot of all traits to understand survival and biofortification strategies.
5. **Genetic map density:** physical distribution of SNPs across the 11 common bean chromosomes.
6. **Genetic selection:** ranking of the top 15 elite, high-yielding genotypes.

## 🚀 How to Reproduce

1. Clone this repository:
   ```bash
   git clone https://github.com/raruizc/LCF5900-MAGIC-Bean-Genetics.git
   ```
2. Install the R packages:
   ```r
   install.packages(c("tidyverse", "corrplot", "viridis", "gridExtra", "factoextra"))
   ```
3. Open `report/MAGIC_Report.Rmd` in RStudio and click **Knit**, or run `scripts/analise_magic.R` line by line. Data paths are relative, so set the working directory to the project root.

## 📚 Data Sources and References

Full credit goes to the original authors for publishing their data openly:

- **Original article:** Diaz, S., Ariza-Suarez, D., Izquierdo, P. et al. (2020). *BMC Genomics* 21, 799. [doi:10.1186/s12864-020-07213-6](https://doi.org/10.1186/s12864-020-07213-6)
- **Dataset (Harvard Dataverse):** [doi:10.7910/DVN/JR4X4C](https://doi.org/10.7910/DVN/JR4X4C)

## 👥 Authorship

Team 04, Open Science class, LCF5900 course (ESALQ/USP, 2026). Repository maintained by **Ricardo Antonio Ruiz-Cardozo**.

Code released under the [MIT License](LICENSE). Data keep their original license.
