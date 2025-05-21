# Time Series Analysis: Power Consumption in Germany

This project explores **time series data** on electricity consumption and renewable energy generation (wind and solar) in Germany using data from the **Open Power System Data (OPSD)** platform. The aim is to analyze trends, identify seasonal patterns, and visualize the variations in power usage over time.

## Project Structure

- **Data Source:** Open Power System Data — time series data including:
  - Electricity Consumption
  - Wind Generation
  - Solar Generation
  - Combined Wind & Solar
- **Time Range:** 2006–2018 (Daily observations)

## Objectives

1. **Clean the dataset**
2. **Analyze patterns and seasonality** (e.g., winter vs. summer usage, weekday vs. weekend trends)
3. **Create visualizations** to uncover insights across multiple time scales:
   - Yearly
   - Monthly
   - Daily

## Tools Used

- **R** for data cleaning, manipulation, and plotting
- **Base R plots** for quick visualizations
- `as.Date()`, `subset()`, `plot()` and other base functions

## Key Analyses

- Created year, month, and day columns from raw date strings for easier filtering and plotting
- Explored long-term trends in electricity consumption and renewable production
- Compared seasonal effects by plotting:
  - **Full series (2006–2018)**
  - **Single year (2017)**
  - **Single month (July 2017)**

### Highlights:

- **Consumption tends to be higher in winter** and lower in summer.
- **Solar generation peaks during summer**, consistent with more sunlight.
- **Wind generation shows variability**, but no clear seasonal pattern.
- **Weekday vs. weekend analysis** showed reduced consumption during weekends.

## Files

- To open the R script and datase, view the other files in the repository

## Future Improvements

- Add decomposition (trend/seasonal/residual) with `ts()` or `forecast` package
- Use `ggplot2` for more elegant, interactive plots
- Automate multi-year or multi-month comparisons
- Incorporate statistical testing (e.g., autocorrelation, stationarity tests)

