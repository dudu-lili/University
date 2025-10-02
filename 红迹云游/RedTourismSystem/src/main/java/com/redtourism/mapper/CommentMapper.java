package com.redtourism.mapper;

import com.redtourism.entity.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentMapper {
    List<Comment> selectByScenicId(Integer scenicId);
    List<Comment> selectByRouteId(Integer routeId);
    List<Comment> selectByStudyId(Integer studyId);

    List<Comment> selectByTravelNotesId(Integer travelNotesId);

    int insert(Comment comment);
    int delete(Integer id);
    List<Comment> selectAll();
    Comment selectById(Integer id);
    //方法 根据用户ID查询评论
    List<Comment> listByUserId(Integer userId);

    List<Comment> getCommentsByScenicId(Integer scenicId);

    List<Comment> getCommentsByStudyId(Integer studyId);

    List<Comment> getCommentsByTravelNotesId(Integer travelNotesId);

    List<Comment> getAllComments();

    int batchDelete(@Param("commentIds") List<Integer> commentIds);

    Integer getUserIdByTravelNotesId(Integer travelNotesId);
}