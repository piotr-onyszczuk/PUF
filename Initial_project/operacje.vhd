library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use     ieee.std_logic_unsigned.all;
use		work.package_types.all;													-- dolaczenie pakietu z typami 

entity OPERACJE is
	generic (			
		WORD_LEN  		: natural := 8 ;												-- dlugosc slowa wejsciowego
		CLOCK_SPEED		: natural := 20_000_000;									-- czestotliwosc zegara
		BOD 				: natural := 5_000_000;										-- predkosc nadawania
		MAX_NUM_LEN    : natural := 5													-- maksymalna dlugosc liczby
	);
	port (
		CALC_D_IN		: in std_logic_vector;		-- wejscie danych 'D'
		C    				: in std_logic; 												-- clock
		R    				: in std_logic; 												-- reset
		PASS				: in std_logic; 												-- mozna czytac liczbe/znak
		DONE				: out std_logic;												-- informacja o zwrocie
		RESULT			: out natural;													-- wynik/otrzymanyznak
		CURR_NATURAL	: out natural;
		STATUS_OUT		: out STATUSES;
		OPERAND_OUT		: out OPERANDS;
		BUFOR1_OUT		: out LICZBA (MAX_NUM_LEN downto 0);	
		BUFOR2_OUT		: out LICZBA (MAX_NUM_LEN downto 0)
	);
end OPERACJE;

architecture cialo of OPERACJE is
	signal STATUS 	: STATUSES;														-- status progaramu
	signal OPERAND : OPERANDS;														-- status progaramu
	signal S1		: natural range 0 to MAX_NUM_LEN;						-- licznik pozycji w slowie
	signal S2		: natural range 0 to MAX_NUM_LEN;						-- licznik pozycji w slowie
	signal TIMER 	: natural range 0 to CLOCK_SPEED/BOD;					-- licznik zegara
	constant TIME_T: natural := CLOCK_SPEED/BOD;								-- limit zegara
	constant NUM_CO: natural := 48;
	constant PL_CO : natural := 43;
	constant SU_CO : natural := 45;
	constant RES_CO: natural := 61;
	constant ERR_CO: natural := 69;
	signal BUFOR1	: LICZBA (MAX_NUM_LEN downto 0);	                                       -- bufor przetrzymujacy wynik
	signal BUFOR2	: LICZBA (MAX_NUM_LEN downto 0);	                                       -- bufor przetrzymujacy wynik
	signal RES_BUFOR	: LICZBA (MAX_NUM_LEN downto 0);	                                       -- bufor przetrzymujacy wynik
	signal RES_BUFOR2	: LICZBA (MAX_NUM_LEN downto 0);	                                       -- bufor przetrzymujacy wynik
	signal WAS_READ : std_logic;
