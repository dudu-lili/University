package com.redtourism.service;


import com.redtourism.entity.Study;
import com.redtourism.util.PageInfo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface StudyService {

    List<Study> listAll();
    void deleteStudy(Integer id);
    void addStudy(Study study);

    void updateStudy(Study study);
    Study getById(Integer id);
    int getViewCount(Integer studyId);
    PageInfo<Study> listByPage(int pageNum, int pageSize);
    void increaseViewCount(Integer id);
    List<Study> listTopStudy(int limit);

    int batchDelete(List<Integer> ids);
}

