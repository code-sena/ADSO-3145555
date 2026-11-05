package com.sena.test.IService.ISecurityService;

import java.util.List;

public interface IUserRoleService {

     void assignRole (Long userId, Long roleId);

     void removeRole(Long userId, Long roleId);

     List<String> getRolesByUser(Long userId);
     

}
