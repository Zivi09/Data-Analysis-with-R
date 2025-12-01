# 📊 Production Analysis — Statistics Project

## 📝 Project Overview
This project analyzes the production performance of a firm over **three years (2020–2022)** using **statistical methods** and **forecasting techniques**.

The project includes:
- Dataset creation
- Measures of Central Tendency (Mean, Median, Mode)
- Future production forecasting (next 4 quarters)
- Annual report visualized using a production trend graph

---

## 📂 Dataset Overview

| Year | Quarter | Production |
|------|---------|------------|
| 2020 | Q1 | 350 |
| 2020 | Q2 | 420 |
| 2020 | Q3 | 390 |
| 2020 | Q4 | 460 |
| 2021 | Q1 | 480 |
| 2021 | Q2 | 530 |
| 2021 | Q3 | 510 |
| 2021 | Q4 | 560 |
| 2022 | Q1 | 590 |
| 2022 | Q2 | 610 |
| 2022 | Q3 | 580 |
| 2022 | Q4 | 630 |

---

## 📌 Statistical Results

| Measure | Result |
|--------|--------|
| **Mean** | Average production across 12 quarters |
| **Median** | Middle value in sorted production values |
| **Mode** | Most frequently occurring production value |

---

## 🔮 Forecasting & Prediction
Linear Regression was applied to estimate production for the next **4 quarters**.  
Results indicate whether the firm is expected to **grow or decline** in the upcoming year.

---

## 📈 Annual Report — Graph

The following graph showcases the quarterly trend in production:

![Production Growth Graph](production_graph.png)

> 🔔 Make sure this image is added to the repository root or **images/ folder** so GitHub can load it.

---

## 💻 R Code Used

```r
Year <- c(rep(2020, 4), rep(2021, 4), rep(2022, 4))
Quarter <- rep(c("Q1","Q2","Q3","Q4"), 3)
Production <- c(350,420,390,460, 480,530,510,560, 590,610,580,630)

production_data  <- data.frame(Year, Quarter, Production)
print("=== Production Dataset ===")
print(production_data)

mean_value <- mean(production_data$Production)
median_value <- median(production_data$Production)

get_mode <- function(x) {
  unique_x <- unique(x)
  unique_x[which.max(tabulate(match(x, unique_x)))]
}
mode_value <- get_mode(production_data$Production)

cat("\n=== Measures of Central Tendency ===\n")
cat("Mean Production:", mean_value, "\n")
cat("Median Production:", median_value, "\n")
cat("Mode Production:", mode_value, "\n")

production_data$TimeIndex <- 1:nrow(production_data)
model <- lm(Production ~ TimeIndex, data = production_data)

future_index <- data.frame(TimeIndex = (nrow(production_data)+1):(nrow(production_data)+4))
future_predictions <- predict(model, future_index)

cat("\n=== Forecast for Next 4 Quarters ===\n")
for (i in 1:4) {
  cat(paste("Quarter", i, ": Estimated Production =", round(future_predictions[i], 2), "\n"))
}

plot(production_data$TimeIndex, production_data$Production, type="o", pch=16, lwd=2,
     xlab="Time (Quarter)", ylab="Production (units)",
     main="Quarterly Production Trend — Annual Report")
grid()
