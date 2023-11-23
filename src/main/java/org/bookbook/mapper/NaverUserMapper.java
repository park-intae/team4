package org.bookbook.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface NaverUserMapper {

	public String getUserIdByNaverId(@Param("naverId") String naverId);

	public void insertNaverUser(@Param("naverId") String naverId, @Param("userId") String userId);
}