package com.example.nht_btt_qlsv;

import java.io.Serializable;

public class SinhVien implements Serializable {
    private String maSV;
    private String hoTen;
    private String ngaySinh;
    private String gioiTinh;
    private Lop lop;

    public SinhVien(String maSV, String hoTen, String ngaySinh, String gioiTinh, Lop lop) {
        this.maSV = maSV;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.lop = lop;
    }

    public String getMaSV() {
        return maSV;
    }

    public void setMaSV(String maSV) {
        this.maSV = maSV;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(String ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public Lop getLop() {
        return lop;
    }

    public void setLop(Lop lop) {
        this.lop = lop;
    }

    @Override
    public String toString() {
        return "Mã SV: " + maSV + "\n" +
                "Họ tên: " + hoTen + "\n" +
                "Ngày sinh: " + ngaySinh + "\n" +
                "Giới tính: " + gioiTinh + "\n" +
                "Lớp: " + lop.getTenLop();
    }
}
