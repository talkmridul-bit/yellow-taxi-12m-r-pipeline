# 🎲 BoardGame 26M+ Rating Data Pipeline

> **Zero-Cost, Memory-Aware R Data Pipeline & User Aggregation Engine for 26.2M+ Ratings on Constrained Hardware (4GB RAM)**

[![R](https://img.shields.com/badge/R-4.6.1-276DC3.svg?style=flat&logo=r)](https://www.r-project.org/)
[![Tidyverse](https://img.shields.com/badge/Tidyverse-readr%20%7C%20dplyr-13B5EA.svg?style=flat)](https://www.tidyverse.org/)
[![Hardware Constraint](https://img.shields.com/badge/Hardware-4GB%20RAM%20%7C%20i3%201.2GHz-FF6F61.svg?style=flat)]()
[![Cloud Cost](https://img.shields.com/badge/Cloud%20Cost-%240.00-34D399.svg?style=flat)]()
[![Row Reduction](https://img.shields.com/badge/Row%20Compression-97.88%25-8B5CF6.svg?style=flat)]()

---

## 📌 Repository Description (For GitHub)

`Memory-efficient R data pipeline built with Tidyverse (readr, dplyr) to clean, type-cast, and aggregate 26.2M+ BoardGameGeek ratings into 555,482 user profiles on 4GB RAM at $0 cloud cost.`

---

## 🚀 Overview

High-scale data processing typically demands expensive cloud infrastructure or multi-node clusters. This project demonstrates **resource-conscious data engineering** by building an end-to-end data pipeline in **R** that processes **26,200,012 raw board game rating observations** on an entry-level laptop with **4GB total RAM** and an **Intel Core i3 (1.2GHz)** processor.

Through early 32-bit integer casting, non-positive key filtering, and in-memory `dplyr` user-level grouping, the pipeline shrinks raw unstructured logs into **555,482 compressed user profiles** (a **97.88% reduction**) while keeping memory usage under **1.6 GiB**.

---

## 📊 Key Performance Benchmarks

| Metric | Raw Ingestion | Processed Summary Output | Efficiency / Savings |
| :--- | :--- | :--- | :--- |
| **Row Count** | `26,200,012` rows | `555,482` user profiles | **97.88% Row Compression** |
| **File Size / Footprint** | ~1.6 GiB raw memory | `15.1 MB` CSV export | **99% Disk Space Saved** |
| **Peak RAM Allocation** | 4GB Physical Limit | `1.6 GiB` R Workspace | **40% Memory Footprint Ceiling** |
| **Infrastructure Spend** | Cloud Clusters ($$) | Bare-Metal Local Machine | **$0.00 Total Expenditure** |

---

## 🛠️ System Architecture

```
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│   Raw Ingest    │  ───> │  Tidy Cleaning  │  ───> │   User Rollup   │  ───> │   CSV Export    │
│  26.2M CSV Rows │       │ 32-Bit Casting  │       │ 555k Aggregation│       │  15.1 MB File   │
└─────────────────┘       └─────────────────┘       └─────────────────┘       └─────────────────┘
    readr::read_csv          as.integer()              group_by(user)            write.csv()
                             distinct() & filter()     summarise()               row.names = FALSE
```

---

## 💻 Hardware Constraints & Memory Ceiling

- **Processor:** Intel Core i3 @ 1.2GHz (Entry-level local tier)
- **Physical RAM:** 4.0 GB total
- **OS Overhead:** Windows 10 OS (~2.0 GB shared memory footprint)
- **Available R Memory Buffer:** ~2.0 GB maximum allocation ceiling
- **Environment Peak Usage:** **1.6 GiB** (verified in RStudio telemetry)

---

## 📜 R Pipeline Code

```r
# ==============================================================================
# Pipeline: Boardgame 26M+ Rating Data Engine
# Developer: Niaz Mohammad Shoyab
# Environment: R 4.6.1 / Tidyverse
# Constraint: 4GB RAM bare-metal execution
# ==============================================================================

library(tidyverse)
library(readr)

# 1. Ingest raw 26.2M dataset
data_raw <- read_csv(file.choose())

# 2. Tidy Cleaning & 32-Bit Type-Casting (Memory Reduction)
final_boardgame_26M_rating_data <- data_raw %>%
  distinct() %>%
  mutate(
    rating = as.integer(rating),
    ID     = as.integer(ID)
  ) %>%
  filter(
    rating > 0 & ID > 0,
    !is.na(user), 
    !is.na(rating), 
    !is.na(ID)
  ) %>%
  # 3. User Aggregation & Rollup
  group_by(user) %>%
  summarise(
    Avg_Rating   = mean(rating, na.rm = TRUE),
    Unique_games = n_distinct(ID),
    Total_rating = n(),
    .groups      = 'drop'
  ) %>%
  arrange(desc(Total_rating))

# 4. Lightweight CSV Export for BI & Dashboarding
write.csv(
  final_boardgame_26M_rating_data,
  'Boardgame_26M_rating_data.csv',
  row.names = FALSE
)
```

---

## 💡 Key Analytical Insights Extracted

1. **Power-User VIP Retention:** Top reviewers on the platform logged over **6,800+ game ratings** individually, highlighting key engagement clusters for platform moderation and loyalty targeting.
2. **Rating Bias Calibration:** Heavy scorers display consistent score distributions (averaging between **3.70 – 7.53**), allowing normalization algorithms to calibrate user-level scoring variance.
3. **Zero-Cloud BI Readiness:** Exporting a clean **15.1 MB CSV** allows BI tools (Tableau, Power BI, Excel) to render dashboard visualizations instantly without requiring heavy backend live queries.

---

## 👤 Developer Profile

**Niaz Mohammad Shoyab**  
*Data Analyst & Pipeline Architect*  
*Transitioned from Archaeology at Jahangirnagar University into Data Analytics & Data Engineering.*

- 🔗 **LinkedIn:** [linkedin.com/in/niaz-shoyab-495061b8](https://www.linkedin.com/in/niaz-shoyab-495061b8)
- 🐙 **GitHub:** [github.com/talkmridul-bit](https://github.com/talkmridul-bit)
- ✉️ **Email:** talkmridul@gmail.com

---

## 📄 License
This project is open-source under the [MIT License](LICENSE).