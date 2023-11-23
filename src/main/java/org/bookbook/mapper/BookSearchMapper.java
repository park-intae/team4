package org.bookbook.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.bookbook.domain.BookSearchVO;
import org.bookbook.domain.BookVO;
import org.bookbook.domain.GenreVO;
import org.bookbook.domain.TopicVO;

@Mapper
public interface BookSearchMapper {

	public List<BookVO> read(BookSearchVO bookSearch);
	
	public List<TopicVO> getTopic(TopicVO topic);
	
	public List<GenreVO> getGenre(GenreVO genre);
}
