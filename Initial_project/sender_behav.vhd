library	ieee;																			-- klauzula dostepu do biblioteki 'IEEE'
use		ieee.std_logic_1164.all;												-- dolaczenie calego pakietu 'STD_LOGIC_1164'
use		ieee.std_logic_arith.all;												-- dolaczenie calego pakietu 'STD_LOGIC_ARITH'
use		ieee.std_logic_unsigned.all;											-- dolaczenie calego pakietu 'STD_LOGIC_UNSIGNED'
use		ieee.std_logic_misc.all;												-- dolaczenie calego pakietu 'STD_LOGIC_MISC'
use		work.package_types.all;													-- dolaczenie pakietu z typami 

entity SENDER_TB is
	generic (
		constant CLOCK_SPEED		: natural := 20_000_000;					-- czestotliwosc zegara systemowego w [Hz]
		constant BOD				: natural := 2_000_000;						-- predkosc nadawania w [bodach]
		constant WORD_LEN			: natural := 8;								-- liczba bitow slowa danych (5-8)
		constant PAR_LEN			: natural := 1;								-- liczba bitow parzystosci (0-1)
		constant STOP_LEN			: natural := 2									-- liczba bitow stopu (1-2)
	);
end SENDER_TB;

architecture behavioural of SENDER_TB is

	constant O_ZEGARA				: time := 1 sec/CLOCK_SPEED;				-- okres zegara systemowego
	constant O_BITU				: time := 1 sec/BOD;							-- okres czasu trwania jednego bodu

	signal R							: std_logic := '0';							-- symulowany sygnal resetujacacy
	signal C							: std_logic := '1';							-- symulowany zegar taktujacy inicjowany na '1'
	signal TX						: std_logic;									-- obserwowane wyjscie 'TX'
	signal START					: std_logic;									-- informacja o nadawaniu
	signal DONE						: std_logic;									-- obserwowane wyjscie 'DONE'
	signal D	:std_logic_vector(WORD_LEN-1 downto 0) :="00000000";		-- symulowane slowo wejsciowe
	signal TRANSMITTING  		: std_logic :='0';							-- obserwowane wyjscie 'TRANSMITTING'
	signal TIMER_OUT 				: natural range 0 to CLOCK_SPEED/BOD;	-- obserwowane wyjscie 'TIMER_OUT'
	signal STATUS_OUT 			: STATUSY;										-- obserwowane wyjscie 'STATUS_OUT'
	signal PROCESSING				: bit;											-- sygnal pomocniczy (do debugowania) do obserwowania stanu symulacji
	signal BIT_NUMBER				: natural range 0 to WORD_LEN;			-- obserwowane wyjscie z numerem bitu
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
		D			<= "00111001";														-- inicjalizacja slowa wejsciowego
		wait for 200 ns;																-- odczekanie 200 ns
		loop																				-- rozpoczecie petli nieskonczonej
			START 		<= '1';														-- ustawienie 'START' na wartosc bitu START
			PROCESSING 	<= '1';														-- ustawienie sygnalu pomocniczego na '1'
			wait for O_BITU;															-- odczekanie jednego bodu
			for i in 0 to WORD_LEN - 1 loop										-- petla po kolejnych bitach slowa danych 'D'
				wait for O_BITU;														-- odczekanie jednego bodu
			end loop;																	-- zakonczenie petli
			START <= '0';																-- wylaczenie bitu nadawania danej
			if (par_len = 1) then													-- badanie aktywowania bitu parzystosci
				wait for O_BITU;														-- odczekanie jednego bodu
			end if;																		-- zakonczenie instukcji warunkowej
			for i in 0 to STOP_LEN - 1 loop										-- petla po liczbie bitow STOP
				wait for O_BITU;														-- odczekanie jednego bodu
			end loop;																	-- zakonczenie petli
			PROCESSING <= '0';														-- ustawienie sygnalu pomocniczego na '0'
			D <= D + 7;																	-- zwiekszenie D o 7
			wait for 10 * O_ZEGARA;													-- odczekanie 10-ciu okresow zegara
		end loop;																		-- zakonczenie petli
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
			D							=> D,												-- slowo danych
			TX							=> TX,											-- odebrany sygnal szeregowy
			START						=> START,										-- informacja o rozpoczeciu nadawania
			DONE						=> DONE,											-- flaga zakonczenia nadawania danej
			TRANSMITTING			=> TRANSMITTING,								-- informacja o nadawaniu
			TIMER_OUT 				=> TIMER_OUT,									-- obserwowany licznik zegara
			STATUS_OUT 				=> STATUS_OUT,									-- obserwowany status
			BIT_NUMBER				=> BIT_NUMBER									-- obserwowany numer bitu
		);
end behavioural;