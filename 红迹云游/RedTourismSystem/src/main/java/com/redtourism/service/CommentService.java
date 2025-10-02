package com.redtourism.service;

import com.redtourism.entity.Comment;
import java.util.List;

public interface CommentService {
    List<Comment> listByScenicId(Integer scenicId);
    List<Comment> listByRouteId(Integer routeId);
    List<Comment> listByStudyId(Integer studyId);

    List<Comment> listByTravelNotesId(Integer travelNotesId);
    Comment add(Comment comment);
    void delete(Integer id);
    //方法 根据用户ID查询评论
    List<Comment> listByUserId(Integer userId);

    List<Comment> getCommentsByRouteId(Integer routeId);

    List<Comment> getCommentsByScenicId(Integer scenicId);

    List<Comment> getCommentsByStudyId(Integer studyId);

    List<Comment> getCommentsByTravelNotesId(Integer travelNotesId);

    List<Comment> getAllComments();

    void batchDelete(List<Integer> commentIds);

    Integer getUserIdByTravelNotesId(Integer travelNotesId);



}