library	ieee;																			-- klauzula dostepu do biblioteki 'IEEE'
use		ieee.std_logic_1164.all;												-- dolaczenie calego pakietu 'STD_LOGIC_1164'
use		ieee.std_logic_arith.all;												-- dolaczenie calego pakietu 'STD_LOGIC_ARITH'
use		ieee.std_logic_unsigned.all;											-- dolaczenie calego pakietu 'STD_LOGIC_UNSIGNED'
use		ieee.std_logic_misc.all;												-- dolaczenie calego pakietu 'STD_LOGIC_MISC'
use		work.package_types.all;													-- dolaczenie pakietu z typami 

entity CALC_TB is
	generic (
		constant CLOCK_SPEED		: natural := 200_000_000;					-- czestotliwosc zegara systemowego w [Hz]
		constant BOD				: natural := 20_000_000;					-- predkosc nadawania w [bodach]
		constant WORD_LEN			: natural := 8;								-- liczba bitow slowa danych (5-8)
		constant PAR_LEN			: natural := 1;								-- liczba bitow parzystosci (0-1)
		constant STOP_LEN			: natural := 2;								-- liczba bitow stopu (1-2)
		constant MAX_ARGS			: natural := 5									-- maksymalna liczba argumentow zadania
	);
end CALC_TB;

architecture behavioural of CALC_TB is

	constant O_ZEGARA				: time := 1 sec/CLOCK_SPEED;				-- okres zegara systemowego
	constant O_BITU				: time := 1 sec/BOD;							-- okres czasu trwania jednego bodu
	constant zadanie 				: string := "(+521)+(-41)+(12)-36=";	-- zadanie kalkulatora
	signal R							: std_logic := '0';							-- symulowany sygnal resetujacacy
	signal C							: std_logic := '1';							-- symulowany zegar taktujacy inicjowany na '1'
	signal RX_TX					: std_logic;									-- obserwowane wyjscie 'TX'
	signal START					: std_logic;									-- informacja o nadawaniu
	signal DONE_TX					: std_logic;									-- obserwowane wyjscie 'DONE' nadajnika
	signal DONE_RX					: std_logic;									-- obserwowane wyjscie 'DONE' odbiornika
	signal D_IN	:std_logic_vector(WORD_LEN-1 downto 0) :="00000000";	-- symulowane slowo wejsciowe
	signal D_OUT:std_logic_vector(WORD_LEN-1 downto 0) :="00000000";	-- obserwowane slowo wyjsciowe
	signal TRANSMITTING  		: std_logic :='0';							-- obserwowane wyjscie 'TRANSMITTING'
	signal TIMER_OUT_TX 			: natural range 0 to CLOCK_SPEED/BOD;	-- obserwowane wyjscie 'TIMER_OUT' nadajnika
	signal STATUS_OUT_TX 		: STATUSY;										-- obserwowane wyjscie 'STATUS_OUT' nadajnika
	signal TIMER_OUT_RX 			: natural range 0 to CLOCK_SPEED/BOD;	-- obserwowane wyjscie 'TIMER_OUT' odbiornika
	signal STATUS_OUT_RX 		: STATUSY;										-- obserwowane wyjscie 'STATUS_OUT' odbiornika
	signal PROCESSING				: bit;											-- sygnal pomocniczy (do debugowania) do obserwowania stanu symulacji
	signal BIT_NUMBER				: natural range 0 to WORD_LEN;			-- obserwowane wyjscie z numerem bitu
	signal ERROR					: std_logic;									-- obserwowane wyjscie 'ERROR'
	signal WRITING					: bit;											-- obserwowane wyjscie 'WRITING'
	signal DONE_CALC				: std_logic;									-- obserwowane wyjscie 'DONE' kalkulatora
	signal RESULT					: integer;										-- wynik obliczen kalkulatora
	signal STATUS_OUT_CALC		: STATUSES;										-- obserwowane wyjscie 'STATUS_OUT' kalkulatora
	signal ARGS_OUT				: TAB_I(MAX_ARGS downto 0);				-- obserowane argumenty kalkulatora
	signal CYFRA_OUT				: natural;										-- aktualnie przetwarzana cyfra w kalkulatorze
	signal OPERATIONS_OUT		: TAB_O (MAX_ARGS downto 0);				-- obserwowane operacje kalkulatora
