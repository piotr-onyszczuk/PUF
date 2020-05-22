library	IEEE;																				-- klauzula dostepu do biblioteki 'IEEE'
use		IEEE.STD_LOGIC_1164.ALL;													-- dolaczenie calego pakietu 'STD_LOGIC_1164'
use		ieee.std_logic_unsigned.all;												-- dolaczenie calego pakietu 'STD_LOGIC_UNSIGNED'
use		work.package_types.all;														-- dolaczenie pakietu z typami 

entity KALKULATOR is
	generic (
		WORD_LEN			: natural := 8;												-- dlugosc slowa wejsciowego
		MAX_ARGS			: natural := 5													-- maksymalna liczba argumentow zadania
	);
	port (
		CALC_D_IN		: in std_logic_vector (WORD_LEN - 1 downto 0);		-- wejscie danych 'D'
		C					: in std_logic;												-- clock
		R					: in std_logic;												-- reset
		PASS				: in std_logic;												-- mozna czytac liczbe/znak
		DONE				: out std_logic;												-- informacja o zwrocie
		ERR_OUT	      : out std_logic;							 					-- informacja o bledzie
		RESULT			: out integer;													-- wynik/otrzymanyznak
		STATUS_OUT		: out STATUSES;												-- wyjscie statusow
		ARGS_OUT			: out TAB_I (MAX_ARGS downto 0);							-- lista argumentow zadania (do obserwowania)
		OPERATIONS_OUT	: out TAB_O (MAX_ARGS downto 0)							-- lista operacji zadania (do obserowania)
	);
end KALKULATOR;

architecture cialo of KALKULATOR is
	signal STATUS		: STATUSES;														-- status progaramu
	constant NUM_CO	: natural := 48;												-- '0' ASCII
	constant PL_CO		: natural := 43;												-- '+' ASCII
	constant SU_CO		: natural := 45;												-- '-' ASCII
	constant RES_CO	: natural := 61;												-- '=' ASCII
	constant BROP_CO	: natural := 40;												-- '(' ASCII
	constant BRCL_CO	: natural := 41;												-- ')' ASCII
	signal WAS_READ	: std_logic := '0';											-- czy wczytano aktualny znak
	signal READ_NUM	: std_logic := '0';											-- czy ostatni wczytany znak byl cyfra
	signal ARG_READING: std_logic := '0';											-- czy jestesmy w trakcie wczytywania liczby
	signal BRACKET_OPEN: std_logic := '0';											-- czy otwarty nawias
	signal RESULT_FOUND: std_logic := '0';											-- czy obliczono wynik
	signal ERR	      : std_logic := '0';											-- wewnetrzna informacja o bledzie
	signal CURR_SIGN	: OPERANDS := NONE;											-- aktualny znak liczby (w przypadku wystapienia nawiasu)
	signal ARGUMENTS	: TAB_I(MAX_ARGS downto 0) := (others => 0);			-- tablica argumentow
	signal ARGS_COUNT	: natural :=0;													-- liczba argumentow
	signal OST_CYFRA	: natural := 0;												-- ostatnia wczytana cyfra
	signal OPERATIONS	:TAB_O (MAX_ARGS downto 0) := (others => NONE);		-- tablica operacji
	signal OPS_COUNT	: natural :=0;													-- liczba operacji
