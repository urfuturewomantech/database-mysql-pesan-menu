-- BUAT TABEL TABEL DARI MULAI SAMPAI STOP --
------------ MULAI ------------

BEGIN;
CREATE TABLE menu
(
    id_menu integer NOT NULL,
    nama_menu character varying(50),
    jenis_menu character varying(15),
    id_bahan_baku VARCHAR (5),
    harga numeric,
    CONSTRAINT menu_pkey PRIMARY KEY (id_menu)
);

CREATE TABLE pelanggan
(
    id_pelanggan integer NOT NULL,
    nama_pelanggan character varying(100),
    no_meja integer NOT NULL,
    CONSTRAINT customer_pkey PRIMARY KEY (id_pelanggan)
);

CREATE TABLE pesanan
(
    id_pesanan integer NOT NULL,
    id_pelanggan integer,
    id_menu integer,
    jumlah_pesanan integer NOT NULL,
    catatan_pesanan text DEFAULT NULL,
    CONSTRAINT pesanan_pkey PRIMARY KEY (id_pesanan)
);


CREATE TABLE pembayaran
(
    id_transaksi integer NOT NULL,
    id_pelanggan integer,
    tgl_transaksi timestamp,
    metode_pembayaran character varying(50),
    status_pembayaran character varying(50) DEFAULT 'Belum Selesai',
	total_harga numeric,
    CONSTRAINT pembayaran_pkey PRIMARY KEY (id_transaksi)
);

CREATE TABLE supplier
(
    id_supplier integer NOT NULL,
    nama_supplier character varying(100),
    no_telp_supplier character varying(25),
    alamat_supplier character varying(100),
    CONSTRAINT supplier_pkey PRIMARY KEY (id_supplier)
);

CREATE TABLE bahan_baku
(	
    id_bahan_baku VARCHAR (5) UNIQUE NOT NULL,
    bahan_baku text,
    id_supplier integer,
    stok integer,
	harga_beli_bahan_baku numeric,
    CONSTRAINT bahan_baku_pkey PRIMARY KEY (id_bahan_baku)
);

CREATE TABLE penjualan
(
    id_penjualan integer NOT NULL,
    tanggal date,
	id_pelanggan integer,
    penjualan numeric,
    beban numeric,
    keuntungan numeric,
    CONSTRAINT penjualan_pkey PRIMARY KEY (id_penjualan)
);
END;


---- Mendefinisikan Relasi ----
BEGIN;

ALTER TABLE bahan_baku
    ADD CONSTRAINT id_supplier_fk FOREIGN KEY (id_supplier)
    REFERENCES supplier (id_supplier);


ALTER TABLE menu
    ADD CONSTRAINT id_bahan_baku_fk FOREIGN KEY (id_bahan_baku)
    REFERENCES bahan_baku (id_bahan_baku);


ALTER TABLE pembayaran
    ADD CONSTRAINT pembayaran_id_pelanggan_fkey FOREIGN KEY (id_pelanggan)
    REFERENCES pelanggan (id_pelanggan);


ALTER TABLE penjualan
    ADD CONSTRAINT fk_id_pelanggan FOREIGN KEY (id_pelanggan)
    REFERENCES pelanggan (id_pelanggan);


ALTER TABLE pesanan
    ADD CONSTRAINT pesan_id_menu_fkey FOREIGN KEY (id_menu)
    REFERENCES menu (id_menu);


ALTER TABLE pesanan
    ADD CONSTRAINT pesan_id_pelanggan_fkey FOREIGN KEY (id_pelanggan)
    REFERENCES pelanggan (id_pelanggan);

END;

------------ STOP ------------






---- Memasukkan Data (Create) ----
BEGIN;
INSERT INTO supplier (id_supplier, nama_supplier, no_telp_supplier, alamat_supplier)
VALUES
	(1001, 'Toko Barokah', '08158732819', 'Jl. Bukit Tanjung II, Blok D4 No. 15, Kota Depok');
	--SELECT * FROM supplier
END;

BEGIN;
INSERT INTO bahan_baku (id_bahan_baku, bahan_baku, id_supplier, stok, harga_beli_bahan_baku)
VALUES
	('MP001', 'Beras', 1001, 100, 1200),
	('LP001', 'Ayam, Beras, Kecap', 1001, 50, 18000),
	('LP002', 'Ikan Nila, Minyak, Kecap, Lalapan', 1001, 30, 15000),
	('LP003', 'Beras, Ikan Kakap, Lalapan', 1001, 20, 16000),
	('MM001', 'Terigu, Coklat, Keju', 1001, 80, 5000),
	('LP004', 'Ayam, Sambal Pecak, Lalapan', 1001, 60, 20000),
	('MN001', 'Air Botol', 1001, 200, 1500),
	('JB002', 'Jeruk, Gula', 1001, 50, 3000),
	('MN003', 'Teh, Gula', 1001, 40, 2000),
	('JB004', 'Buah, Gula, Susu Kental Manis', 1001, 30, 00),
	('MN005', 'Kopi, Gula Aren', 1001, 25, 5000),
	('BV006', 'Merek Soda', 1001, 35, 5000);
	--SELECT * FROM bahan_baku
