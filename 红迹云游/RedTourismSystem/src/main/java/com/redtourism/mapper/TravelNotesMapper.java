package com.redtourism.mapper;

import com.redtourism.entity.TravelNotes;
import com.redtourism.util.PageInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TravelNotesMapper {

    List<TravelNotes> selectAll();

    List<TravelNotes> listFavoritesByUserId(@Param("userId") Integer userId);

    PageInfo<TravelNotes> selectAllByPage(@Param("pageNum") int pageNum, @Param("pageSize") int pageSize);

    TravelNotes selectById(Integer id);

    void increaseViewCount(Integer id);

    void increaseFavoriteCount(Integer id);

    void decreaseFavoriteCount(Integer id);

    void delete(Integer id);

    int update(TravelNotes travelNotes);

    int insert(TravelNotes travelNotes);

    List<TravelNotes> listTopTravelNotes(@Param("limit") int limit);

    List<TravelNotes> selectByUserId(Integer userId);

    Integer getFavoriteCount(Integer travelNotesId);


}