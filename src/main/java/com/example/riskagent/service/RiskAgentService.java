package com.example.riskagent.service;

import com.example.riskagent.agent.RiskAgentClient;
import com.example.riskagent.model.RiskResponse;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
public class RiskAgentService {

    private final RiskAgentClient riskAgentClient;

    public RiskAgentService(RiskAgentClient riskAgentClient) {
        this.riskAgentClient = riskAgentClient;
    }

    public RiskResponse analyzeRisk(String question) {
        String summary = riskAgentClient.analyzeRisk(question);
        return new RiskResponse(question, summary, Instant.now());
    }
}
