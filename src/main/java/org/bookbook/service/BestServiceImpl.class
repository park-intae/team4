package org.bookbook.service;

import java.util.List;

import org.bookbook.domain.BestVO;
import org.bookbook.domain.Criteria;
import org.bookbook.mapper.BestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BestServiceImpl implements BestService {

	@Autowired
	private BestMapper mapper;

	@Override
	public int getTotalCount(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BestVO> getList(Criteria cri) {
		List<BestVO> list = mapper.getList(cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public BestVO get(int column1) {
		BestVO best = mapper.get(column1);
		return best;
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

}
