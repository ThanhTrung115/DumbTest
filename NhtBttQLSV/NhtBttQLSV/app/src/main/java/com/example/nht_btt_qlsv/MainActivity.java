package com.example.nht_btt_qlsv;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;

import androidx.activity.EdgeToEdge;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    Button btnQuanLyLop, btnQuanLySinhVien;
    ListView lvSinhVienMain;

    ArrayList<SinhVien> sinhVienList;
    SinhVienAdapter sinhVienAdapter;

    private ActivityResultLauncher<Intent> addStudentLauncher;
    private ActivityResultLauncher<Intent> editStudentLauncher;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        btnQuanLyLop = findViewById(R.id.btnQuanLyLop);
        btnQuanLySinhVien = findViewById(R.id.btnQuanLySinhVien);
        lvSinhVienMain = findViewById(R.id.lvSinhVienMain);

        sinhVienList = new ArrayList<>();
        sinhVienAdapter = new SinhVienAdapter(this, sinhVienList);
        lvSinhVienMain.setAdapter(sinhVienAdapter);

        addStudentLauncher = registerForActivityResult(
                new ActivityResultContracts.StartActivityForResult(),
                result -> {
                    if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                        SinhVien newStudent = (SinhVien) result.getData().getSerializableExtra("SINHVIEN_RESULT");
                        if (newStudent != null) {
                            sinhVienList.add(newStudent);
                            sinhVienAdapter.notifyDataSetChanged();
                        }
                    }
                });

        editStudentLauncher = registerForActivityResult(
                new ActivityResultContracts.StartActivityForResult(),
                result -> {
                    if (result.getResultCode() == RESULT_OK && result.getData() != null) {
                        SinhVien updatedStudent = (SinhVien) result.getData().getSerializableExtra("SINHVIEN_RESULT");
                        int position = result.getData().getIntExtra("SINHVIEN_POSITION", -1);
                        if (updatedStudent != null && position != -1) {
                            sinhVienList.set(position, updatedStudent);
                            sinhVienAdapter.notifyDataSetChanged();
                        }
                    }
                });

        btnQuanLyLop.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, QuanLyLopActivity.class);
            startActivity(intent);
        });

        btnQuanLySinhVien.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, QuanLySinhVienActivity.class);
            addStudentLauncher.launch(intent);
        });

        lvSinhVienMain.setOnItemClickListener((parent, view, position, id) -> {
            showEditDeleteDialog(position);
        });
    }

    private void showEditDeleteDialog(final int position) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Lựa chọn");
        builder.setItems(new CharSequence[]{"Sửa", "Xóa"}, (dialog, which) -> {
            switch (which) {
                case 0: // Edit
                    Intent intent = new Intent(MainActivity.this, QuanLySinhVienActivity.class);
                    intent.putExtra("SINHVIEN_EDIT", sinhVienList.get(position));
                    intent.putExtra("SINHVIEN_POSITION", position);
                    editStudentLauncher.launch(intent);
                    break;
                case 1: // Delete
                    sinhVienList.remove(position);
                    sinhVienAdapter.notifyDataSetChanged();
                    break;
            }
        });
        builder.create().show();
    }
}