END;

BEGIN;
INSERT INTO menu (id_menu, nama_menu, jenis_menu, id_bahan_baku, harga)
VALUES
	(100, 'Nasi Putih', 'Makanan', 'MP001', 4000),
    (101, 'Nasi Ayam Bakar', 'Makanan', 'LP001', 25000),
    (102, 'Ikan Nila Goreng', 'Makanan', 'LP002', 30000),
    (103, 'Nasi Bakar Ikan Kakap', 'Makanan', 'LP003', 35000),
    (104, 'Aneka Kue Basah', 'Makanan', 'MM001', 10000),
    (105, 'Ayam Goreng Sambal Pecak', 'Makanan', 'LP004', 28000),
    (200, 'Air Putih', 'Minuman', 'MN001', 3000),
    (201, 'Es Jeruk', 'Minuman', 'JB002', 7000),
    (202, 'Teh Hangat', 'Minuman', 'MN003', 4000),
    (203, 'Es Buah', 'Minuman', 'JB004', 10000),
    (204, 'Kopi Gula Aren', 'Minuman', 'MN005', 8000),
    (205, 'Minuman Soda', 'Minuman', 'BV006', 9000);
	--SELECT * FROM menu ORDER BY id_menu ASC
END;

BEGIN;
INSERT INTO pelanggan (id_pelanggan, nama_pelanggan, no_meja) VALUES
	(1, 'Rita', 1),
	(2, 'Dewi', 2),
	(3, 'Budi', 3),
    (4, 'Siti', 4),
    (5, 'Joko', 5);
	--SELECT * FROM pelanggan ORDER BY id_pelanggan ASC
END;

BEGIN;
INSERT INTO pesanan (id_pesanan, id_pelanggan, id_menu, jumlah_pesanan, catatan_pesanan)
VALUES
	(1, 1, 101, 1, 'jangan pake sambel'), (2, 1, 201, 1, DEFAULT),
	(3, 2, 102, 2, DEFAULT), (4, 2, 202, 1, 'esnya banyakin'),
	(5, 3, 103, 2, 'tambah lalapan'), (6, 3, 203, 3, DEFAULT),
	(7, 4, 104, 1, 'ganti ini sama itu'), (8, 4, 204, 2, DEFAULT),
	(9, 5, 105, 2, 'sambelnya banyakin'), (10, 5, 205, 2, 'yang engga dingin');
	--SELECT * FROM pesanan ORDER BY id_pelanggan ASC
END; 

BEGIN;
INSERT INTO pembayaran (id_transaksi, id_pelanggan, tgl_transaksi, metode_pembayaran, status_pembayaran, total_harga)
VALUES
	(1, 1, '2023-11-13 15:00', 'BCA', DEFAULT, 0);
	--SELECT * FROM pembayaran
END;




---- Membaca (Read) Data Yang Ada Pada Tabel ----
SELECT * FROM menu;


SELECT id_menu, nama_menu, bahan_baku, harga FROM menu
JOIN bahan_baku ON menu.id_bahan_baku = bahan_baku.id_bahan_baku


SELECT nama_pelanggan, jumlah_pesanan, nama_menu
FROM pesanan
JOIN menu ON pesanan.id_menu = menu.id_menu
JOIN pelanggan ON pesanan.id_pelanggan = pelanggan.id_pelanggan
WHERE pelanggan.nama_pelanggan = 'Joko';




---- Mengubah (Update) Data Yang Ada Pada Tabel ----
BEGIN;
-- mengubah data 'total_harga' pada tabel pembayaran, dengan jumlah keseluruhan dari hasil kali 'jumlah_pesanan' dengan 'harga' pada 'id_transaksi' 1 --
UPDATE pembayaran
SET total_harga = (
    SELECT SUM(pesanan.jumlah_pesanan * menu.harga)
    FROM pesanan
    JOIN menu ON pesanan.id_menu = menu.id_menu
    WHERE pembayaran.id_pelanggan = pesanan.id_pelanggan
)
WHERE pembayaran.id_transaksi = 1; -- 
END;

BEGIN;
UPDATE pembayaran
SET status_pembayaran = 'Selesai'
WHERE id_transaksi = 1;
END;

SELECT * FROM pembayaran




---- Menghapus (Delete) Data Pada Tabel ----
BEGIN;
DELETE FROM pembayaran
WHERE status_pembayaran = 'Selesai'

SELECT * FROM pembayaran
