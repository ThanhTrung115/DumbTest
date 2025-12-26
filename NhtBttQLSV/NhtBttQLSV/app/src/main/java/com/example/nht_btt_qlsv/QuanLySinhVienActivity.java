package com.example.nht_btt_qlsv;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import java.util.ArrayList;

public class QuanLySinhVienActivity extends AppCompatActivity {

    EditText edtMaSV, edtHoTen, edtNgaySinh;
    RadioGroup rgGioiTinh;
    RadioButton rbNam, rbNu;
    Spinner spLop;
    Button btnLuuSV, btnThoat;

    ArrayAdapter<Lop> lopSpinnerAdapter;
    SinhVien sinhVienToEdit;
    int position = -1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_quan_ly_sinh_vien);

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        edtMaSV = findViewById(R.id.edtMaSV);
        edtHoTen = findViewById(R.id.edtHoTen);
        edtNgaySinh = findViewById(R.id.edtNgaySinh);
        rgGioiTinh = findViewById(R.id.rgGioiTinh);
        rbNam = findViewById(R.id.rbNam);
        rbNu = findViewById(R.id.rbNu);
        spLop = findViewById(R.id.spLop);
        btnLuuSV = findViewById(R.id.btnLuuSV);
        btnThoat = findViewById(R.id.btnThoat);

        // Sử dụng danh sách lớp từ DataStore
        lopSpinnerAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, DataStore.LOP_LIST);
        lopSpinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spLop.setAdapter(lopSpinnerAdapter);

        Intent intent = getIntent();
        if (intent != null && intent.hasExtra("SINHVIEN_EDIT")) {
            sinhVienToEdit = (SinhVien) intent.getSerializableExtra("SINHVIEN_EDIT");
            position = intent.getIntExtra("SINHVIEN_POSITION", -1);
            if (sinhVienToEdit != null) {
                edtMaSV.setText(sinhVienToEdit.getMaSV());
                edtHoTen.setText(sinhVienToEdit.getHoTen());
                edtNgaySinh.setText(sinhVienToEdit.getNgaySinh());
                if (sinhVienToEdit.getGioiTinh().equals("Nam")) {
                    rbNam.setChecked(true);
                } else {
                    rbNu.setChecked(true);
                }
                for (int i = 0; i < DataStore.LOP_LIST.size(); i++) {
                    if (DataStore.LOP_LIST.get(i).getMaLop().equals(sinhVienToEdit.getLop().getMaLop())) {
                        spLop.setSelection(i);
                        break;
                    }
                }
            }
        }

        btnLuuSV.setOnClickListener(v -> saveStudent());

        btnThoat.setOnClickListener(v -> finish());
    }

    private void saveStudent() {
        String maSV = edtMaSV.getText().toString();
        String hoTen = edtHoTen.getText().toString();
        String ngaySinh = edtNgaySinh.getText().toString();
        String gioiTinh = rbNam.isChecked() ? "Nam" : "Nữ";
        Lop selectedLop = (Lop) spLop.getSelectedItem();

        if (maSV.isEmpty() || hoTen.isEmpty() || ngaySinh.isEmpty()) {
            Toast.makeText(this, "Vui lòng nhập đủ thông tin", Toast.LENGTH_SHORT).show();
            return;
        }

        if (selectedLop == null) {
            Toast.makeText(this, "Vui lòng tạo lớp trước", Toast.LENGTH_SHORT).show();
            return;
        }

        SinhVien sinhVien = new SinhVien(maSV, hoTen, ngaySinh, gioiTinh, selectedLop);
        Intent resultIntent = new Intent();
        resultIntent.putExtra("SINHVIEN_RESULT", sinhVien);
        if (position != -1) {
            resultIntent.putExtra("SINHVIEN_POSITION", position);
        }
        setResult(RESULT_OK, resultIntent);
        finish();
    }
}