package com.redtourism.service.impl;

import com.redtourism.entity.Study;
import com.redtourism.mapper.StudyMapper;
import com.redtourism.service.StudyService;
import com.redtourism.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class StudyServiceImpl implements StudyService {

    @Autowired
    private StudyMapper studyMapper;

    @Override
    public List<Study> listAll() {
        return studyMapper.selectAll();
    }

    @Override
    public PageInfo<Study> listByPage(int pageNum, int pageSize) {
        List<Study> list = studyMapper.selectAll();
        return new PageInfo<>(pageNum, pageSize, list.size(), list);
    }

    @Override
    public Study getById(Integer id) {
        return studyMapper.selectById(id);
    }

    @Override
    public List<Study> listTopStudy(int limit) {
        return studyMapper.listTopStudy(limit);
    }

    @Override
    public void increaseViewCount(Integer id) {
        studyMapper.increaseViewCount(id);
    }

    @Override
    public void deleteStudy(Integer id) {
        studyMapper.delete(id);
    }


    @Override
    public int getViewCount(Integer studyId) {
        Study study = studyMapper.selectById(studyId);
        return study != null ? study.getViewCount() : 0;
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addStudy(Study study) {

        //设置默认数为0
        if (study.getViewCount() == null) {
            study.setViewCount(0);
        }
        System.out.println("Add study: " + study); // 打印对象内容

        studyMapper.insert(study);

    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateStudy(Study study) {
        //保留原有的数
        Study original = studyMapper.selectById(study.getId());
        if(original != null) {
            study.setViewCount(original.getViewCount());
        }

        studyMapper.update(study);
    }

    @Override
    public int batchDelete(List<Integer> ids) {
        System.out.println("Batch delete IDs: " + ids); // 打印接收到的参数
        return studyMapper.batchDelete(ids);
}

}