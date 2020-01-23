program tiket_penerbangan;


uses crt;

const
	MAX = 150;
	PRICE = 750000;

type
	penerbangan = record
		kelas     : string;
		nama      : String;
		id_ktp    : String;
		jadwal    : string;
		harga     : real;
		no_kursi  : integer;
		jml_tiket : integer;

	end;

		ArrayPenerbangan = array [1..MAX] of penerbangan;
var
		TabPenerbangan   : ArrayPenerbangan;
		tmp				 : array [1..4] of penerbangan;
		pil,i,j          : integer;
		Npenerbangan     : integer;
        jml_tiket        : integer;
		pitapenerbangan : file of penerbangan;

		procedure tambah;
		var
			i : integer;
		begin
		clrscr;
			writeln('masukan jumlah pemesanan : ');
			readln(Npenerbangan);
			if(Npenerbangan <= 4 )  then
			begin
				for i := 1 to Npenerbangan do
				begin
					writeln('jumlah tiket yang tersedia : ',jml_tiket);
					write('Masukkan nama anda : ');
					readln(tmp[i].nama);
					write('Masukkan Id KTP anda : ');
					readln(tmp[i].id_ktp);
					repeat
					begin
						write('Masukkan kelas penerbangan (ekonomi/super_ekonomi ): ');
						readln(tmp[i].kelas);
					end
					until(tmp[i].kelas = 'ekonomi' ) or (tmp[i].kelas = 'super_ekonomi');
					write('Masukkan jadwal penerbangan : ');
					readln(tmp[i].jadwal);
					writeln;
					jml_tiket := jml_tiket-1;
					if tmp[i].kelas = 'super_ekonomi' then
					begin
						for j := MAX downto 50 do
						begin
							if TabPenerbangan[j].nama = '' then
							begin
								tmp[i].harga := PRICE - (PRICE*(80/100));
								tmp[i].no_kursi := j;
								TabPenerbangan[j] := tmp[i];
								break;
							end;
						end;
					end	
					else if tmp[i].kelas = 'ekonomi' then
					begin
						for j := 1 to 49 do
						begin
							if TabPenerbangan[j].nama ='' then
							begin
								tmp[i].harga := PRICE;
								tmp[i].no_kursi := j;
								TabPenerbangan[j] := tmp[i];
								break;
							end;
						end;
					end;
				end;
				
				writeln;
				for i := 1 to Npenerbangan do
				begin
					writeln('[BOOKING] INFORMATION : ');
					writeln('>> Reservasi  : GA30#',' ', tmp[i].kelas, '-', tmp[i].no_kursi);
					writeln('>> Nama       : ', tmp[i].nama);
					writeln('>> Kelas      : ', tmp[i].kelas);
					writeln('>> Nomor Kursi: ', tmp[i].no_kursi);
					writeln;
				end;
			end
			else
			begin
				writeln('----------------------------------------------------------');
				writeln('Anda Hanya Bisa Memesan 4 Tiket Dalam Satu Kali Transaksi');
				writeln('----------------------------------------------------------');
			end;
			readln;
			
		end;
	
		
		procedure tampilkan;
		var
			i : integer;
		begin
		clrscr;
		begin
			for i := 1 to MAX do
			begin
				if TabPenerbangan[i].nama <> '' then
				begin
					writeln(' Nama Pemesan : ',TabPenerbangan[i].nama);
					writeln('|-----------------------------------------|');
					writeln(' Id Ktp : ',TabPenerbangan[i].id_ktp);
					writeln('|-----------------------------------------|');
					writeln(' Kelas Pemesanan : ',TabPenerbangan[i].kelas);
					writeln('|-----------------------------------------|');
					writeln(' Tanggal Keberangkatan : ',TabPenerbangan[i].jadwal);
					writeln('|-----------------------------------------|');
					writeln(' No Kursi : ',TabPenerbangan[i].no_kursi);
					writeln('|-----------------------------------------|');
					writeln(' Harga : ',TabPenerbangan[i].harga:0:0);
					writeln('|=========================================|');
					readln;
				end
			end;
		end;
		end;
		
	

		procedure pemesanan;
		var
		kembali: boolean;
		begin
		kembali := true;
		repeat
		begin
		clrscr;
			writeln('=============================');
			writeln('        MENU PEMESANAN      ');
			writeln('=============================');
			writeln('||1.PEMESANAN              ||');
			writeln('||2.kembali                ||');
			writeln('=============================');
			write('Masukkan Pilihan Anda : ');
			readln(pil);
			case pil of
				1 : tambah;
				2 : kembali := false;
				
			end;
		end;
		until (kembali = false);
		end;

		
		procedure lihat_pemesana();
		var
			kembali: boolean;
		begin
			kembali := true;
		repeat
		begin
		clrscr;
			writeln('=============================');
			writeln('        Lihat Pemesan        ');
			writeln('=============================');
			writeln('||1.Tampilkan              ||');
			writeln('||2.kembali                ||');
			writeln('=============================');
			write('Masukkan Pilihan Anda : ');
			readln(pil);
			case pil of
				1 : tampilkan;
				2 : kembali := false;
				
			end;
		end;
        until(kembali =false);
        end;
	

		function cari_id(cari : String):integer;
		var
		i,k :integer;
		found : boolean;

		begin
		k:=0;
		found:= false;
		i := 1;
		while (not found) and (i<= Npenerbangan) do
		begin
			if(TabPenerbangan[i].id_ktp = cari) then
			begin
					k:=i;
					found:=true;
			end
			else
			begin
					i:=i+1;
			end;
		end;
				cari_id:=k;
                end;


		function cari_id_super(cari : String):integer;
		var
		i,k :integer;
		found : boolean;

		begin
		k:=0;
		found:= false;
		i := 150;
		while (not found) and (i>= 50) do
		begin
			if(TabPenerbangan[i].id_ktp = cari) then
			begin
					k:=i;
					found:=true;
			end

			else
			begin
					i:=i-1;
			end;

		end;
				cari_id_super :=k;



		end;


		procedure cari_id1;
		var
			cari : String;
			index : integer;
		begin
		clrscr;
			write('Masukan Id Penerbangan Yang Ingin Dicari = ');
			readln(cari);
			if ((cari_id(cari) <> 0) and (cari_id_super(cari) = 0)) then
				begin
					index := cari_id(cari);
			end
			else if ((cari_id(cari) = 0) and (cari_id_super(cari) <> 0)) then
				begin
					index := cari_id_super(cari);
			end
			else
				begin
				index :=0;
			end;
		
			if ( index <> 0) then
			begin
				clrscr;
				writeln(' Nama Pemesan : ',TabPenerbangan[index].nama);
				writeln('|-----------------------------------------|');
				writeln(' Id Ktp : ',TabPenerbangan[index].id_ktp);
				writeln('|-----------------------------------------|');
				writeln(' Kelas Pemesanan : ',TabPenerbangan[index].kelas);
				writeln('|-----------------------------------------|');
				writeln(' Tanggal Keberangkatan : ',TabPenerbangan[index].jadwal);
				writeln('|-----------------------------------------|');
				writeln(' No Kursi : ',TabPenerbangan[index].no_kursi);
				writeln('|=========================================|');
			end
			else
			begin
				clrscr;
				writeln('-----------------------------------------');
				writeln('||* MAAF ID YANG ANDA CARI TIDAK ADA*  ||');
				writeln('-----------------------------------------');
			end;	
			readln;
		end;
		
				
		function cari_nama(cari : String):integer;
		var
		i,k :integer;
		found : boolean;
		
		begin
		k:=0;
		found:= false;
		i := 1;			
		while (not found) and (i<= Npenerbangan) do
		begin
			if(TabPenerbangan[i].nama = cari) then
			begin
				k:=i;
				found:=true;
			end
			else	
			begin
				i:=i+1;
			end;
		end;			
			cari_nama:=k;
		end;
		
		function cari_nama_super(cari : String):integer;
		var
		i,k :integer;
		found : boolean;

		begin
		k:=0;
		found:= false;
		i := 150;
					
		while (not found) and (i >=50) do
		begin
			if(TabPenerbangan[i].nama = cari) then
			begin
				k:=i;
				found:=true;
			end
			else	
			begin
				i:=i-1;
			end;
		end;			
			cari_nama_super:=k;
		end;
	
		procedure cari_nama1;
		var
			cari : String;
			index : integer;
		begin
		clrscr;
			write('Masukan Nama Penerbangan Yang Ingin Dicari = ');
			readln(cari);
			if ((cari_nama(cari) <> 0) and (cari_nama_super(cari) = 0)) then
				begin
					index := cari_nama(cari);
			end
			
			else if ((cari_nama(cari) = 0) and (cari_nama_super(cari) <> 0)) then
				begin
					index := cari_nama_super(cari);
			end
			
			else
				begin
				index :=0;
			end;
		
			if ( index <> 0) then
			begin
				clrscr;
				writeln(' Nama Pemesan : ',TabPenerbangan[index].nama);
				writeln('|-----------------------------------------|');
				writeln(' Id Ktp : ',TabPenerbangan[index].id_ktp);
				writeln('|-----------------------------------------|');
				writeln(' Kelas Pemesanan : ',TabPenerbangan[index].kelas);
				writeln('|-----------------------------------------|');
				writeln(' Tanggal Keberangkatan : ',TabPenerbangan[index].jadwal);
				writeln('|-----------------------------------------|');
				writeln(' No Kursi : ',TabPenerbangan[index].no_kursi);
				writeln('|=========================================|');
			end
			else
			begin
				clrscr;
				writeln('-----------------------------------------');
				writeln('||* MAAF Nama YANG ANDA CARI TIDAK ADA*  ||');
				writeln('-----------------------------------------');
	
			end;	
			readln;
		end;
		
				
		function cari_kelas(cari : String):integer;
		var
		i,k :integer;
		found : boolean;

		begin
		k:=0;
		found:= false;
		i := 1;
						
		while (not found) and (i<= Npenerbangan) do
		begin
			if(TabPenerbangan[i].kelas = cari) then
			begin
					k:=i;
					found:=true;
			end
			else	
			begin
					i:=i+1;
			end;
		end;			
				cari_kelas:=k;
		end;
		
		
		function cari_kelas_super(cari : String):integer;
		var
		i,k :integer;
		found : boolean;

		begin
		k:=0;
		found:= false;
		i := 150;
						
		while (not found) and (i>=50) do
		begin
			if(TabPenerbangan[i].kelas = cari) then
			begin
					k:=i;
					found:=true;
			end
			else	
			begin
					i:=i-1;
			end;
		end;			
				cari_kelas_super:=k;
		end;
		
		procedure cari_kelas1;
		var
			cari : String;
			index : integer;
		begin
		clrscr;
				write('Masukan Kelas Penerbangan Yang Ingin Dicari = ');
				readln(cari);
				if ((cari_kelas(cari) <> 0) and (cari_kelas_super(cari) = 0)) then
				begin
					index := cari_kelas(cari);
				end
				
				else if ((cari_kelas(cari) = 0) and (cari_kelas_super(cari) <> 0)) then
					begin
						index := cari_kelas_super(cari);
				end
				
				else
					begin
					index :=0;
				end;
			
				if ( index <> 0) then
				begin
					clrscr;
						writeln(' Nama Pemesan : ',TabPenerbangan[index].nama);
						writeln('|-----------------------------------------|');
						writeln(' Id Ktp : ',TabPenerbangan[index].id_ktp);
						writeln('|-----------------------------------------|');
						writeln(' Kelas Pemesanan : ',TabPenerbangan[index].kelas);
						writeln('|-----------------------------------------|');
						writeln(' Tanggal Keberangkatan : ',TabPenerbangan[index].jadwal);
						writeln('|-----------------------------------------|');
						writeln(' No Kursi : ',TabPenerbangan[index].no_kursi);
						writeln('|=========================================|');
				end
				else
				begin
					clrscr;
					writeln('-----------------------------------------');
					writeln('||* MAAF KELAS YANG ANDA CARI TIDAK ADA*||');
					writeln('-----------------------------------------');
		
				end;	
				readln;
		end;
		
	
		
		procedure cari();
		var
			kembali: boolean;
		begin
			kembali := true;
		repeat
		begin
		clrscr;
			writeln('=============================');
			writeln('          Menu Cari          ');
			writeln('=============================');
			writeln('||1. Cari Id_KTP           ||');
			writeln('||2. Cari Nama             ||');
			writeln('||3. Cari Kelas            ||');
			writeln('||4. kembali               ||');
			writeln('=============================');
			write('Masukkan Pilihan Anda : ');
			readln(pil);
			case pil of
				1 : cari_id1;
				2 : cari_nama1;
				3 : cari_kelas1;
				4 : kembali := false;
			end;
		end;
        until(kembali =false);
        end;
		
			
	procedure editpemesanan;
	var
		index :integer;
		cari,gg: string;
		cek : char;
		temp : penerbangan;
		q : integer;
	begin
		clrscr;
			write('Masukan ID KTP : ');
			readln(cari);
			if ((cari_id(cari) <> 0) and (cari_id_super(cari) = 0)) then
				begin
					index := cari_id(cari);
			end
			
			else if ((cari_id(cari) = 0) and (cari_id_super(cari) <> 0)) then
				begin
					index := cari_id_super(cari);
			end
			
			else
				begin
				index :=0;
			end;
				
			if ( index <> 0) then
			begin
				writeln('Anda masuk ke Menu Edit');
				writeln('-------------------------');
				writeln;
				writeln('Nama : ',TabPenerbangan[index].nama);
				writeln('Id KTP : ',TabPenerbangan[index].id_ktp);
				writeln('Kelas penerbangan : ',TabPenerbangan[index].kelas);
				writeln('Jadwal penerbangan : ',TabPenerbangan[index].jadwal);
				writeln('');
				write('Ubah kelas penerbangan ? y/n : '); readln(cek);
					if (cek='y') then
					begin
						temp := TabPenerbangan[index];
						writeln('Masukan kelas penerbangan : '); readln(gg);
							if (gg = 'ekonomi') then
								begin
								temp.kelas := gg;
								q := 1;
									while ((TabPenerbangan[q].nama <> '') and (q<>49)) do
										begin
										q := q+1;
									end;

									TabPenerbangan[q] := temp;
									TabPenerbangan[q].no_kursi := q;
									TabPenerbangan[q].harga := TabPenerbangan[q].harga+200000; 
						
									TabPenerbangan[index].nama :='';
									TabPenerbangan[index].id_ktp :='';
									TabPenerbangan[index].kelas :='';
									TabPenerbangan[index].jadwal :='';
						
								
							end 
							
							else 
								begin
								temp.kelas := gg;
								q := 150;
									while ((TabPenerbangan[q].nama <> '') and (q<>50)) do
										begin
										q := q-1;
									end;

									TabPenerbangan[q] := temp;
									TabPenerbangan[q].no_kursi := q;
									
									TabPenerbangan[index].nama :='';
									TabPenerbangan[index].id_ktp :='';
									TabPenerbangan[index].kelas :='';
									TabPenerbangan[index].jadwal :='';
							end;
						
						
						clrscr;
						writeln('|------*ANDA BERHASIL MENGEDIT PEMESANAN*------|');
						readln;
					end
					else
						begin
						writeln('Edit pemesanan dibatalkan');
						readln;
						clrscr;
					end;
			
			
			end
			else
			begin
				clrscr;
				writeln('----* MAAF PEMESANAN YANG ANDA EDIT TIDAK ADA*----');

			readln;
			end;
		
		end;
		
		procedure hapusPenerbangan;
		
		var
			 idx,k: Integer;
			 temp : penerbangan;
             cari:string;
		begin
        clrscr;
                    writeln('Masukan ID KTP Yang Ingin Di Hapus : ');
                    readln(cari);
					if ((cari_id(cari) <> 0) and (cari_id_super(cari) = 0)) then
					begin
							idx := cari_id(cari);
					end
					else if ((cari_id(cari) = 0) and (cari_id_super(cari) <> 0)) then
					begin
							idx := cari_id_super(cari);
					end
					else
					begin
						idx :=0;
					end;
                    if idx <> 0 then
                    begin
							TabPenerbangan[idx].nama := '';
							TabPenerbangan[idx].id_ktp := '';
							TabPenerbangan[idx].kelas := '';
							TabPenerbangan[idx].jadwal :=  ' ';
							for k:=1 to i do
							begin
								  if (  TabPenerbangan[idx].nama = '') and (TabPenerbangan[idx].id_ktp = '') and  ( TabPenerbangan[idx].kelas = '') or  (  TabPenerbangan[idx].jadwal =  ' ')  then
								  begin
									temp:= TabPenerbangan[k];
									TabPenerbangan[k] := TabPenerbangan[k+1];
									TabPenerbangan[k+1]:=temp;
								end;
							end;
							i := i-1;
							writeln('--Data Berhasil Dihapus--');
							readln;
							jml_tiket := jml_tiket +1;
							if(jml_tiket >150) then
							begin
								jml_tiket := 150;
							end;
                    end
                    else
					begin
                            writeln('--Data Tidak Ditemukan--');
							readln;
					end;
					

		end;
			
			
		procedure edit_data();
		var
			kembali: boolean;
		begin
			kembali := true;
		repeat
		begin
		clrscr;
			writeln('=============================');
			writeln('       Menu EDIT DATA        ');
			writeln('=============================');
			writeln('||1. Hapus Pemesanan       ||');
			writeln('||2. Edit Pemesanan        ||');
			writeln('||3. Kembali               ||');
			writeln('=============================');
			write('Masukkan Pilihan Anda : ');
			readln(pil);
			case pil of
				1 : hapusPenerbangan;
				2 : editpemesanan;
				3 : kembali := false;
			end;
		end;
        until(kembali =false);
        end;
		
		procedure sort_id_menurun;
		var 
			i,k: integer;
			temp : penerbangan;
		begin
		
			for i:= 1 to MAX-1 do
			begin
				
				for k := MAX downto i+1 do 
				begin
				
					if(TabPenerbangan[k].id_ktp > TabPenerbangan[k-1].id_ktp) then
					begin
						temp := TabPenerbangan[k];
						TabPenerbangan[k] := TabPenerbangan[k-1];
						TabPenerbangan[k-1] := temp;
						
					end;
				end;
	
			end;
			tampilkan;
		
		end;
		
		procedure sort_id_menaik;
		var 
			i,k: integer;
			temp : penerbangan;
		begin
		
			for i:= 1 to MAX-1 do
			begin
				for k := MAX downto i+1 do 
				begin
				
					if(TabPenerbangan[k].id_ktp < TabPenerbangan[k-1].id_ktp) then
					begin
						temp := TabPenerbangan[k];
						TabPenerbangan[k] := TabPenerbangan[k-1];
						TabPenerbangan[k-1] := temp;
						
					end;
				end;
	
			end;
			tampilkan;
		
		end;
		
		procedure informasi();
		var
			kembali: boolean;
		begin
			kembali := true;
		repeat
		begin
		clrscr;
			writeln('=================================================');
			writeln('         INFORMASI PEMESANAN BERDASARKAN        ');
			writeln('=================================================');
			writeln('||1.DAFTAR Pemesanan Urut Id KTP Kecil-besar   ||');
			writeln('||2.DAFTAR PEMESANAN URUT id KTP Besar-kecil   ||');
			writeln('||3.kembali                                    ||');
			writeln('=================================================');
			write('Masukkan Pilihan Anda : ');
			readln(pil);
			case pil of
				1 : begin
					sort_id_menaik;
					end;
				2 : begin
					sort_id_menurun;
					end;
				3 : kembali := false;
			end;
		end;
        until(kembali =false);
        end;

		procedure  tampilan1;
		var
			keluar : boolean;
		begin
		keluar := true;
		repeat
		begin
		clrscr;
			writeln('========================================');
			writeln('**     -------------------------      **');
			writeln('**     |        APLIKASI       |      **');
			writeln('**-----|    RESERVASI TIKET    | -----**');
			writeln('**     |      PENERBANGAN      |      **');
			writeln('**     -------------------------      **');
			writeln('=========================================');
			writeln('||            MENU UTAMA              ||');
			writeln('=========================================');
			writeln('|| 1.PEMESANAN                        ||');
			writeln('|| 2.LIHAT PEMESANAN                  ||');
			writeln('|| 3.EDIT DATA                        ||');
			writeln('|| 4.CARI                             ||');
			writeln('|| 5.INFORMASI PEMESANAN              ||');
			writeln('|| 6.KELUAR                           ||');
			writeln('========================================');
			write('Masukkan Pilihan Anda : ');
			readln(pil);
			case pil of
				1 : pemesanan;
				2 : lihat_pemesana;
				3 : edit_data;
				4 : cari;
				5 : informasi;
				6 : keluar :=false;

			end;
		end;
		until(keluar = false);
		end;
		
		
		procedure loat;
		
		begin
			assign(pitapenerbangan, 'tubes.txt');
			reset(pitapenerbangan);
			while not EOF(pitapenerbangan) do
			begin
				Npenerbangan := Npenerbangan+1;
				read(pitapenerbangan,TabPenerbangan[Npenerbangan]);
			end;
		end;
			
		procedure save;
		var
			i : integer;
		
		begin
			rewrite(pitapenerbangan);
			for i := 1 to Npenerbangan do
			begin
				write(pitapenerbangan,TabPenerbangan[i]);
			end;
			close(pitapenerbangan);
		end;


begin
	Npenerbangan :=0;
	jml_tiket :=150;
	loat;
	begin
		clrscr;
		tampilan1;
	end;
	save;
	readln;
end.


