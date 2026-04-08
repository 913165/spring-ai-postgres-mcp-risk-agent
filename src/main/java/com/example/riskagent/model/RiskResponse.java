package com.example.riskagent.model;

import java.time.Instant;

public record RiskResponse(
        String question,
        String summary,
        Instant generatedAt
) {
}
