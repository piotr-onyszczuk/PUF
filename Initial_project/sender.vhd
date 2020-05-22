library	ieee;																			-- klauzula dostepu do biblioteki 'IEEE'
use		ieee.std_logic_1164.all;												-- dolaczenie calego pakietu 'STD_LOGIC_1164'
use		ieee.std_logic_arith.all;												-- dolaczenie calego pakietu 'STD_LOGIC_ARITH'
use		ieee.std_logic_misc.all;												-- dolaczenie calego pakietu 'STD_LOGIC_MISC'
use		work.package_types.all;													-- dolaczenie pakietu z typami 

entity SENDER is																		-- deklaracja sprzegu SENDER
	generic (
		WORD_LEN			: natural := 8;											-- dlugosc slowa wejsciowego
		CLOCK_SPEED		: natural := 20_000_000;								-- czestotliwosc zegara
		BOD				: natural := 5_000_000;									-- predkosc nadawania
		PAR_LEN			: natural := 1;											-- czy jest bit parzystosci
		STOP_LEN			: natural := 2												-- dlugosc 
	);
	port (
		D					: in std_logic_vector (WORD_LEN - 1 downto 0);	-- wejscie danych 'D'
		C					: in std_logic; 											-- clock
		R					: in std_logic; 											-- reset
		START				: in std_logic;											-- wejscie nadaje
		TX					: out std_logic;											-- wyjscie danych 'TX'
		DONE				: out std_logic; 											-- gotowe
		TRANSMITTING	: out std_logic;											-- wyjscie nadaje
		TIMER_OUT		: out natural range 0 to CLOCK_SPEED/BOD;			-- wyjscie licznika zegara
		STATUS_OUT		: out STATUSY; 											-- wyjscie statusu
		BIT_NUMBER		: out natural range 0 to WORD_LEN					-- numer bitu
	);
end SENDER;

architecture cialo of SENDER is													-- deklaracja ciala 'cialo' architektury

	signal STATUS		: STATUSY;													-- status progaramu
	signal S				: natural range 0 to WORD_LEN;						-- licznik pozycji w slowie
	signal STOP_P		: natural range 0 to STOP_LEN;						-- licznik bitow stopu
	signal TIMER		: natural range 0 to CLOCK_SPEED/BOD;				-- licznik zegara
	constant TIME_T	: natural := CLOCK_SPEED/BOD;							-- limit zegara
	signal BUFOR		: std_logic_vector(D'range);							-- bufor przetrzymujacy wejscie

begin																						-- poczatek czesci wykonawczej
	process (C, R) is
	begin
		if (R = '1') then																-- resetowanie zmiennych						
			S			<= 0;
			STOP_P	<= 0;
			STATUS	<= czekaj;
			DONE		<= '0';
			TIMER		<= 0;
			BUFOR		<=(others => '0');

		elsif (C'event and C='1') then											-- praca synchroniczna
			if (STATUS = czekaj and START = '1') then							-- czekanie na start
				TIMER <= 1;
				S <= 0;
				BUFOR <= D;
				STOP_P <= 0;
				STATUS <= data;
				DONE <= '0';
				TRANSMITTING <= '0';

			elsif (STATUS = data) then												-- nadawanie danych
				TRANSMITTING <= '1';
				TX <= BUFOR(S);
				if (TIMER /= TIME_T) then
					TIMER <= TIMER + 1;
				else
					TIMER <= 1;
					if (S = WORD_LEN-1) then
						STATUS <= parzystosc;
					end if;
					if (S /= WORD_LEN) then
						S <= (S + 1);
					end if;
				end if;

			elsif (STATUS = parzystosc) then										-- nadanie parzystosci
				TRANSMITTING <= '0';
				TX <= XOR_REDUCE(BUFOR);
				if (TIMER /= TIME_T) then 
					TIMER <= TIMER + 1;
				else
					timer <= 1;
					STATUS <= stop;
				end if;

			elsif (STATUS = stop) then												-- odczekanie bitow stopu
				TX <= '0';
				DONE <= '1';
				if ( STOP_P /= STOP_LEN) then
					if (TIMER /= TIME_T) then 
						TIMER <= TIMER + 1;
					else
						TIMER <= 1;
						STOP_P <= STOP_P + 1;
					end if;
				else
					STATUS <= czekaj;
				end if;

			else
				TIMER				<= 1;
				S					<= 0;
				BUFOR				<= (others => '0');
				STOP_P			<= 0;
				STATUS			<= czekaj;
				DONE				<= '0';
				TRANSMITTING	<= '0';
			end if;

		end if;

		TIMER_OUT	<= TIMER;
		STATUS_OUT	<= STATUS;
		BIT_NUMBER	<= S;

	end process;

end cialo;																			-- zakonczenie ciala architektonicznego
