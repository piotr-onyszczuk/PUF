library	ieee;																			-- klauzula dostepu do biblioteki 'IEEE'
use		ieee.std_logic_1164.all;												-- dolaczenie calego pakietu 'STD_LOGIC_1164'
use		ieee.std_logic_arith.all;												-- dolaczenie calego pakietu 'STD_LOGIC_ARITH'
use		ieee.std_logic_unsigned.all;											-- dolaczenie calego pakietu 'STD_LOGIC_UNSIGNED'
use		ieee.std_logic_misc.all;												-- dolaczenie calego pakietu 'STD_LOGIC_MISC'
use		work.package_types.all;													-- dolaczenie pakietu z typami 

entity RECEIVER_TB is
	generic (
		constant CLOCK_SPEED		: natural := 20_000_000;					-- czestotliwosc zegara systemowego w [Hz]
		constant BOD				: natural := 2_000_000;						-- predkosc nadawania w [bodach]
		constant WORD_LEN			: natural := 8;								-- liczba bitow slowa danych (5-8)
		constant PAR_LEN			: natural := 1;								-- liczba bitow parzystosci (0-1)
		constant STOP_LEN			: natural := 2									-- liczba bitow stopu (1-2)
	);
end RECEIVER_TB;

architecture behavioural of RECEIVER_TB is

	constant O_ZEGARA				: time := 1 sec/CLOCK_SPEED;				-- okres zegara systemowego
	constant O_BITU				: time := 1 sec/BOD;							-- okres czasu trwania jednego bodu

	signal R							: std_logic := '0';							-- symulowany sygnal resetujacacy
	signal C							: std_logic := '1';							-- symulowany zegar taktujacy inicjowany na '1'
	signal RX						: std_logic;									-- symulowane wejscie 'RX'
	signal SLOWO					: std_logic_vector(WORD_LEN-1 downto 0);-- symulowane slowo wejsciowe
	signal START					: std_logic;									-- informacja o nadawaniu
	signal ERROR					: std_logic;									-- obserwowane wyjscie 'ERROR'
	signal DONE						: std_logic;									-- obserwowane wyjscie 'DONE'
	signal D	:std_logic_vector(WORD_LEN-1 downto 0) := "00000000";		-- obserwowana dana wyjsciowa
	signal WRITING					: bit;											-- obserwowane wyjscie 'WRITING'
	signal TIMER_OUT				: natural range 0 to CLOCK_SPEED/BOD;	-- obserwowane wyjscie 'TIMER_OUT'
	signal STATUS_OUT				: STATUSY;										-- obserwowane wyjscie 'STATUS_OUT'
	signal TRANSMITTING_PARITY	: std_logic := '0';							-- sygnal pomocniczy (do debugowania) informujacy o nadawaniu bitu parzystosci
  
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
		RX 		<= '0';																-- incjalizacja sygnalu 'RX' na wartosci spoczynkowa
		SLOWO 	<= "00111001";														-- inicjalizacja slowa wejsciowego
		wait for 200 ns;																-- odczekanie 200 ns
		loop																				-- rozpoczecie petli nieskonczonej
			START <= '1';																-- ustawienie 'START' na wartosc bitu START
			wait for O_BITU;															-- odczekanie jednego bodu
			for i in 0 to WORD_LEN - 1 loop										-- petla po kolejnych bitach slowa danych 'D'
				RX <= SLOWO(i);														-- ustawienie 'RX' na wartosc bitu 'D(i)'
				wait for O_BITU;														-- odczekanie jednego bodu
			end loop;																	-- zakonczenie petli
			START					 	<= '0';											-- wylaczenie bitu nadawania danej
			TRANSMITTING_PARITY 	<= '1';											-- wlaczenie bitu nadawania parzystosci
			if (par_len = 1) then													-- badanie aktywowania bitu parzystosci
				RX<= XOR_REDUCE(SLOWO);												-- ustawienie 'RX' na wartosc bitu parzystosci	
				wait for O_BITU;														-- odczekanie jednego bodu
			end if;																		-- zakonczenie instukcji warunkowej
			TRANSMITTING_PARITY <='0';												-- wylaczenie bitu nadawania parzystosci
			for i in 0 to STOP_LEN - 1 loop										-- petla po liczbie bitow STOP
				RX <= '0';																-- ustawienie 'RX' na wartosc bitu STOP
				wait for O_BITU;														-- odczekanie jednego bodu
			end loop;																	-- zakonczenie petli
			SLOWO <= SLOWO + 7;														-- zwiekszenia SLOWA o 7
			wait for 10 * O_ZEGARA;													-- odczekanie 10-ciu okresow zegara
		end loop;																		-- zakonczenie petli
	end process;																		-- zakonczenie procesu
  
	RECEIVER_INST: entity work.RECEIVER											-- instancja odbiornika szeregowego 'RECEIVER'
		generic map(																	-- mapowanie parametrow biezacych
			CLOCK_SPEED				=> CLOCK_SPEED,								-- czestotliwosc zegata w [Hz]
			BOD						=> BOD,											-- predkosc odbierania w [bodach]
			WORD_LEN					=> WORD_LEN,									-- liczba bitow slowa danych (5-8)
			PAR_LEN					=> PAR_LEN,										-- liczba bitow parzystosci (0-1)
			STOP_LEN					=> STOP_LEN										-- liczba bitow stopu (1-2)
		)
		port map(																		-- mapowanie sygnalow do portow
			R							=> R,												-- sygnal resetowania
			C							=> C,												-- zegar taktujacy
			D							=> D,												-- slowo danych
			RX							=> RX,											-- odebrany sygnal szeregowy
			START						=> START,										-- informacja o rozpoczeciu nadawania
			ERROR						=> ERROR,										-- flaga wykrycia bledu w odbiorze
			DONE						=> DONE,											-- flaga zakonczenia odbioru
			WRITING					=> WRITING,										-- flaga pisania
			TIMER_OUT				=> TIMER_OUT,									-- obserwowany licznik zegara
			STATUS_OUT				=> STATUS_OUT									-- obserwowany status
		);

end behavioural;