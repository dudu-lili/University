package com.redtourism.service.impl;

import com.redtourism.mapper.CommentMapper;
import com.redtourism.entity.Comment;
import com.redtourism.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Override
    public List<Comment> listByUserId(Integer userId) {
        return commentMapper.listByUserId(userId);
    }

    @Override
    public List<Comment> getCommentsByRouteId(Integer routeId) {
        return commentMapper.selectByRouteId(routeId);
    }

    @Override
    public List<Comment> getCommentsByScenicId(Integer scenicId) {
        return commentMapper.getCommentsByScenicId(scenicId);
    }

    @Override
    @Transactional
    public List<Comment> getCommentsByStudyId(Integer studyId) {
        return commentMapper.getCommentsByStudyId(studyId);
    }

    @Override
    public List<Comment> getCommentsByTravelNotesId(Integer travelNotesId) {
        return commentMapper.getCommentsByTravelNotesId(travelNotesId);
    }


    @Override

    public List<Comment> getAllComments() {
        return commentMapper.getAllComments();
    }

    @Autowired
    private CommentMapper commentMapper;

    @Override
    public List<Comment> listByScenicId(Integer scenicId) {
        return commentMapper.selectByScenicId(scenicId);
    }

    @Override
    public List<Comment> listByRouteId(Integer routeId) {
        return commentMapper.selectByRouteId(routeId);
    }

    @Override
    public List<Comment> listByStudyId(Integer studyId) {
        return commentMapper.selectByStudyId(studyId);
    }

    @Override
    public List<Comment> listByTravelNotesId(Integer travelNotesId) {
        return commentMapper.selectByTravelNotesId(travelNotesId);
    }


    @Override
    public Comment add(Comment comment) {
        commentMapper.insert(comment);
        return commentMapper.selectById(comment.getId());
    }

    @Override
    public void delete(Integer id) {
        commentMapper.delete(id);
    }

    @Override

    public void batchDelete(List<Integer> commentIds) {
        if (commentIds == null || commentIds.isEmpty()) {
            throw new IllegalArgumentException("评论ID列表不能为空");
        }
        commentMapper.batchDelete(commentIds);
    }
    @Override
    public Integer getUserIdByTravelNotesId(Integer travelNotesId) {
        return commentMapper.getUserIdByTravelNotesId(travelNotesId);
    }
}