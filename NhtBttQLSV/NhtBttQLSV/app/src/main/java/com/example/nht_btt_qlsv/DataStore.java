package com.example.nht_btt_qlsv;

import java.util.ArrayList;

public class DataStore {
    public static final ArrayList<Lop> LOP_LIST = new ArrayList<>();

    static {
        // Dữ liệu ban đầu
        if (LOP_LIST.isEmpty()) {
            LOP_LIST.add(new Lop("LT1", "Lớp Lập trình Android"));
            LOP_LIST.add(new Lop("LT2", "Lớp Lập trình Web"));
        }
    }
}