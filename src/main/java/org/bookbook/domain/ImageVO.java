package org.bookbook.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class ImageVO {
	private int book_id;
    private String imageUrl;
}
