/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/model/User.java
package model;

public class User {
    private int id;
    private String tenDangNhap, password, hoVaTen, diaChi, dienThoai, email;
    private int vaiTro; // 1=admin, 0=user

    public boolean isAdmin(){ return vaiTro==1; }

    // getter/setter
    public int getId() {return id;}
    public void setId(int id) {this.id = id;}
    public String getTenDangNhap() {return tenDangNhap;}
    public void setTenDangNhap(String tenDangNhap) {this.tenDangNhap = tenDangNhap;}
    public String getPassword() {return password;}
    public void setPassword(String password) {this.password = password;}
    public String getHoVaTen() {return hoVaTen;}
    public void setHoVaTen(String hoVaTen) {this.hoVaTen = hoVaTen;}
    public String getDiaChi() {return diaChi;}
    public void setDiaChi(String diaChi) {this.diaChi = diaChi;}
    public String getDienThoai() {return dienThoai;}
    public void setDienThoai(String dienThoai) {this.dienThoai = dienThoai;}
    public String getEmail() {return email;}
    public void setEmail(String email) {this.email = email;}
    public int getVaiTro() {return vaiTro;}
    public void setVaiTro(int vaiTro) {this.vaiTro = vaiTro;}
}

