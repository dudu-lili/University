package com.redtourism.service;


import com.redtourism.entity.TravelNotes;
import com.redtourism.util.PageInfo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface TravelNotesService {

    List<TravelNotes> listAll();
    void deleteTravelNotes(Integer id);
    void delete(Integer id);
    void addTravelNotes(TravelNotes travelNotes);
    List<TravelNotes> listFavoritesByUserId(Integer userId);

    void updateTravelNotes(TravelNotes travelNotes);
    TravelNotes getById(Integer id);
    int getViewCount(Integer travelNotesId);
    int getFavoriteCount(Integer travelNotesId);
    PageInfo<TravelNotes> listByPage(int pageNum, int pageSize);
    void increaseViewCount(Integer id);
    void increaseFavoriteCount(Integer id);
    List<TravelNotes> listTopTravelNotes(int limit);
    void favorite(Integer id, Integer travelNotesId);

    void unfavoriteTravelNotes(Integer userId,Integer travelNotesId);

//    void unTravelNotesList(Integer userId,Integer travelNotesId);

    List<TravelNotes> listByUserId(Integer userId);

}

