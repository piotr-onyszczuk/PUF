library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use     ieee.std_logic_unsigned.all;
use		work.package_types.all;													-- dolaczenie pakietu z typami 

entity OPERACJE is
	generic (			
		WORD_LEN  		: natural := 8 ;												-- dlugosc slowa wejsciowego
		CLOCK_SPEED		: natural := 20_000_000;									-- czestotliwosc zegara
		BOD 				: natural := 5_000_000;										-- predkosc nadawania
		MAX_NUM_LEN    : natural := 5;													-- maksymalna dlugosc liczby
		MAX_ARGS			: natural := 5
	);
	port (
		CALC_D_IN		: in std_logic_vector (WORD_LEN - 1 downto 0);		-- wejscie danych 'D'
		C    				: in std_logic; 												-- clock
		R    				: in std_logic; 												-- reset
		PASS				: in std_logic; 												-- mozna czytac liczbe/znak
		DONE				: out std_logic;												-- informacja o zwrocie
		RESULT			: out natural;													-- wynik/otrzymanyznak
		STATUS_OUT		: out STATUSES;
		OPERAND_OUT		: out OPERANDS;
		ARGS_OUT			: out TAB_I (MAX_ARGS downto 0);
		OPERATIONS_OUT	: out TAB_O (MAX_ARGS downto 0)
	);
end OPERACJE;

architecture cialo of OPERACJE is
	signal STATUS 	: STATUSES;														-- status progaramu
	signal SIZE		: natural range 0 to MAX_NUM_LEN;						-- licznik pozycji w slowie
	signal TIMER 	: natural range 0 to CLOCK_SPEED/BOD;					-- licznik zegara
	constant TIME_T: natural := CLOCK_SPEED/BOD;								-- limit zegara
	constant NUM_CO: natural := 48;
	constant PL_CO : natural := 43;
	constant SU_CO : natural := 45;
	constant RES_CO: natural := 61;
	constant ERR_CO: natural := 69;
	constant BROP_CO: natural := 40; --bracket open
	constant BRCL_CO: natural := 41; -- bracket close
	signal WAS_READ : std_logic := '0';
	signal READ_NUM : std_logic := '0';
	signal ARG_READING : std_logic := '0';
	signal BRACKET_OPEN : std_logic := '0';
	signal CURR_SIGN : OPERANDS := NONE;
	signal ARGUMENTS : TAB_I(MAX_ARGS downto 0) := (others => 0);
	signal ARGS_COUNT : natural :=0;
	signal OST_CYFRA: natural := 0;
	signal OPERATIONS :TAB_O (MAX_ARGS downto 0) := (others => NONE);
	signal OPS_COUNT : natural :=0;
