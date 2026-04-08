package com.example.riskagent.ui;

import com.example.riskagent.model.RiskResponse;
import com.example.riskagent.service.RiskAgentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RiskUiController {

    private final RiskAgentService riskAgentService;

    public RiskUiController(RiskAgentService riskAgentService) {
        this.riskAgentService = riskAgentService;
    }

    // Serve the home page — model is empty on first load
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("question", "");
        model.addAttribute("response", null);
        model.addAttribute("error", null);
        return "index";
    }

    // Handle form submission from the UI
    @PostMapping("/ask")
    public String ask(@RequestParam("question") String question, Model model) {
        model.addAttribute("question", question);

        if (question == null || question.isBlank()) {
            model.addAttribute("error", "Please enter a risk question.");
            return "index";
        }

        try {
            RiskResponse response = riskAgentService.analyzeRisk(question);
            model.addAttribute("response", response);
        } catch (Exception e) {
            model.addAttribute("error", "Error: " + e.getMessage());
        }
        return "index";
    }
}
