package com.example.riskagent.model;

public record PortfolioRisk(
        String portfolioName,
        Double dailyLoss,
        Double techExposure
) {
}
