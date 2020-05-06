library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_misc.all;

entity RECEIVER_TB is
  generic (
    constant clock_speed   :natural := 20_000_000;		-- czestotliwosc zegara systemowego w [Hz]
    constant bod       		:natural := 5_000_000;		-- predkosc nadawania w [bodach]
    constant word_len      :natural := 8;			-- liczba bitow slowa danych (5-8)
    constant par_len    	:natural := 1;			-- liczba bitow parzystosci (0-1)
    constant stop_len      :natural := 2;			-- liczba bitow stopu (1-2)
    constant N_RX          :boolean := FALSE;			-- negacja logiczna sygnalu szeregowego
    constant N_SLOWO       :boolean := FALSE			-- negacja logiczna slowa danych
  );
end RECEIVER_TB;

architecture behavioural of RECEIVER_TB is
  
  constant O_ZEGARA	:time := 1 sec/clock_speed;		-- okres zegara systemowego
  constant O_BITU	:time := 1 sec/bod;			-- okres czasu trwania jednego bodu

  signal   R		:std_logic := '0';			-- symulowany sygnal resetujacacy
  signal   C		:std_logic := '1';			-- symulowany zegar taktujacy inicjowany na '1'
  signal   RX		:std_logic;				-- symulowane wejscie 'RX'
  signal   SLOWO	:std_logic_vector(B_SLOWA-1 downto 0);	-- obserwowane wyjscie 'SLOWO'
  signal   VAL	   :std_logic;				-- obserwowane wyjscie 'GOTOWE'
  signal   ERROR	:std_logic;				-- obserwowane wyjscie 'GOTOWE'
  signal   DONE	:std_logic;				-- obserwowane wyjscie 'BLAD'
  signal   D		:std_logic_vector(SLOWO'range);		-- symulowana dana transmitowana
  
begin

 process is							-- proces bezwarunkowy
  begin								-- czesc wykonawcza procesu
    R <= '1'; wait for 100 ns;					-- ustawienie sygnalu 'res' na '1' i odczekanie 100 ns
    R <= '0'; wait;						-- ustawienie sygnalu 'res' na '0' i zatrzymanie
  end process;							-- zakonczenie procesu

  process is							-- proces bezwarunkowy
  begin								-- czesc wykonawcza procesu
    C <= not(C); wait for O_ZEGARA/2;				-- zanegowanie sygnalu 'clk' i odczekanie pol okresu zegara
  end process;							-- zakonczenie procesu
  
  process is							-- proces bezwarunkowy
    function neg(V :std_logic; N :boolean) return std_logic is	-- deklaracja funkcji wewnetrznej 'neg'
    begin							-- czesc wykonawcza funkcji wewnetrznej
      if (N=FALSE) then return (V); end if;			-- zwrot wartosc 'V' gdy 'N'=FALSE
      return (not(V));						-- zwrot zanegowanej wartosci 'V'
    end function;						-- zakonczenie funkcji wewnetrznej
  begin								-- czesc wykonawcza procesu
    TX <= neg('0',N_RX);					-- incjalizacja sygnalu 'RX' na wartosci spoczynkowa
    D  <= (others => '0');					-- wyzerowanie sygnalu 'D'
    wait for 200 ns;						-- odczekanie 200 ns
    loop							-- rozpoczecie petli nieskonczonej
      TX <= neg('1',N_RX);					-- ustawienie 'RX' na wartosc bitu START
      wait for O_BITU;						-- odczekanie jednego bodu
      for i in 0 to word_len-1 loop				-- petla po kolejnych bitach slowa danych 'D'
        TX <= neg(neg(D(i),N_SLOWO),N_RX);			-- ustawienie 'RX' na wartosc bitu 'D(i)'
        wait for O_BITU;					-- odczekanie jednego bodu
      end loop;							-- zakonczenie petli
      if (par_len = 1) then				-- badanie aktywowania bitu parzystosci
        TX<= neg(neg(XOR_REDUCE(D),N_SLOWO),N_RX);		-- ustawienie 'RX' na wartosc bitu parzystosci	
        wait for O_BITU;					-- odczekanie jednego bodu
      end if;							-- zakonczenie instukcji warunkowej
      for i in 0 to stop_len-1 loop				-- petla po liczbie bitow STOP
        TX <= neg('0',N_RX);					-- ustawienie 'RX' na wartosc bitu STOP
        wait for O_BITU;					-- odczekanie jednego bodu
      end loop;							-- zakonczenie petli
      D <= D + 7;						-- zwiekszenia wartosci 'D' o 7
      wait for 10*O_ZEGARA;					-- odczekanie 10-ciu okresow zegara
    end loop;							-- zakonczenie petli
  end process;							-- zakonczenie procesu
  
  RECEIVER_INST: entity work.RECEIVER				-- instancja odbiornika szeregowego 'SERIAL_RX'
    generic map(						-- mapowanie parametrow biezacych
      clock_speed     	 	=> clock_speed,				-- czestotliwosc zegata w [Hz]
      bod             	 	=> bod,				-- predkosc odbierania w [bodach]
      word_len         		=> word_len,				-- liczba bitow slowa danych (5-8)
      par_len        		=> par_len,			-- liczba bitow parzystosci (0-1)
      stop_len     	    	=> stop_len				-- liczba bitow stopu (1-2)
  --  N_RX        	   	=> N_RX,				-- negacja logiczna sygnalu szeregowego
  --  N_SLOWO        		=> N_SLOWO				-- negacja logiczna slowa danych
    )
    port map(							-- mapowanie sygnalow do portow
      R                    => R,				-- sygnal resetowania
      C                    => C,				-- zegar taktujacy
		D							=> D,
		RX                   => RX,				-- odebrany sygnal szeregowy
      VAL                	=> VAL,				-- odebrane slowo danych
      ERROR               	=> ERROR,				-- flaga potwierdzenia odbioru
      DONE                 => DONE				-- flaga wykrycia bledu w odbiorze

    );

end behavioural;