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
📊 Analyses Performed
Our R script successfully reproduces the following analytical steps:

1. Descriptive Analysis: Boxplots assessing the impact of environmental variance (harvest years) on Grain Yield and Seed Weight.

2. Phenotypic Correlations (BLUPs): Pearson correlation matrices highlighting the trade-offs between phenology, yield, and micronutrient accumulation (Iron and Zinc).

3. Drought Escape Mechanism: Linear regression modeling proving the negative relationship between days to flowering and final yield under terminal drought stress.

4. Principal Component Analysis (PCA): A multivariate Biplot clustering all traits to understand the overall plant survival and biofortification strategies.

5. Genetic Map Density: Visualization of the physical distribution of SNPs across the 11 chromosomes of the common bean genome.

6. Genetic Selection: Ranking chart identifying the top 15 elite, high-yielding genotypes within the population.

🚀 How to Reproduce
Anyone can audit, run, and expand upon this research. To reproduce the analyses locally:

Clone this repository:

Bash
git clone [https://github.com/YOUR_USERNAME/LCF5900-MAGIC-Bean-Genetics.git](https://github.com/YOUR_USERNAME/LCF5900-MAGIC-Bean-Genetics.git)
Open the MAGIC_Report.Rmd file in RStudio (or the equivalent .R script).

Ensure you have the following R packages installed:

R
install.packages(c("tidyverse", "corrplot", "viridis", "gridExtra", "factoextra"))
Click Knit (if using RMarkdown) or run the script line by line. Since the data paths are relative, the code will run seamlessly as long as your working directory is set to the project root.

📚 Data Sources and References
In full compliance with Open Science principles, we give full credit to the original authors and their initiative to publish the data openly:

Original Article: DOI: [10.1186/s12864-020-07213-6](https://doi.org/10.1186/s12864-020-07213-6)

Dataset (Harvard Dataverse): DOI: https://doi.org/10.7910/DVN/JR4X4C

Authorship & Contributions: Team 04 - Class Open Science | LCF5900 Course (2026)
