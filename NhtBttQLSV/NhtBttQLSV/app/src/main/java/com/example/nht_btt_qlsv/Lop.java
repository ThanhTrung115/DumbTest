package com.example.nht_btt_qlsv;

import java.io.Serializable;

public class Lop implements Serializable {
    private String maLop;
    private String tenLop;

    public Lop(String maLop, String tenLop) {
        this.maLop = maLop;
        this.tenLop = tenLop;
    }

    public String getMaLop() {
        return maLop;
    }

    public void setMaLop(String maLop) {
        this.maLop = maLop;
    }

    public String getTenLop() {
        return tenLop;
    }

    public void setTenLop(String tenLop) {
        this.tenLop = tenLop;
    }

    @Override
    public String toString() {
        return maLop + " - " + tenLop;
    }
}
