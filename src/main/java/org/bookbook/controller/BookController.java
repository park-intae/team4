package org.bookbook.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.bookbook.domain.BookSearchVO;
import org.bookbook.domain.GenreVO;
import org.bookbook.domain.TopicVO;
import org.bookbook.service.BookSearchService;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/")
@Controller
public class BookController {
    @Autowired
    BookSearchService service;

    @ModelAttribute("searchBook")
    public JSONObject searchBookTypes(TopicVO topics, GenreVO genres) {
        List<TopicVO> topicList = service.getTopicList(topics);

        List<GenreVO> genreList = service.getGenreList(genres);

        Map<String, List<String>> genreConvertedMap = convertToMap(genreList);

        // log.info(genreConvertedMap);

        Map<String, Map<String, List<String>>> map = new LinkedHashMap<>();

        // log.info(topicList);

        for (TopicVO topic : topicList) {
            Map<String, List<String>> genreMap = new LinkedHashMap<>();

            String genreToString = topic.getGenres();

            // 초기 용량 설정을 통한 성능 최적화
            List<String> genreToList = new ArrayList<>(Arrays.asList(genreToString.split(", ")));

            for (String genre : genreToList) {
                // 불필요한 객체 생성 최적화
                // genre = genre.trim();
                log.info("----->---->" + genre);
                List<String> categoriesToList = genreConvertedMap.get(genre);

                log.info("----------------->" + categoriesToList);

                // 이미 있는 리스트를 재활용하여 새로운 리스트를 생성하지 않도록 최적화
                if (categoriesToList == null) {
                    categoriesToList = new ArrayList<>();
                }

                genreMap.put(genre, categoriesToList);
            }

            map.put(topic.getTopic(), genreMap);
        }

        JSONObject jsonObject = new JSONObject(map);

        return jsonObject;
    }

    public static Map<String, List<String>> convertToMap(List<GenreVO> genreList) {
        Map<String, List<String>> genreMap = new HashMap<>();

        for (GenreVO genreVO : genreList) {
            String genre = genreVO.getGenre();
            String categoriesToString = genreVO.getCategories();

            List<String> categoriesList = new ArrayList<>();

            if (categoriesToString != null) {
                categoriesList = new ArrayList<String>(Arrays.asList(categoriesToString.split(", ")));
            }

            // log.info("------->>>"+categoriesList);

            genreMap.put(genre, categoriesList);
        }

        // log.info("--------------------->>>>>"+ genreMap);

        return genreMap;
    }

    @GetMapping("/list")
    public void list(@ModelAttribute("search") BookSearchVO search,
            Model model) {
        log.info("list Page");
        log.info(search);
        model.addAttribute("list", service.getBookList(search));
        // log.info(model);

    }
}
