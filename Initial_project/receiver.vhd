library ieee;					-- klauzula dostepu do biblioteki 'IEEE'
use     ieee.std_logic_1164.all;		-- dolaczenie calego pakietu 'STD_LOGIC_1164'
use     ieee.std_logic_arith.all;		-- dolaczenie calego pakietu 'STD_LOGIC_ARITH'

entity RECEIVER is				-- deklaracja sprzegu IEEE_CONV'
  generic (
	 word_len  :natural := 8 ;
	 clock_speed :natural := 500_000_000;
	 bod : natural := 9600;
	 par_len  :natural := 1 ;
	 stop_len : natural := 2;
	 f_par : bit := '0'
  );
  port (
    D		:out  bit_vector ( word_len - 1 downto 0  );	-- wejscie danych 'D'
	 C    :in  bit; --clock
	 R    :in  bit; --reset
    RX		:in bit;	-- wejscie danych 'RX'
    VAL		:in bit;	-- wejscie nadaje
	 ERROR : out bit; --error
	 DONE : out bit --gotowe
  );
end RECEIVER;

architecture cialo of RECEIVER is		-- deklaracja ciala 'cialo' architektury
	type STATUSY is (czekaj, data, parzystosc, stop);
	signal status : STATUSY;
	signal S : natural range 0 to word_len;
   signal PAR : natural range 0 to par_len;
	signal STOP_P : natural range 0 to stop_len;
	signal timer : natural range 0 to clock_speed/bod;
	constant time_t : natural := clock_speed/bod;
	variable blad : bit := '0';
begin						-- poczatek czesci wykonawczej

	
  process (C, R) is
   begin
	if (R = '1') then
			S <=word_len +1 ;
			STOP_P <= 0;
			PAR <= 0;
			status <= czekaj;
			blad := '0';
			DONE <= '0';
			timer <= 0;
	elsif (C'event and C='1') then 
		if (timer /= time_t) then 
			timer <= timer +1;
		else
		 timer <= 0;
		if  (status = data) then
			if ( S /= word_len ) then
				D(S) <= RX;
				S <= S+1;
			else
				status <= parzystosc;
			end if;
		elsif (status = parzystosc) then
			if ( PAR /= par_len) then
				PAR <= PAR+1;
				if (wejscie(1) = XOR_REDUCE(bufor)) then
					blad := '1';
				end if;
			else		
				status <= stop;
			end if;
		elsif (status = stop) then
			if ( STOP_P /= stop_len) then
				STOP_P <= STOP_P + 1;
			else 
				if(blad /= '1') then
					DONE <= '1';
				end if;
				status <= czekaj;
			end if;
		elsif (status = czekaj and VAL = '1') then
			S <= 0;
			D(S) <= (others => '0');
			STOP_P <= 0;
			PAR <= 0;
			status <= data;
		end if;
		end if;
	end if;
	ERROR <= blad;
   end process ;

end cialo;					-- zakonczenie ciala architektonicznego
