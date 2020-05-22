library	ieee;																			-- klauzula dostepu do biblioteki 'IEEE'
use		ieee.std_logic_1164.all;												-- dolaczenie calego pakietu 'STD_LOGIC_1164'
use		ieee.std_logic_arith.all;												-- dolaczenie calego pakietu 'STD_LOGIC_ARITH'
use		ieee.std_logic_misc.all;												-- dolaczenie calego pakietu 'STD_LOGIC_MISC'
use		work.package_types.all;													-- dolaczenie pakietu z typami 

entity RECEIVER is																	-- deklaracja sprzegu RECEIVER
	generic (
		WORD_LEN			: natural := 8;											-- dlugosc slowa wejsciowego
		CLOCK_SPEED		: natural := 20_000_000;								-- czestotliwosc zegara
		BOD				: natural := 5_000_000;									-- predkosc nadawania
		STOP_LEN 		: natural := 2												-- dlugosc 
	);
	port (
		C					: in std_logic;											-- clock
		R					: in std_logic;											-- reset
		RX					: in std_logic;											-- wejscie danych 'RX'
		START				: in std_logic;											-- wejscie nadaje
		D					: out std_logic_vector (WORD_LEN - 1 downto 0);	-- wyjscie danych 'D'
		ERROR				: out std_logic;											-- error
		DONE				: out std_logic;											-- gotowe
		WRITING			: out bit;													-- pisze
		TIMER_OUT		: out natural range 0 to CLOCK_SPEED/BOD;			-- wyjscie licznika zegara
		STATUS_OUT		: out STATUSY												-- wyjscie statusu
	);
end RECEIVER;

architecture cialo of RECEIVER is												-- deklaracja ciala 'cialo' architektury

	signal STATUS	: STATUSY;														-- status progaramu
	signal S			: natural range 0 to WORD_LEN;							-- licznik pozycji w slowie
	signal STOP_P	: natural range 0 to STOP_LEN;							-- licznik bitow stopu
	signal TIMER	: natural range 0 to CLOCK_SPEED/BOD;					-- licznik zegara
	constant TIME_T: natural := CLOCK_SPEED/BOD;								-- limit zegara
	signal BUFOR	: std_logic_vector(D'range);								-- bufor przetrzymujacy wynik
	signal ERROR_B	: std_logic := '0';											-- informacja o bledzie (bufor)

begin																						-- poczatek czesci wykonawczej
	process (C, R) is
	begin
		if (R = '1') then																-- resetowanie zmiennych						
			S			<= 0;
			STOP_P	<= 0;
			STATUS	<= czekaj;
			ERROR_B	<= '0';
			DONE		<= '0';
			TIMER		<= 0;
			WRITING	<= '0';
			BUFOR		<= (others => '0');
			D			<= (others =>'0');

		elsif (C'event and C='1') then											-- praca synchroniczna
			if (STATUS = czekaj and START = '1') then							-- czekanie na start
				TIMER		<= 1;
				S			<= 0;
				BUFOR		<= (others => '0');
				STOP_P	<= 0;
				STATUS	<= data;
				DONE		<= '0';
				ERROR_B	<= '0';

			elsif (STATUS = data) then												-- wczytywanie danych
				if (TIMER /= TIME_T) then 
					TIMER <= TIMER +1;
					if (TIMER = 1 and S /= WORD_LEN) then
						BUFOR(S) <= RX;
					end if;
				else
					TIMER <= 1;
					if (S = WORD_LEN-1) then
						WRITING <= '0';
						STATUS <= parzystosc;
					else
						WRITING <= '1';
					end if;
					if (S /= WORD_LEN) then
						S <= (S + 1);
					end if;
				end if;

			elsif (STATUS = parzystosc) then										-- sprawdzenie parzystosci
				if (TIMER /= TIME_T) then 
					TIMER <= TIMER + 1;
					if (TIMER = 1 and RX /= XOR_REDUCE(BUFOR)) then
						ERROR_B <= '1';
					end if;
				else
					timer <= 1;
					STATUS <= stop;
				end if;

			elsif (STATUS = stop) then												-- odczekanie bitow stopu
				if (STOP_P /= STOP_LEN) then
					if (TIMER /= TIME_T) then 
						TIMER <= TIMER + 1;
						if (TIMER = 1 and RX /= '0') then
							ERROR_B <= '1';
						end if;
					else
						TIMER <= 1;
						STOP_P <= STOP_P + 1;
						if(ERROR_B /= '1') then
							DONE <= '1';
						end if;
					end if;
				else
					STATUS <= czekaj;
				end if;

			else
					TIMER		<= 1;
					S			<= 0;
					BUFOR		<= (others => '0');
					STOP_P	<= 0;
					STATUS	<= czekaj;
					DONE		<= '0';
					ERROR_B	<= '0';
			end if;

		end if;

		ERROR			<= ERROR_B;														-- przypisanie buforow do wyjscia
		D				<= BUFOR;
		TIMER_OUT	<= TIMER;
		STATUS_OUT	<= STATUS;

	end process;

end cialo;																				-- zakonczenie ciala architektonicznego
