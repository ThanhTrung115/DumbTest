package dao;

import model.SanPham;
import util.DBConnect;
import java.sql.*;
import java.util.*;

public class SanPhamDAO {
    private SanPham map(ResultSet rs) throws Exception {
        SanPham s = new SanPham();
        s.setMaSP(rs.getInt("MaSP"));
        s.setTenSP(rs.getString("TenSP"));
        s.setGia(rs.getDouble("Gia"));
        s.setSoLuong(rs.getInt("SoLuong"));
        s.setHinhAnh(rs.getString("HinhAnh"));
        s.setMotaSP(rs.getString("MotaSP"));
        s.setMaDMSP(rs.getInt("MaDMSP"));
        return s;
    }

    public List<SanPham> getAll() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM sanpham ORDER BY MaSP DESC";
        try (Connection c = DBConnect.getConnection(); Statement st = c.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public SanPham getById(int id) {
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement("SELECT * FROM sanpham WHERE MaSP=?")) {
            p.setInt(1, id);
            try (ResultSet rs = p.executeQuery()) { if (rs.next()) return map(rs); }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void insert(SanPham s) {
        String sql = "INSERT INTO sanpham(TenSP,Gia,SoLuong,HinhAnh,MotaSP,MaDMSP) VALUES(?,?,?,?,?,?)";
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, s.getTenSP());
            p.setDouble(2, s.getGia());
            p.setInt(3, s.getSoLuong());
            p.setString(4, s.getHinhAnh());
            p.setString(5, s.getMotaSP());
            p.setInt(6, s.getMaDMSP());
            p.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void update(SanPham s) {
        String sql = "UPDATE sanpham SET TenSP=?,Gia=?,SoLuong=?,HinhAnh=?,MotaSP=?,MaDMSP=? WHERE MaSP=?";
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, s.getTenSP());
            p.setDouble(2, s.getGia());
            p.setInt(3, s.getSoLuong());
            p.setString(4, s.getHinhAnh());
            p.setString(5, s.getMotaSP());
            p.setInt(6, s.getMaDMSP());
            p.setInt(7, s.getMaSP());
            p.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement("DELETE FROM sanpham WHERE MaSP=?")) {
            p.setInt(1, id);
            p.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // 🔍 Tìm kiếm sản phẩm theo tên
    public List<SanPham> search(String keyword) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM sanpham WHERE TenSP LIKE ?";
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, "%" + keyword + "%");
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 🗂️ Lọc sản phẩm theo mã danh mục
    public List<SanPham> filterByDanhMuc(int maDMSP) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM sanpham WHERE MaDMSP=?";
        try (Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setInt(1, maDMSP);
            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}
