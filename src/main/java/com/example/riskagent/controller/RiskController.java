package com.example.riskagent.controller;

import com.example.riskagent.service.RiskAgentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/risk")
public class RiskController {

    private final RiskAgentService riskAgentService;

    public RiskController(RiskAgentService riskAgentService) {
        this.riskAgentService = riskAgentService;
    }

    @GetMapping
    public ResponseEntity<?> analyzeRisk(@RequestParam("q") String q) {
        if (q == null || q.isBlank()) {
            return ResponseEntity.badRequest().body("Query parameter 'q' is required");
        }
        return ResponseEntity.ok(riskAgentService.analyzeRisk(q));
    }
}
