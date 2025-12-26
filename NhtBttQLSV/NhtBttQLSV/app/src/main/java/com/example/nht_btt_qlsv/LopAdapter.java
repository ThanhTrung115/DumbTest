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

public class LopAdapter extends ArrayAdapter<Lop> {

    public LopAdapter(@NonNull Context context, ArrayList<Lop> lops) {
        super(context, 0, lops);
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        if (convertView == null) {
            convertView = LayoutInflater.from(getContext()).inflate(android.R.layout.simple_list_item_1, parent, false);
        }

        Lop lop = getItem(position);

        TextView tvLop = convertView.findViewById(android.R.id.text1);
        tvLop.setText(lop.toString());

        return convertView;
    }
}
