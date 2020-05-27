library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fpga is
	generic (
		constant CLOCK_SPEED		: natural := 200_000_000;					-- czestotliwosc zegara systemowego w [Hz]
		constant BOD				: natural := 20_000_000;					-- predkosc nadawania w [bodach]
		constant WORD_LEN			: natural := 8;								-- liczba bitow slowa danych (5-8)
		constant WORD_LEN_RES	: natural := 32;								-- liczba bitow slowa danych (5-32)
		constant STOP_LEN			: natural := 2;								-- liczba bitow stopu (1-2)
		constant MAX_ARGS			: natural := 5									-- maksymalna liczba argumentow zadania
	);
	
	port (
		C					: in std_logic; 											-- clock
		R					: in std_logic; 											-- reset
		START				: in std_logic;											-- wejscie nadaje
		RX				   : in std_logic;											-- wejscie nadaje
		TX					: out std_logic;											-- wyjscie danych 'TX'
		TRANSMITTING	: out std_logic;											-- wyjscie nadaje
		ERROR_REC      : out std_logic;											-- wyjscie bledu receivera
		ERROR_CALC     : out std_logic											-- wyjscie bledu kalkulatora
	);
end fpga;

architecture cialo of fpga is
	signal DONE_TX					: std_logic;									-- obserwowane wyjscie 'DONE' nadajnika
	signal DONE_RX					: std_logic;									-- obserwowane wyjscie 'DONE' odbiornika
	signal D_OUT:std_logic_vector(WORD_LEN-1 downto 0) :="00000000";	-- obserwowane slowo wyjsciowe
	signal DONE_CALC				: std_logic;									-- obserwowane wyjscie 'DONE' kalkulatora
	signal RESULT			: std_logic_vector(WORD_LEN_RES-1 downto 0); -- wynik obliczen kalkulatora
begin

	RECEIVER_INST: entity work.RECEIVER											-- instancja odbiornika szeregowego 'RECEIVER'
		generic map(																	-- mapowanie parametrow biezacych
			CLOCK_SPEED				=> CLOCK_SPEED,								-- czestotliwosc zegara w [Hz]
			BOD						=> BOD,											-- predkosc odbierania w [bodach]
			WORD_LEN					=> WORD_LEN,									-- liczba bitow slowa danych (5-8)
			STOP_LEN					=> STOP_LEN										-- liczba bitow stopu (1-2)
		)
		port map(																		-- mapowanie sygnalow do portow
			R							=> R,												-- sygnal resetowania
			C							=> C,												-- zegar taktujacy
			D							=> D_OUT,										-- slowo danych
			RX							=> RX,											-- odbierany sygnal szeregowy
			START						=> START,										-- informacja o rozpoczeciu nadawania
			ERROR						=> ERROR_REC,									-- flaga wykrycia bledu w odbiorze
			DONE						=> DONE_RX										-- flaga zakonczenia odbioru
		);
		
	KALKULATOR_INST: entity work.KALKULATOR									-- instancja kalkulatora
		generic map(																	-- mapowanie parametrow biezacych
			MAX_ARGS					=> MAX_ARGS,									-- maksymalna liczba argumentow zadania
			WORD_LEN					=> WORD_LEN										-- dlugosc slowa wejsciowego
		)
		port map(																		-- mapowanie sygnalow do portow
			R							=> R,												-- sygnal resetowania
			C							=> C,												-- zegar taktujacy
			CALC_D_IN				=> D_OUT,										-- slowo danych
			RECEIVED				   => DONE_TX,									-- potwierdzenie wyslania
			PASS						=> DONE_RX,										-- odbierany sygnal szeregowy
			DONE						=> DONE_CALC,									-- obserwowane wyjscie 'DONE' kalkulatora
			RESULT					=> RESULT,										-- rezultat obliczen
			ERR_OUT              => ERROR_CALC									-- obserwowane bledy kalkulatora
		);
		
	SENDER_INST: entity work.SENDER												-- instancja odbiornika szeregowego 'SENDER'
		generic map(																	-- mapowanie parametrow biezacych
			CLOCK_SPEED				=> CLOCK_SPEED,								-- czestotliwosc zegara w [Hz]
			BOD						=> BOD,											-- predkosc odbierania w [bodach]
			WORD_LEN					=> WORD_LEN_RES,									-- liczba bitow slowa danych (5-8)
			STOP_LEN					=> STOP_LEN										-- liczba bitow stopu (1-2)
		)
		port map(																		-- mapowanie sygnalow do portow
			R							=> R,												-- sygnal resetowania
			C							=> C,												-- zegar taktujacy
			D							=> RESULT,										-- slowo danych
			TX							=> TX,										-- nadawany sygnal szeregowy
			START						=> DONE_CALC,									-- informacja o rozpoczeciu nadawania
			DONE						=> DONE_TX,									-- flaga zakonczenia nadawania danej
			TRANSMITTING			=> TRANSMITTING								-- informacja o nadawaniu
		);

end cialo;

