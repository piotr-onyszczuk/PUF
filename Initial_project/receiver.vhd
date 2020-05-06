library ieee;					-- klauzula dostepu do biblioteki 'IEEE'
use     ieee.std_logic_1164.all;		-- dolaczenie calego pakietu 'STD_LOGIC_1164'
use     ieee.std_logic_arith.all;		-- dolaczenie calego pakietu 'STD_LOGIC_ARITH'
use 	  ieee.std_logic_misc.all;

entity RECEIVER is				-- deklaracja sprzegu IEEE_CONV'
  generic (
	 word_len  :natural := 8 ;
	 clock_speed :natural := 20_000_000;
	 bod : natural := 5_000_000;
	 par_len  :natural := 1 ;
	 stop_len : natural := 2;
	 f_par : bit := '0'
  );
  port (
    D		: out  std_logic_vector ( word_len - 1 downto 0  );	-- wejscie danych 'D'
	 C    :in  std_logic; --clock
	 R    :in  std_logic; --reset
    RX		:in std_logic;	-- wejscie danych 'RX'
    VAL		:in std_logic;	-- wejscie nadaje
	 ERROR : out std_logic; --error
	 DONE : out std_logic; --gotowe
	 pisze :out bit
  );
end RECEIVER;

architecture cialo of RECEIVER is		-- deklaracja ciala 'cialo' architektury
	type STATUSY is (czekaj, data, parzystosc, stop);
	signal status : STATUSY;
	signal S : natural range 0 to word_len;
	signal STOP_P : natural range 0 to stop_len;
	signal timer : natural range 0 to clock_speed/bod;
	constant time_t : natural := clock_speed/bod;
	signal   bufor	:std_logic_vector(D'range);	
begin						-- poczatek czesci wykonawczej

	
  process (C, R) is
  variable blad : std_logic := '0';
   begin
	if (R = '1') then
			S <= 0;
			STOP_P <= 0;
			status <= czekaj;
			blad := '0';
			DONE <= '0';
			timer <= 0;
			pisze <='0';
			bufor <=(others => '0');
			D <= (others =>'0');
	elsif (C'event and C='1') then 
		if  (status = data) then

				if (timer /= time_t) then 
					timer <= timer +1;
				else
					timer <= 0;
					if ( S /= word_len ) then
						bufor(S) <= RX;
						S <= S+1;
						pisze <= '1';
					else
						pisze<='0';
						status <= parzystosc;
					end if;
				end if;
			
		elsif (status = parzystosc) then
				if (timer /= time_t) then 
					timer <= timer +1;
				else
					timer <= 0;
					if ( 1 = par_len) then
						if (RX = XOR_REDUCE(bufor)) then
							blad := '1';
						end if;
					else		
						status <= stop;
					end if;
				end if;

		elsif (status = stop) then
				if (timer /= time_t) then 
					timer <= timer +1;
				else
					timer <= 0;
					if ( STOP_P /= stop_len) then
						STOP_P <= STOP_P + 1;
					else 
						if(blad /= '1') then
							DONE <= '1';
						end if;
						status <= czekaj;
					end if;
				end if;
		elsif (status = czekaj and VAL = '1') then
			if (timer /= time_t) then 
				timer <= timer +1;
			else
				timer <= 0;
				S <= 0;
				bufor <= (others => '0');
				STOP_P <= 0;
				status <= data;
			end if;
		end if;
	end if;
	ERROR <= blad;
	D <= bufor;
   end process ;

end cialo;					-- zakonczenie ciala architektonicznego
