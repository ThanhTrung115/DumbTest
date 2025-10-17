package dao;

import model.HoaDon;
import util.DBConnect;
import java.sql.*;
import java.util.*;

public class HoaDonDAO {
    private HoaDon map(ResultSet rs) throws Exception {
        HoaDon h = new HoaDon();
        h.setMaHD(rs.getInt("MaHD"));
        h.setMaKH(rs.getInt("MaKH"));
        h.setNgayDatHang(rs.getString("NgayDatHang"));
        return h;
    }

    public List<HoaDon> getAll(){
        List<HoaDon> list = new ArrayList<>();
        try(Connection c = DBConnect.getConnection(); 
            Statement st = c.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM hoadon ORDER BY MaHD DESC")){
            while(rs.next()) list.add(map(rs));
        }catch(Exception e){ e.printStackTrace(); }
        return list;
    }

    public HoaDon getById(int id){
        try(Connection c = DBConnect.getConnection(); 
            PreparedStatement p = c.prepareStatement("SELECT * FROM hoadon WHERE MaHD=?")){
            p.setInt(1,id); 
            try(ResultSet rs = p.executeQuery()){ 
                if(rs.next()) return map(rs); 
            }
        }catch(Exception e){ e.printStackTrace(); }
        return null;
    }

    public int insert(HoaDon h){
        String sql="INSERT INTO hoadon(MaKH,NgayDatHang) VALUES(?,?)";
        try(Connection c = DBConnect.getConnection();
            PreparedStatement p = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
            p.setInt(1,h.getMaKH());
            p.setString(2,h.getNgayDatHang());
            p.executeUpdate();
            try(ResultSet rs = p.getGeneratedKeys()){ if(rs.next()) return rs.getInt(1); }
        }catch(Exception e){ e.printStackTrace(); }
        return 0;
    }

    public void update(HoaDon h){
        String sql="UPDATE hoadon SET MaKH=?, NgayDatHang=? WHERE MaHD=?";
        try(Connection c = DBConnect.getConnection(); PreparedStatement p = c.prepareStatement(sql)){
            p.setInt(1,h.getMaKH()); 
            p.setString(2,h.getNgayDatHang()); 
            p.setInt(3,h.getMaHD());
            p.executeUpdate();
        }catch(Exception e){ e.printStackTrace(); }
    }

    public void delete(int id){
        try(Connection c = DBConnect.getConnection()){
            try(PreparedStatement p = c.prepareStatement("DELETE FROM chitiethoadon WHERE MaHD=?")){
                p.setInt(1,id); p.executeUpdate();
            }
            try(PreparedStatement p = c.prepareStatement("DELETE FROM hoadon WHERE MaHD=?")){
                p.setInt(1,id); p.executeUpdate();
            }
        }catch(Exception e){ e.printStackTrace(); }
    }

    // 🔍 Hàm mới: Tìm kiếm + lọc
    public List<HoaDon> searchAndFilter(String keyword, String ngay) {
        List<HoaDon> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM hoadon WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (MaHD LIKE ? OR MaKH LIKE ?)");
        }
        if (ngay != null && !ngay.trim().isEmpty()) {
            sql.append(" AND NgayDatHang = ?");
        }
        sql.append(" ORDER BY MaHD DESC");

        try (Connection c = DBConnect.getConnection();
             PreparedStatement p = c.prepareStatement(sql.toString())) {

            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                p.setString(index++, "%" + keyword + "%");
                p.setString(index++, "%" + keyword + "%");
            }
            if (ngay != null && !ngay.trim().isEmpty()) {
                p.setString(index++, ngay);
            }

            try (ResultSet rs = p.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