begin
	process (C, R) is
	variable D		: natural :=0;
   begin
		if (R = '1') then																	-- resetowanie zmiennych						
			ARGS_COUNT <= 0;
			OPS_COUNT <= 0;
			SIZE <=0;
			STATUS 	<= ARGUMENTY;
			DONE     <= '0';
			TIMER 	<= 0;
			RESULT   <= 0;
			WAS_READ	<= '0';
			READ_NUM <= '0';
			ARG_READING <= '0';
			BRACKET_OPEN <= '0';
		elsif (C'event and C='1') then
			D := CONV_INTEGER(CALC_D_IN);
			if (STATUS = ARGUMENTY) then
				if (PASS = '1' and WAS_READ = '0') then
					WAS_READ <= '1';
					if (D = PL_CO) then
						if (ARG_READING = '0' and BRACKET_OPEN = '0') then -- sprawdzenie czy nie ma dwoch operatorow po kolei							
							RESULT <= ERR_CO;
						end if;
						if (BRACKET_OPEN = '1') then
							if (CURR_SIGN = NONE) then
								CURR_SIGN <= PLUS;
							else -- nie moze byc dwoch operatorow pod nawiasem
								RESULT <= ERR_CO;
							end if;
						else
							ARG_READING <= '0';
							ARGUMENTS(ARGUMENTS'left downto 1) <= ARGUMENTS(ARGUMENTS'left-1 downto 0);
							OPERATIONS(0) <= PLUS;
							OPERATIONS(OPERATIONS'left downto 1) <= OPERATIONS(OPERATIONS'left-1 downto 0);
							WAS_READ <= '1';
							OPS_COUNT <= OPS_COUNT + 1;
							SIZE <= 0;
						end if;
					elsif (D = SU_CO) then
						if (ARG_READING = '0' and BRACKET_OPEN = '0') then -- sprawdzenie czy nie ma dwoch operatorow po kolei
							RESULT <= ERR_CO;
						end if;
						if (BRACKET_OPEN = '1') then
							if (CURR_SIGN = NONE) then
								CURR_SIGN <= MINUS;
							else -- nie moze byc dwoch operatorow pod nawiasem
								RESULT <= ERR_CO;
							end if;
						else
							ARG_READING <= '0';
							OPERATIONS(0) <= MINUS;
							OPERATIONS(OPERATIONS'left downto 1) <= OPERATIONS(OPERATIONS'left-1 downto 0);
							ARGUMENTS(ARGUMENTS'left downto 1) <= ARGUMENTS(ARGUMENTS'left-1 downto 0);
							WAS_READ <= '1';
							OPS_COUNT <= OPS_COUNT + 1;
							SIZE <= 0;
						end if;
					elsif (D = BROP_CO) then
						if(ARG_READING = '1' or BRACKET_OPEN = '1') then -- nie mozna otworzyc nawiasu w trakcie liczby ani przed zamknieciem poprzedniego
							RESULT <= ERR_CO;
						end if;
							BRACKET_OPEN <= '1';
					elsif (D = BRCL_CO) then
						if(ARG_READING = '0' or BRACKET_OPEN = '0') then -- nie mozna zamknac nawiasu bezposrednio po operatorze ani przed otwarciem nawiasu
							RESULT <= ERR_CO;
						end if;
							BRACKET_OPEN <= '0';
							if (CURR_SIGN = RET) then -- blad
								RESULT <= ERR_CO;
							end if;
							if (CURR_SIGN = MINUS) then
								ARGUMENTS(0) <= -ARGUMENTS(0);
							end if;
							CURR_SIGN <= NONE;
					elsif (D = RES_CO) then
						if (ARG_READING = '0') then -- sprawdzenie czy nie ma dwoch operatorow po kolei							
							RESULT <= ERR_CO;
						end if;
						if (BRACKET_OPEN = '1') then -- nalezy zamknac nawias przed '='
							RESULT <= ERR_CO;
						end if;
						ARG_READING <= '0';
--						OPERATIONS(OPERATIONS'left-1 downto 0) <= OPERATIONS(OPERATIONS'left downto 1);
						SIZE 		<= 0;
						STATUS 	<= WYNIK;
					elsif (D >= NUM_CO and D < (NUM_CO + 10)) then
							if (ARG_READING = '0') then
								ARG_READING <= '1';
								ARGS_COUNT <= ARGS_COUNT + 1;
							end if;
							if (SIZE /= 0) then
								ARGUMENTS(0) <= 10 * ARGUMENTS(0);
							else
								ARGUMENTS(0) <= 0;
							end if;
							OST_CYFRA <=  D - NUM_CO;
							READ_NUM <='1';
							SIZE <= SIZE + 1;
					else
						RESULT <= ERR_CO;
					end if;
				elsif (PASS = '0') then
					WAS_READ <= '0';
					if(READ_NUM = '1') then
						READ_NUM <= '0';
						ARGUMENTS(0) <= ARGUMENTS(0) + OST_CYFRA;
					end if;
				end if;
			elsif (STATUS = WYNIK) then
				STATUS <= WYNIK; -- TODO
			else
				SIZE 		<= 0;
				STATUS 	<= ARGUMENTY;
				DONE     <= '0';
				TIMER 	<= 0;
				RESULT   <= ERR_CO;
				WAS_READ	<= '0';
				READ_NUM <= '0';
				ARG_READING <= '0';
				BRACKET_OPEN <= '0';
				ARGS_COUNT <= 0;
				OPS_COUNT <= 0;
				SIZE <= 0;
			end if;
		end if;
		STATUS_OUT <= STATUS;
		ARGS_OUT	<= ARGUMENTS;
		OPERATIONS_OUT <= OPERATIONS;
	end process;

end cialo;

