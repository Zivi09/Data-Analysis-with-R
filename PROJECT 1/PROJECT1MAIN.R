
Year <- c(rep(2020, 4), rep(2021, 4), rep(2022, 4))
Quarter <- rep(c("Q1","Q2","Q3","Q4"), 3)
Production <- c(350,420,390,460, 480,530,510,560, 590,610,580,630)

production_data  <- data.frame(Year, Quarter, Production)
print("=== Production Dataset ===")
print(production_data )

mean_value <- mean(production_data $Production)
median_value <- median(production_data $Production)

# Mode function (custom, because R has no built-in mode)
get_mode <- function(x) {
  unique_x <- unique(x)
  unique_x[which.max(tabulate(match(x, unique_x)))]
}
mode_value <- get_mode(production_data$Production)

cat("\n=== Measures of Central Tendency ===\n")
cat("Mean Production:", mean_value, "\n")
cat("Median Production:", median_value, "\n")
cat("Mode Production:", mode_value, "\n")


production_data $TimeIndex <- 1:nrow(production_data )           
model <- lm(Production ~ TimeIndex, data = production_data )

# Predict next 4 quarters
future_index <- data.frame(TimeIndex = (nrow(production_data )+1):(nrow(production_data )+4))
future_predictions <- predict(model, future_index)

cat("\n=== Forecast for Next 4 Quarters ===\n")
for (i in 1:4) {
  cat(paste("Quarter", i, ": Estimated Production =", round(future_predictions[i], 2), "\n"))
}

plot(production_data $TimeIndex, production_data $Production, type="o", pch=16, lwd=2,
     xlab="Time (Quarter)", ylab="Production (units)",
     main="Quarterly Production Trend — Annual Report")
grid()
