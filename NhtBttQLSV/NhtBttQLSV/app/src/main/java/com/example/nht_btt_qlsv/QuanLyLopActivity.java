package com.example.nht_btt_qlsv;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class QuanLyLopActivity extends AppCompatActivity {

    EditText edtMaLop, edtTenLop;
    Button btnThemLop, btnSuaLop, btnXoaLop;
    ListView lvLop;

    LopAdapter lopAdapter;
    int selectedPosition = -1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_quan_ly_lop);

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        edtMaLop = findViewById(R.id.edtMaLop);
        edtTenLop = findViewById(R.id.edtTenLop);
        btnThemLop = findViewById(R.id.btnThemLop);
        btnSuaLop = findViewById(R.id.btnSuaLop);
        btnXoaLop = findViewById(R.id.btnXoaLop);
        lvLop = findViewById(R.id.lvLop);

        // Sử dụng danh sách từ DataStore
        lopAdapter = new LopAdapter(this, DataStore.LOP_LIST);
        lvLop.setAdapter(lopAdapter);

        btnThemLop.setOnClickListener(v -> {
            String maLop = edtMaLop.getText().toString();
            String tenLop = edtTenLop.getText().toString();
            if (!maLop.isEmpty() && !tenLop.isEmpty()) {
                DataStore.LOP_LIST.add(new Lop(maLop, tenLop));
                lopAdapter.notifyDataSetChanged();
                clearFields();
            } else {
                Toast.makeText(this, "Vui lòng nhập đủ thông tin", Toast.LENGTH_SHORT).show();
            }
        });

        lvLop.setOnItemClickListener((parent, view, position, id) -> {
            selectedPosition = position;
            Lop selectedLop = DataStore.LOP_LIST.get(position);
            edtMaLop.setText(selectedLop.getMaLop());
            edtTenLop.setText(selectedLop.getTenLop());
        });

        btnSuaLop.setOnClickListener(v -> {
            if (selectedPosition != -1) {
                String maLop = edtMaLop.getText().toString();
                String tenLop = edtTenLop.getText().toString();
                if (!maLop.isEmpty() && !tenLop.isEmpty()) {
                    Lop lop = DataStore.LOP_LIST.get(selectedPosition);
                    lop.setMaLop(maLop);
                    lop.setTenLop(tenLop);
                    lopAdapter.notifyDataSetChanged();
                    clearFields();
                } else {
                    Toast.makeText(this, "Vui lòng nhập đủ thông tin", Toast.LENGTH_SHORT).show();
                }
            } else {
                Toast.makeText(this, "Vui lòng chọn một lớp để sửa", Toast.LENGTH_SHORT).show();
            }
        });

        btnXoaLop.setOnClickListener(v -> {
            if (selectedPosition != -1) {
                DataStore.LOP_LIST.remove(selectedPosition);
                lopAdapter.notifyDataSetChanged();
                clearFields();
            } else {
                Toast.makeText(this, "Vui lòng chọn một lớp để xóa", Toast.LENGTH_SHORT).show();
            }
        });
    }

    private void clearFields() {
        edtMaLop.setText("");
        edtTenLop.setText("");
        selectedPosition = -1;
        edtMaLop.requestFocus();
    }
}