import pandas as pd
import os
from datetime import datetime

# Path untuk direktori data dan output
DATA_DIR = "data"
OUTPUT_DIR = "output"

# 1. Menggabungkan semua file CSV
def merge_csv_files():
    # Daftar file yang akan digabungkan
    csv_files = ['branch_a.csv', 'branch_b.csv', 'branch_c.csv']
    
    # Membuat list untuk menyimpan DataFrame dari masing-masing file
    dataframes = []
    
    # Membaca setiap file CSV dan menambahkannya ke list dataframes
    for file in csv_files:
        file_path = os.path.join(DATA_DIR, file)
        df = pd.read_csv(file_path)
        dataframes.append(df)
        print(f"File {file} berhasil dibaca: {df.shape[0]} baris")
    
    # Menggabungkan semua DataFrame
    combined_df = pd.concat(dataframes, ignore_index=True)
    print(f"Total data setelah penggabungan: {combined_df.shape[0]} baris")
    
    return combined_df

# 2. Membersihkan data
def clean_data(df):
    print("\nProses pembersihan data:")
    
    # Jumlah data sebelum pembersihan
    print(f"Jumlah data sebelum pembersihan: {df.shape[0]} baris")
    
    # Menghapus baris dengan nilai NaN pada kolom transaction_id, date, dan customer_id
    # Gunakan copy() untuk menghindari SettingWithCopyWarning
    df_cleaned = df.dropna(subset=['transaction_id', 'date', 'customer_id']).copy()
    print(f"Jumlah data setelah menghapus baris dengan NaN: {df_cleaned.shape[0]} baris")
    
    # Mengubah format kolom date menjadi tipe datetime
    df_cleaned['date'] = pd.to_datetime(df_cleaned['date'])
    
    # Menampilkan info tentang duplikat transaction_id
    duplicates = df_cleaned[df_cleaned.duplicated(subset=['transaction_id'], keep=False)]
    if not duplicates.empty:
        print(f"Ditemukan {duplicates.shape[0]} baris dengan transaction_id duplikat")
    
    # Menghilangkan duplikat berdasarkan transaction_id, pilih data berdasarkan date terbaru
    df_cleaned = df_cleaned.sort_values('date', ascending=False)
    df_cleaned = df_cleaned.drop_duplicates(subset=['transaction_id'], keep='first')
    print(f"Jumlah data setelah menghilangkan duplikat: {df_cleaned.shape[0]} baris")
    
    return df_cleaned

# 3. Menghitung total penjualan per cabang
def calculate_total_sales_per_branch(df):
    # Menghitung total (quantity * price) untuk setiap transaksi
    df['total_sale'] = df['quantity'] * df['price']
    
    # Mengelompokkan berdasarkan cabang dan menghitung total penjualan
    total_sales = df.groupby('branch')['total_sale'].sum().reset_index()
    total_sales.columns = ['branch', 'total']
    
    # Menyimpan hasil ke file CSV
    output_path = os.path.join(OUTPUT_DIR, 'total_sales_per_branch.csv')
    total_sales.to_csv(output_path, index=False)
    print(f"\nTotal penjualan per cabang berhasil disimpan ke {output_path}")
    
    return total_sales

# Menjalankan seluruh proses
def main():
    print("Memulai proses pengolahan data...")
    
    # Memastikan direktori output ada
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
        print(f"Direktori {OUTPUT_DIR} dibuat")
    
    # Menggabungkan file CSV
    combined_df = merge_csv_files()
    
    # Membersihkan data
    cleaned_df = clean_data(combined_df)
    
    # Menghitung total penjualan per cabang
    sales_results = calculate_total_sales_per_branch(cleaned_df)
    
    print("\nRingkasan hasil penjualan per cabang:")
    print(sales_results)
    
    print("\nProses pengolahan data selesai!")

if __name__ == "__main__":
    main()