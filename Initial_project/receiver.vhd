library ieee;					-- klauzula dostepu do biblioteki 'IEEE'
use     ieee.std_logic_1164.all;		-- dolaczenie calego pakietu 'STD_LOGIC_1164'
use     ieee.std_logic_arith.all;		-- dolaczenie calego pakietu 'STD_LOGIC_ARITH'
use 	  ieee.std_logic_misc.all;
use 	  work.package_types.all;

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
	 pisze :out bit;
	 TIMER_OUT: out natural range 0 to clock_speed/bod;
	 status_out: out STATUSY
  );
end RECEIVER;

architecture cialo of RECEIVER is		-- deklaracja ciala 'cialo' architektury
	
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
					timer <= 1;
					if (S = word_len-1) then
						pisze<='0';
						status <= parzystosc;
					else
						pisze<='1';
					end if;
					if ( S /= word_len ) then
						bufor(S) <= RX;
						S <= (S+1);
					end if;			
				end if;
			
		elsif (status = parzystosc) then
				if (timer /= time_t) then 
					timer <= timer +1;
				else
					timer <= 1;
					if (RX /= XOR_REDUCE(bufor)) then
						blad := '1';
					end if;
					status <= stop;
				end if;

		elsif (status = stop) then
				if ( STOP_P /= stop_len) then
					if (timer /= time_t) then 
						timer <= timer +1;
					else
						timer <= 1;
						STOP_P <= STOP_P + 1;
						if(blad /= '1') then
							DONE <= '1';
						end if;
					end if;
				else
					status <= czekaj;
				end if;
		elsif (status = czekaj and VAL = '1') then
				timer <= 1;
				S <= 0;
				bufor <= (others => '0');
				STOP_P <= 0;
				status <= data;
				DONE <= '0';
		end if;
	end if;
	ERROR <= blad;
	D <= bufor;
	TIMER_OUT <=timer;
	status_out <= status;
   end process ;

end cialo;					-- zakonczenie ciala architektonicznego
