package org.bookbook.domain;

import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Data
@Getter
@Setter
public class BookVO {
	private int bookid;
	private String title;
	private String author;
	private String bookintro;
	private String publisher;
	private Date publicationdate;
	private Long isbn;
	private String genre;
	private String category;
	private String Topic;
}
