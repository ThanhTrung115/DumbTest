package dao;

import model.ChiTietHoaDon;
import util.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChiTietHoaDonDAO {

    private ChiTietHoaDon map(ResultSet rs) throws Exception {
        ChiTietHoaDon c = new ChiTietHoaDon();
        c.setMaHD(rs.getInt("MaHD"));
        c.setMaSP(rs.getInt("MaSP"));
        c.setSoLuong(rs.getInt("SoLuong"));

        // Các cột lấy thêm từ bảng sanpham
        try {
            c.setTenSP(rs.getString("TenSP"));
            c.setDonGia(rs.getDouble("DonGia"));
            c.setThanhTien(c.getSoLuong() * c.getDonGia());
        } catch (SQLException ignore) {
            // Nếu không có cột TenSP, DonGia (trong 1 số truy vấn cũ), bỏ qua
        }

        return c;
    }

    /** ✅ Lấy danh sách chi tiết hóa đơn kèm tên và giá sản phẩm */
    public List<ChiTietHoaDon> getByHD(int maHD) {
        List<ChiTietHoaDon> list = new ArrayList<>();
        String sql = "SELECT c.MaHD, c.MaSP, c.SoLuong, s.TenSP, s.DonGia "
                   + "FROM chitiethoadon c "
                   + "JOIN sanpham s ON c.MaSP = s.MaSP "
                   + "WHERE c.MaHD = ? "
                   + "ORDER BY c.MaSP";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maHD);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Lấy 1 chi tiết theo (MaHD, MaSP) */
    public ChiTietHoaDon get(int maHD, int maSP) {
        String sql = "SELECT * FROM chitiethoadon WHERE MaHD=? AND MaSP=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maHD);
            ps.setInt(2, maSP);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insert(ChiTietHoaDon ct) {
        String sql = "INSERT INTO chitiethoadon(MaHD, MaSP, SoLuong) VALUES(?,?,?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ct.getMaHD());
            ps.setInt(2, ct.getMaSP());
            ps.setInt(3, ct.getSoLuong());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(ChiTietHoaDon ct) {
        String sql = "UPDATE chitiethoadon SET SoLuong=? WHERE MaHD=? AND MaSP=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ct.getSoLuong());
            ps.setInt(2, ct.getMaHD());
            ps.setInt(3, ct.getMaSP());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int maHD, int maSP) {
        String sql = "DELETE FROM chitiethoadon WHERE MaHD=? AND MaSP=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maHD);
            ps.setInt(2, maSP);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
