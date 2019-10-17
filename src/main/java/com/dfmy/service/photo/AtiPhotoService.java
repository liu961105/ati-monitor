package com.dfmy.service.photo;

import java.util.List;


import com.dfmy.entity.photo.AtiPhoto;

public interface AtiPhotoService {
  public void savePhoto(AtiPhoto atiPhoto);
  
  List<AtiPhoto> findByProjectId(String id);
  List<AtiPhoto> findByProjectIdAndTypeId(String projectId,String typeId);
  void DeleteById(String id);
  AtiPhoto findById(String id);
  List<AtiPhoto> findByTypeId(String typeId);
  List<AtiPhoto> findByTypeIdAndProjectId(String typeId,String projectId);
}
