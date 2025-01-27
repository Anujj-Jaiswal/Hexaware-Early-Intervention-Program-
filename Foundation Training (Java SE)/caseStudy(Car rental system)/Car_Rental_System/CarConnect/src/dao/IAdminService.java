package dao;

import entity.Admin;

public interface IAdminService {
    Admin getAdminById(int adminId);
    Admin getAdminByUsername(String username);
    void registerAdmin(Admin admin);
    void updateAdmin(Admin admin);
    void deleteAdmin(int adminId);
}
