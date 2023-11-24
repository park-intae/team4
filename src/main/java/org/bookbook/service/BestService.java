package org.bookbook.service;

import java.util.List;

import org.bookbook.domain.BestVO;
import org.bookbook.domain.Criteria;

public interface BestService {
	public List<BestVO> getList(Criteria cri);
	public int getTotalCount(Criteria cri);
	public BestVO get(int column1);
	public int getTotal(Criteria cri);
}
