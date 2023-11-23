package org.bookbook.controller;

import org.bookbook.domain.Criteria;
import org.bookbook.domain.PageDTO;
import org.bookbook.service.BestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/best")
public class BestController {
	@Autowired
	private BestService service;

	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		int total = service.getTotal(cri);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));

	}

	@GetMapping({ "/get" })
	public void get(@RequestParam("column1") int column1, @ModelAttribute("cri") Criteria cri,
			Model model) {
		
		log.info(service.get(column1));
		model.addAttribute("best", service.get(column1));
	}
}
