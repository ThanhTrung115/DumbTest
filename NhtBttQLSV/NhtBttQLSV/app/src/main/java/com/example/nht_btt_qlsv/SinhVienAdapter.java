package com.example.nht_btt_qlsv;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.ArrayList;

public class SinhVienAdapter extends ArrayAdapter<SinhVien> {

    public SinhVienAdapter(@NonNull Context context, ArrayList<SinhVien> sinhViens) {
        super(context, 0, sinhViens);
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        if (convertView == null) {
            convertView = LayoutInflater.from(getContext()).inflate(android.R.layout.simple_list_item_1, parent, false);
        }

        SinhVien sinhVien = getItem(position);

        TextView tvSinhVien = convertView.findViewById(android.R.id.text1);
        tvSinhVien.setText(sinhVien.toString());

        return convertView;
    }
}
