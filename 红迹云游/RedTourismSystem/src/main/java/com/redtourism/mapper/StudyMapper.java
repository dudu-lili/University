package com.redtourism.mapper;

import com.redtourism.entity.Study;
import com.redtourism.util.PageInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StudyMapper {

    List<Study> selectAll();

    PageInfo<Study> selectAllByPage(@Param("pageNum") int pageNum, @Param("pageSize") int pageSize);

    Study selectById(Integer id);

    void increaseViewCount(Integer id);

    void delete(Integer id);

    int update(Study study);

    int selectViewCountById(Integer id);

    int insert(Study study);

    List<Study> listTopStudy(@Param("limit") int limit);
    int batchDelete(@Param("ids") List<Integer> ids);
}