package dao;

import model.User;
import util.DBConnect;
import java.sql.*;
import java.util.*;

public class UserDAO {
    private User map(ResultSet rs) throws Exception {
        User u = new User();
        u.setId(rs.getInt("Id"));
        u.setTenDangNhap(rs.getString("TenDangNhap"));
        u.setPassword(rs.getString("Password"));
        u.setHoVaTen(rs.getString("HoVaTen"));
        u.setDiaChi(rs.getString("DiaChi"));
        u.setDienThoai(rs.getString("DienThoai"));
        u.setEmail(rs.getString("Email"));
        u.setVaiTro(rs.getInt("vaitro"));
        return u;
    }

    public User login(String user, String pass) {
        String sql = "SELECT * FROM user WHERE TenDangNhap=? AND Password=?";
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, user);
            p.setString(2, pass);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        try (Connection c = DBConnect.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM user ORDER BY Id DESC")) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public User getById(int id) {
        try (Connection c = DBConnect.getConnection();
             PreparedStatement p = c.prepareStatement("SELECT * FROM user WHERE Id=?")) {
            p.setInt(1, id);
            try (ResultSet rs = p.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insert(User u) {
        String sql = "INSERT INTO user(TenDangNhap,Password,HoVaTen,DiaChi,DienThoai,Email,vaitro) VALUES(?,?,?,?,?,?,?)";
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, u.getTenDangNhap());
            p.setString(2, u.getPassword());
            p.setString(3, u.getHoVaTen());
            p.setString(4, u.getDiaChi());
            p.setString(5, u.getDienThoai());
            p.setString(6, u.getEmail());
            p.setInt(7, u.getVaiTro());
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(User u) {
        String sql = "UPDATE user SET TenDangNhap=?,Password=?,HoVaTen=?,DiaChi=?,DienThoai=?,Email=?,vaitro=? WHERE Id=?";
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, u.getTenDangNhap());
            p.setString(2, u.getPassword());
            p.setString(3, u.getHoVaTen());
            p.setString(4, u.getDiaChi());
            p.setString(5, u.getDienThoai());
            p.setString(6, u.getEmail());
            p.setInt(7, u.getVaiTro());
            p.setInt(8, u.getId());
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        try (Connection c = DBConnect.getConnection();
             PreparedStatement p = c.prepareStatement("DELETE FROM user WHERE Id=?")) {
            p.setInt(1, id);
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ------------------ BỔ SUNG CHỨC NĂNG LỌC & TÌM KIẾM ------------------

    /** Lọc danh sách người dùng theo vai trò */
    public List<User> filterByRole(int vaitro) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE vaitro=? ORDER BY Id DESC";
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setInt(1, vaitro);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Tìm kiếm người dùng theo tên đăng nhập, họ tên, hoặc email */
    public List<User> search(String keyword) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE TenDangNhap LIKE ? OR HoVaTen LIKE ? OR Email LIKE ? ORDER BY Id DESC";
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            String k = "%" + keyword + "%";
            p.setString(1, k);
            p.setString(2, k);
            p.setString(3, k);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
