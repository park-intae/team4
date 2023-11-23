package org.bookbook.service;

import java.util.List;

import org.bookbook.domain.BookSearchVO;
import org.bookbook.domain.BookVO;
import org.bookbook.domain.GenreVO;
import org.bookbook.domain.TopicVO;

public interface BookSearchService {
    public List<BookVO> getBookList(BookSearchVO bookSearch);

    public List<TopicVO> getTopicList(TopicVO topic);

    public List<GenreVO> getGenreList(GenreVO genre);
}