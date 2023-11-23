package org.bookbook.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BookSearchVO {
	private String[] Topics;
	private String[] keywords;
	private String[] bookType;
	private String[] selectedCategories;
}
