/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/model/ChiTietHoaDon.java
package model;

public class ChiTietHoaDon {
    private int maHD;
    private int maSP;
    private int soLuong;

    // ---- Các thuộc tính mở rộng để hiển thị ----
    private String tenSP;
    private double donGia;
    private double thanhTien;

    // ---- Getter & Setter ----
    public int getMaHD() {
        return maHD;
    }

    public void setMaHD(int maHD) {
        this.maHD = maHD;
    }

    public int getMaSP() {
        return maSP;
    }

    public void setMaSP(int maSP) {
        this.maSP = maSP;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
        // Tự động tính lại thành tiền nếu có đơn giá
        if (this.donGia > 0) {
            this.thanhTien = this.donGia * this.soLuong;
        }
    }

    public String getTenSP() {
        return tenSP;
    }

    public void setTenSP(String tenSP) {
        this.tenSP = tenSP;
    }

    public double getDonGia() {
        return donGia;
    }

    public void setDonGia(double donGia) {
        this.donGia = donGia;
        // Tự động tính lại thành tiền nếu có số lượng
        if (this.soLuong > 0) {
            this.thanhTien = this.donGia * this.soLuong;
        }
    }

    public double getThanhTien() {
        return thanhTien;
    }

    public void setThanhTien(double thanhTien) {
        this.thanhTien = thanhTien;
    }
}


