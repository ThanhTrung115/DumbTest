/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/model/CartItem.java
package model;

public class CartItem {
    private SanPham sp;
    private int soLuong;

    public CartItem() {}
    public CartItem(SanPham sp, int soLuong){ this.sp=sp; this.soLuong=soLuong; }

    public SanPham getSp() {return sp;}
    public void setSp(SanPham sp) {this.sp = sp;}
    public int getSoLuong() {return soLuong;}
    public void setSoLuong(int soLuong) {this.soLuong = soLuong;}
    public double getThanhTien(){ return sp.getGia() * soLuong; }
}