begin
	process (C, R) is
	variable S1_L  : natural :=0;
	variable S2_L  : natural :=0;
	variable TMP1  : natural :=0;
	variable TMP2  : natural :=0;
	variable TMP3  : natural :=0;
	variable P	   : natural :=0;
	variable D		: natural :=0;
	variable ind	: natural :=0;
   begin
		if (R = '1') then																	-- resetowanie zmiennych						
			S1 		<= 0;
			S2 		<= 0;
			STATUS 	<= CZEKAJ;
			OPERAND 	<= NONE;
			DONE     <= '0';
			TIMER 	<= 0;
			RESULT   <= 0;
			WAS_READ	<= '1';
		elsif (C'event and C='1') then
			D := CONV_INTEGER(CALC_D_IN);
			CURR_NATURAL <= D;
			if (STATUS = CZEKAJ) then
				if (PASS = '1') then
					if(D >= NUM_CO) then
						STATUS <= LICZBA_1;
						BUFOR1(S1) <= D - NUM_CO;
						S1 <= S1 + 1;
					else
						RESULT <= ERR_CO;
					end if;
				end if;
			elsif (STATUS = LICZBA_1) then
				if (PASS = '1' and WAS_READ = '0') then
					WAS_READ <= '1';
					if (D = PL_CO) then
						STATUS <= LICZBA_2;
						OPERAND <= PLUS;
					elsif (D = SU_CO) then
						STATUS <= LICZBA_2;
						OPERAND <= MINUS;
					elsif (D = RES_CO) then
						S1 		<= 0;
						S2 		<= 0;
						STATUS 	<= CZEKAJ;
						OPERAND 	<= NONE;
						DONE     <= '0';
						TIMER 	<= 0;
						RESULT   <= ERR_CO;
					else
							BUFOR1(0) <= D-NUM_CO;		-- nie dziala to co bylo wczesniej
							BUFOR1(BUFOR1'left downto 1) <= BUFOR1(BUFOR1'left-1 downto 0);
							S1 <= S1 + 1;
					end if;
				elsif (PASS = '0') then
					WAS_READ <= '0';
				end if;
			elsif (STATUS = LICZBA_2) then
				if (PASS = '1' and WAS_READ = '0') then
					WAS_READ <= '1';
					if (D = PL_CO) then
						S1 		<= 0;
						S2 		<= 0;
						STATUS 	<= CZEKAJ;
						OPERAND 	<= NONE;
						DONE     <= '0';
						TIMER 	<= 0;
						RESULT   <= ERR_CO;
					elsif (D = SU_CO) then
						S1 		<= 0;
						S2 		<= 0;
						STATUS 	<= CZEKAJ;
						OPERAND 	<= NONE;
						DONE     <= '0';
						TIMER 	<= 0;
						RESULT   <= 0;
					elsif (D = RES_CO) then
						STATUS <= WYNIK;
					else
			         BUFOR2(0) <= D-NUM_CO;				--nie dziala to co bylo wczesniej
						BUFOR2(BUFOR2'left downto 1) <= BUFOR2(BUFOR2'left-1 downto 0);
						S2 <= S2 + 1;
					end if;
				elsif (PASS = '0') then
					WAS_READ <= '0';
				end if;
			elsif (STATUS = WYNIK) then
				if(OPERAND = PLUS) then
					S1_L := S1;
					S2_L := S2;
					P := 0;
					if(S1 > S2 ) then
						for I in S1 to 0 loop
							if(S1_L /= 0) then
								S1_L := S1_L - 1;
								TMP1 := BUFOR1(S1_L);
							else
								TMP1 := 0;
							end if;
							if(S2_L /= 0) then
								S2_L := S2_L - 1;
								TMP2 := BUFOR1(S2_L);
							else
								TMP2 := 0;
							end if;
								RES_BUFOR2(I) <= (TMP1+TMP2+P)mod 10;
								P := (TMP1+TMP2+P)/10;
						end loop;
					else 
						for I in S2 to 0 loop
							if(S1_L /= 0) then
								S1_L := S1_L - 1;
								TMP1 := BUFOR2(S1_L);
							else
								TMP1 := 0;
							end if;
							if(S2_L /= 0) then
								S2_L := S2_L - 1;
								TMP2 := BUFOR2(S2_L);
							else
								TMP2 := 0;
							end if;
								RES_BUFOR(I) <= (TMP1+TMP2+P)mod 10;
								P := (TMP1+TMP2+P)/10;
						end loop;
					end if;
				elsif (OPERAND = RET) then
					if(S1 > S2 ) then
						if(S1 /=0) then
							RESULT <= RES_BUFOR(S1-1);
							S1 <= S1 -1;
						else
							STATUS <= CZEKAJ;
							DONE <= '1';
						end if;
					else
						if(S2 /=0) then
							RESULT <= RES_BUFOR(S2-1);
							S2 <= S2 -1;
						else
							STATUS <= CZEKAJ;
							DONE <= '1';
						end if;
					end if;
				end if;
			else
				S1 		<= 0;
				S2 		<= 0;
				STATUS 	<= CZEKAJ;
				OPERAND 	<= NONE;
				DONE     <= '0';
				TIMER 	<= 0;
				RESULT   <= ERR_CO;
				WAS_READ	<= '0';
			end if;
		end if;
		STATUS_OUT <= STATUS;
		OPERAND_OUT <= OPERAND;
		BUFOR1_OUT <= BUFOR1;
		BUFOR2_OUT <= BUFOR2;
	end process;

end cialo;