begin

	process is																			-- proces bezwarunkowy
	begin																					-- czesc wykonawcza procesu
		R <= '1'; wait for 100 ns;													-- ustawienie sygnalu 'res' na '1' i odczekanie 100 ns
		R <= '0'; wait;																-- ustawienie sygnalu 'res' na '0' i zatrzymanie
	end process;																		-- zakonczenie procesu

	process is																			-- proces bezwarunkowy
	begin																					-- czesc wykonawcza procesu
		C <= not(C); wait for O_ZEGARA/2;										-- zanegowanie sygnalu 'clk' i odczekanie pol okresu zegara
	end process;																		-- zakonczenie procesu

	process is																			-- proces bezwarunkowy
	begin																					-- czesc wykonawcza procesu
		START		<= '0';																-- incjalizacja sygnalu 'START' na wartosci spoczynkowa
		for i in 1 to zadanie'length loop										-- petla po kolenych wysylanych znakach
			D_IN		<= CONV_STD_LOGIC_VECTOR(character'pos(zadanie(i)),D_IN'length); -- pobranie i konwersja 'i-tego' znaku ASCII
			wait for 200 ns;															-- odczekanie 200 ns
			START 		<= '1';														-- ustawienie 'START' na wartosc bitu START
			PROCESSING 	<= '1';														-- ustawienie sygnalu pomocniczego na '1'
			wait for O_BITU;															-- odczekanie jednego bodu
			for i in 0 to WORD_LEN - 1 loop										-- petla po kolejnych bitach slowa danych 'D'
			wait for O_BITU;															-- odczekanie jednego bodu
			end loop;																	-- zakonczenie petli
			START <= '0';																-- wylaczenie bitu nadawania danej
			if (par_len = 1) then													-- badanie aktywowania bitu parzystosci
				wait for O_BITU;														-- odczekanie jednego bodu
			end if;																		-- zakonczenie instukcji warunkowej
			for i in 0 to STOP_LEN - 1 loop										-- petla po liczbie bitow STOP
				wait for O_BITU;														-- odczekanie jednego bodu
			end loop;																	-- zakonczenie petli
			PROCESSING <= '0';														-- ustawienie sygnalu pomocniczego na '0'
			wait for 40 * O_ZEGARA;													-- odczekanie 40-stu okresow zegara
		end loop;																		-- zakonczenie petli
		wait;
	end process;																		-- zakonczenie procesu

	SENDER_INST: entity work.SENDER												-- instancja odbiornika szeregowego 'SENDER'
		generic map(																	-- mapowanie parametrow biezacych
			CLOCK_SPEED				=> CLOCK_SPEED,								-- czestotliwosc zegara w [Hz]
			BOD						=> BOD,											-- predkosc odbierania w [bodach]
			WORD_LEN					=> WORD_LEN,									-- liczba bitow slowa danych (5-8)
			PAR_LEN					=> PAR_LEN,										-- liczba bitow parzystosci (0-1)
			STOP_LEN					=> STOP_LEN										-- liczba bitow stopu (1-2)
		)
		port map(																		-- mapowanie sygnalow do portow
			R							=> R,												-- sygnal resetowania
			C							=> C,												-- zegar taktujacy
			D							=> D_IN,											-- slowo danych
			TX							=> RX_TX,										-- nadawany sygnal szeregowy
			START						=> START,										-- informacja o rozpoczeciu nadawania
			DONE						=> DONE_TX,										-- flaga zakonczenia nadawania danej
			TRANSMITTING			=> TRANSMITTING,								-- informacja o nadawaniu
			TIMER_OUT				=> TIMER_OUT_TX,								-- obserwowany licznik zegara
			STATUS_OUT				=> STATUS_OUT_TX,								-- obserwowany status
			BIT_NUMBER				=> BIT_NUMBER									-- obserwowany numer bitu
		);

	RECEIVER_INST: entity work.RECEIVER											-- instancja odbiornika szeregowego 'RECEIVER'
		generic map(																	-- mapowanie parametrow biezacych
			CLOCK_SPEED				=> CLOCK_SPEED,								-- czestotliwosc zegara w [Hz]
			BOD						=> BOD,											-- predkosc odbierania w [bodach]
			WORD_LEN					=> WORD_LEN,									-- liczba bitow slowa danych (5-8)
			PAR_LEN					=> PAR_LEN,										-- liczba bitow parzystosci (0-1)
			STOP_LEN					=> STOP_LEN										-- liczba bitow stopu (1-2)
		)
		port map(																		-- mapowanie sygnalow do portow
			R							=> R,												-- sygnal resetowania
			C							=> C,												-- zegar taktujacy
			D							=> D_OUT,										-- slowo danych
			RX							=> RX_TX,										-- odbierany sygnal szeregowy
			START						=> TRANSMITTING,								-- informacja o rozpoczeciu nadawania
			ERROR						=> ERROR,										-- flaga wykrycia bledu w odbiorze
			DONE						=> DONE_RX,										-- flaga zakonczenia odbioru
			WRITING					=> WRITING,										-- flaga pisania
			TIMER_OUT				=> TIMER_OUT_RX,								-- obserwowany licznik zegara
			STATUS_OUT				=> STATUS_OUT_RX								-- obserwowany status
		);
		
	KALKULATOR_INST: entity work.KALKULATOR									-- instancja kalkulatora
		generic map(																	-- mapowanie parametrow biezacych
			MAX_ARGS					=> MAX_ARGS										-- maksymalna liczba argumentow zadania
		)
		port map(																		-- mapowanie sygnalow do portow
			R							=> R,												-- sygnal resetowania
			C							=> C,												-- zegar taktujacy
			CALC_D_IN				=> D_OUT,										-- slowo danych
			PASS						=> DONE_RX,										-- odbierany sygnal szeregowy
			DONE						=> DONE_CALC,									-- obserwowane wyjscie 'DONE' kalkulatora
			RESULT					=> RESULT,										-- rezultat obliczen
			STATUS_OUT				=>	STATUS_OUT_CALC,							-- obserwowany status kalkulatora
			ARGS_OUT					=> ARGS_OUT,									-- obserwowane argumenty kalkulatora
			OPERATIONS_OUT			=> OPERATIONS_OUT								-- obserowane operacje kalkulatora
		);
end behavioural;