begin
	process (C, R) is
	variable D				: natural :=0;												-- przekonwertowane wejscie
	variable RESULT_TMP	: integer :=0;												-- zmienna pomocnicza do sumowania
   begin
		if (R = '1') then																	-- resetowanie zmiennych
			ARGS_COUNT	<= 0;
			OPS_COUNT	<= 0;
			STATUS		<= ARGUMENTY;
			DONE			<= '0';
			RESULT		<= 0;
			ERR			<= '0';
			WAS_READ		<= '0';
			READ_NUM		<= '0';
			ARG_READING	<= '0';
			BRACKET_OPEN<= '0';
			RESULT_FOUND<= '0';
			OPERATIONS	<= (others => NONE);
			ARGUMENTS 	<= (others => 0);
		elsif (C'event and C='1' and ERR = '0') then
			D := CONV_INTEGER(CALC_D_IN);												-- konwersja wejscia
			if (STATUS = ARGUMENTY) then												-- wczytywanie argumentow
				if (PASS = '1' and WAS_READ = '0') then							-- nowy symbol
					WAS_READ <= '1';														-- oznaczenie przeczytania symbolu
					if (D = PL_CO) then													-- '+'
						if (ARG_READING = '0' and BRACKET_OPEN = '0') then		-- sprawdzenie czy nie ma dwoch operatorow po kolei
							ERR <= '1';
						end if;
						if (BRACKET_OPEN = '1') then									-- byl nawias - oznaczenie znaku liczby
							if (CURR_SIGN = NONE) then
								CURR_SIGN <= PLUS;
							else																-- nie moze byc dwoch operatorow pod nawiasem
								ERR <= '1';
							end if;
						else
							ARG_READING									<= '0';			-- koniec wczytywania liczby
							ARGUMENTS(ARGUMENTS'left downto 1)	<= ARGUMENTS(ARGUMENTS'left-1 downto 0); -- przesuniecie argumentow
							OPERATIONS(0)								<= PLUS;			-- aktualizacja operacji
							OPERATIONS(OPERATIONS'left downto 1)<= OPERATIONS(OPERATIONS'left-1 downto 0); -- aktualizacja operacji
							WAS_READ										<= '1';			-- przeczytano
							OPS_COUNT									<= OPS_COUNT + 1; -- zwiekszenie liczby operacji
						end if;
					elsif (D = SU_CO) then												-- '-'
						if (ARG_READING = '0' and BRACKET_OPEN = '0') then		-- sprawdzenie czy nie ma dwoch operatorow po kolei
							ERR <= '1';
						end if;
						if (BRACKET_OPEN = '1') then									-- byl nawias - oznaczenie znaku liczby
							if (CURR_SIGN = NONE) then
								CURR_SIGN <= MINUS;
							else																-- nie moze byc dwoch operatorow pod nawiasem
								ERR <= '1';
							end if;
						else
							ARG_READING									<= '0';			-- koniec wczytywania liczby
							OPERATIONS(0)								<= MINUS;		-- aktualizacja operacji
							OPERATIONS(OPERATIONS'left downto 1)<= OPERATIONS(OPERATIONS'left-1 downto 0); -- aktualizacja operacji
							ARGUMENTS(ARGUMENTS'left downto 1)	<= ARGUMENTS(ARGUMENTS'left-1 downto 0); -- przesuniecie arguementow
							WAS_READ										<= '1';			-- przeczytano
							OPS_COUNT									<= OPS_COUNT + 1; -- zwiekszenie liczby operacji
						end if;
					elsif (D = BROP_CO) then											-- '('
						if(ARG_READING = '1' or BRACKET_OPEN = '1') then		-- nie mozna otworzyc nawiasu w trakcie liczby ani przed zamknieciem poprzedniego
							ERR <= '1';
						end if;
							BRACKET_OPEN <= '1';											-- otwarto nawias
					elsif (D = BRCL_CO) then											-- ')'
						if(ARG_READING = '0' or BRACKET_OPEN = '0') then		-- nie mozna zamknac nawiasu bezposrednio po operatorze ani przed otwarciem nawiasu
							ERR <= '1';
						end if;
							BRACKET_OPEN <= '0';											-- zamknieto nawias
							if (CURR_SIGN = RET) then									-- niezidentyfikowany blad
								ERR <= '1';
							end if;
							if (CURR_SIGN = MINUS) then								-- byl '-' pod nawiasem
								ARGUMENTS(0) <= -ARGUMENTS(0);						-- negacja
							end if;
							CURR_SIGN <= NONE;											-- reset
					elsif (D = RES_CO) then												-- '='
						if (ARG_READING = '0') then									-- sprawdzenie czy nie ma dwoch operatorow po kolei
							ERR <= '1';
						end if;
						if (BRACKET_OPEN = '1') then									-- nalezy zamknac nawias przed '='
							ERR <= '1';
						end if;
						ARG_READING	<= '0';												-- koniec czytania argumentu
						STATUS		<= WYNIK;											-- zmiana statusu
					elsif (D >= NUM_CO and D < (NUM_CO + 10)) then				-- cyfra
							if (ARG_READING	= '0') then								-- pierwsza cyfra argumentu
								ARG_READING		<= '1';									-- czytanie argumentu
								ARGS_COUNT		<= ARGS_COUNT + 1;					-- zwiekszenie liczby argumentow
								ARGUMENTS(0)	<= 0;										-- wyzerowanie argumentu
							else																-- kolejna cyfra argumentu
								ARGUMENTS(0) <= 10 * ARGUMENTS(0);					-- przesuniecie dziesietne
							end if;
							OST_CYFRA <=  D - NUM_CO;									-- zapamietanie cyfry
							READ_NUM <='1';												-- wczytano cyfre
					else
						ERR <= '1';												         -- niezidentyfikowany blad
					end if;
				elsif (PASS = '0') then													-- wejscie nieaktywne
					WAS_READ <= '0';														-- reset
					if(READ_NUM = '1') then												-- wczytano cyfre
						READ_NUM			<= '0';											-- reset
						ARGUMENTS(0)	<= ARGUMENTS(0) + OST_CYFRA;				-- zwiekszenie argumentu
					end if;
				end if;
			elsif (STATUS = WYNIK) then												-- obsluga statusu wyniku
				if RESULT_FOUND = '0' then 											-- sprawdzenie czy wynik zostal ju¿ obliczony
					if not(ARGS_COUNT = (OPS_COUNT + 1)) then						-- poprawnoœæ ilosci operatorow vs liczby argumentów
						ERR <= '1';
					else
						RESULT_TMP := ARGUMENTS(ARGS_COUNT-1);						-- przypisanie do zmiennej pomocniczej pierwszego argumentu
						summing: for op in MAX_ARGS downto 0 loop					-- petla po pozostalych argumentach
							if (OPERATIONS(op) = PLUS) then							-- jesli kolejna operacja to plus
								RESULT_TMP := RESULT_TMP + ARGUMENTS(op);			-- dodanie kolejnego argumentu do wyniku
						   elsif (OPERATIONS(op) = MINUS) then   					-- jesli kolejna operacja to minus
								RESULT_TMP := RESULT_TMP - ARGUMENTS(op);			-- odjecie kolejnego argumentu od wyniku
							end if;
						end loop summing;													-- koniec petli summing
						RESULT <= RESULT_TMP;											-- przypisanie wyniku do sygnalu
						RESULT_FOUND <= '1';												-- wynik zostal obliczony
						DONE <= '1';														-- zadanie wykonane
					end if;
				end if;
			else
				ERR <= '1';																	-- niezidentyfikowany blad
			end if;
		end if;
		ERR_OUT			<= ERR;															-- przekazanie na wyjscie
		STATUS_OUT		<= STATUS;														-- przekazanie na wyjscie
		ARGS_OUT			<= ARGUMENTS;													-- przekazanie na wyjscie
		OPERATIONS_OUT	<= OPERATIONS;													-- przekazanie na wyjscie
	end process;

end cialo;

