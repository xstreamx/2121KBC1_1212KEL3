domains
number, limit = integer
list = string*

facts
nondeterm pertanyaan(integer, string, char)

predicates
nondeterm mulai
nondeterm credit
nondeterm rand_int(number,limit)
nondeterm pilih(integer)
nondeterm game_stat(integer,integer,char,char)
nondeterm printlist(list)
%nondeterm jumlah_elemen(list,integer)
%nondeterm string_list(string, list)
%nondeterm cetak(integer)
%nondeterm cocokkan(char,list)

clauses
% --- Credit --- %
credit:-
	write("===================================\n"),
	printlist([
	"1. ARIF FAHRIZAL		[1515015102]\n",
	"2. DONI AHMAD		[1515015104]\n",
	"3. INDRA WIJAYA		[1515015121]"
	]),
	write("\n----------------------------------------------------------------------"),nl.

% --- Menu Utama --- %
mulai:-
	write("=====================================\n"),
	write("\tUJI PENGETAHUANMU!\n"),
	write("=====================================\n"),
	write("\t1. Mulai Permainan\n\t2. Cara Bermain\n\t3. Credits\n\t4. Keluar\n\tMasukkan Pilihan!\n\t"),
	readint(Chosen),pilih(Chosen).
	
% --- Game --- %
% Acak String %
rand_int(Hasil,Max):-	
	random(Real), 
	Hasil=Real*Max+1.
% Cetak List %
printlist([]).
printlist([H|T]):-
	write(H," "),nl,
	printlist(T).
% Kesempatan dan skor %
game_stat(1,Count,Ans,Word):-
	Ans <> Word, write("Jawaban anda salah"), 
	Score=Count*10, nl,nl,nl,write("Game Over, Skor Anda adalah ",Score),nl.
game_stat(Life,Count,Ans,Word):-
	% Jika jawaban salah %
	Ans <> Word, Score=Count*10, Lifes=Life-1, 
	nl,write("Jawaban Anda salah \nScore sementara : ",Score,"\nMasih ada ",Lifes," Kesempatan tersisa Maksimalkan sebaik mungkin\n"),
	rand_int(RandInt,20),pertanyaan(RandInt,Words,_),
	write("\n=================================================\n"),
	write("\t",Words),nl,
	write("\n=================================================\n"),
	write("Masukkan jawaban (y/t) "),readchar(Answer1), write(Answer1),nl,
	game_stat(Lifes,Count,Answer1,Word);
	
	% Jika jawaban benar %
	Ans = Word, Counts=Count+1, Score=Counts*10,
	nl,write("Score sementara : ",Score),nl,
	rand_int(RandInt,20),pertanyaan(RandInt,Words,_),
	write("\n=================================================\n"),
	write("\t",Words),nl,
	write("\n=================================================\n"),
	write("Masukkan jawaban (y/t) "),readchar(Answer1), write(Answer1),nl,
	game_stat(Life,Counts,Answer1,Word).
	
% --- Pilihan Menu--- %
pilih(P):-
P=1,	
	Lifes=3,
	rand_int(RandInt,20), 
	write("\n=================================================\n"),
	pertanyaan(RandInt,Words,Ans),
	write("\t",Words),nl,
	write("\n=================================================\n"),
	write("Masukkan jawaban (y/t) "),readchar(Tk), write(Tk),nl,
	game_stat(Lifes,0,Tk,Ans);

P=2,
	write("=====================================\n"),
	write("\tTUTORIAL BERMAIN\n"),
	write("=====================================\n"),
	printlist([
	"\t1. Cara menebak jawaban benar atau salah, bisa dengan menekan 'y' jika jawaban benar atau 't' jika jawaban salah\n",
	"\t2. Permainan ini memiliki 3 credit, dimana jika pernyataan mu salah, maka credit akan berkurang 1\n",
	"\t3. Jika pernyataanmu benar, akan mendapatkan score sebesar 10 poin, maka raih setinggi-tingginya score\n"
	]),
	mulai;

P=3,
	credit,mulai;
	
P=4,
	write("Terima kasih telah menggunakan game kami. \n"),
	fail;

P<1 ; P>4,
	write("\nPilihan yang anda masukkan tidak tersedia, Silahkan masukkan pilihan yang lain\n "),mulai.

goal
consult("word.mtr"),
mulai.